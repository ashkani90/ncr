<?php
error_reporting(E_ALL);
ini_set('display_errors', 0);
ini_set('log_errors', 1);

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

require_once '../config/database.php';

$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET':
        try {
            // ⭐ دریافت کاربران با نام نقش از جدول roles
            $sql = "SELECT u.id, u.user_id, u.username, u.full_name, u.email, 
                           u.role, u.department, u.language, u.avatar, u.created_at, u.last_login,
                           COALESCE(r.description, u.role) as role_description
                    FROM users u
                    LEFT JOIN roles r ON u.role = r.name
                    ORDER BY u.id";
            $users = fetchAll($sql);
            
            // ⭐ دریافت لیست نقش‌ها برای استفاده در فرم‌ها
            $rolesSql = "SELECT id, name, description FROM roles ORDER BY id";
            $roles = fetchAll($rolesSql);
            
            if ($users === false) {
                jsonResponse(['success' => false, 'error' => 'خطا در دریافت کاربران']);
            } else {
                jsonResponse([
                    'success' => true, 
                    'data' => $users,
                    'roles' => $roles  // ⭐ نقش‌های پویا
                ]);
            }
        } catch (Exception $e) {
            jsonResponse(['success' => false, 'error' => $e->getMessage()]);
        }
        break;
        
    case 'POST':
        $data = json_decode(file_get_contents('php://input'), true);
        if (!$data) {
            jsonResponse(['success' => false, 'error' => 'داده‌های ارسالی نامعتبر است']);
        }
        
        $username = trim($data['username'] ?? '');
        $password = trim($data['password'] ?? '');
        $full_name = trim($data['full_name'] ?? '');
        $email = trim($data['email'] ?? '');
        $role = trim($data['role'] ?? 'user');
        $department = trim($data['department'] ?? '');
        $language = trim($data['language'] ?? 'fa');
        $avatar = trim($data['avatar'] ?? '');
        
        if (empty($username) || empty($password) || empty($full_name)) {
            jsonResponse(['success' => false, 'error' => 'نام کاربری، رمز عبور و نام کامل الزامی است']);
        }
        
        // ⭐ بررسی اینکه نقش در جدول roles وجود دارد
        $roleCheck = fetchOne("SELECT id FROM roles WHERE name = ?", [$role], 's');
        if (!$roleCheck) {
            jsonResponse(['success' => false, 'error' => 'نقش انتخاب شده معتبر نیست']);
        }
        
        $checkSql = "SELECT COUNT(*) as count FROM users WHERE username = ?";
        $checkResult = fetchOne($checkSql, [$username], 's');
        if ($checkResult && $checkResult['count'] > 0) {
            jsonResponse(['success' => false, 'error' => 'نام کاربری قبلاً ثبت شده است']);
        }
        
        // تولید user_id یکتا
        $maxIdResult = fetchOne("SELECT MAX(user_id) as max_id FROM users");
        $nextUserId = ($maxIdResult && $maxIdResult['max_id']) ? ((int)$maxIdResult['max_id'] + 1) : 1001;
        
        $sql = "INSERT INTO users (user_id, username, password, full_name, email, role, department, language, avatar) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        $result = executeInsert($sql, [$nextUserId, $username, $password, $full_name, $email, $role, $department, $language, $avatar], 'issssssss');
        
        if ($result) {
            jsonResponse(['success' => true, 'id' => $result, 'user_id' => $nextUserId]);
        } else {
            jsonResponse(['success' => false, 'error' => 'خطا در ایجاد کاربر']);
        }
        break;
        
    case 'PUT':
        $data = json_decode(file_get_contents('php://input'), true);
        if (!$data || !isset($data['id'])) {
            jsonResponse(['success' => false, 'error' => 'شناسه کاربر الزامی است']);
        }
        
        $id = (int)$data['id'];
        $full_name = trim($data['full_name'] ?? '');
        $email = trim($data['email'] ?? '');
        $role = trim($data['role'] ?? 'user');
        $department = trim($data['department'] ?? '');
        $language = trim($data['language'] ?? 'fa');
        
        // ⭐ بررسی معتبر بودن نقش
        $roleCheck = fetchOne("SELECT id FROM roles WHERE name = ?", [$role], 's');
        if (!$roleCheck) {
            jsonResponse(['success' => false, 'error' => 'نقش انتخاب شده معتبر نیست']);
        }
        
        $sql = "UPDATE users SET full_name = ?, email = ?, role = ?, department = ?, language = ? WHERE id = ?";
        $params = [$full_name, $email, $role, $department, $language, $id];
        $types = 'sssssi';

        // اگر تصویر کاربر ارسال شده باشد، آن را هم بروزرسانی کن
        if (array_key_exists('avatar', $data)) {
            $sql = "UPDATE users SET full_name = ?, email = ?, role = ?, department = ?, language = ?, avatar = ? WHERE id = ?";
            $params = [$full_name, $email, $role, $department, $language, trim($data['avatar']), $id];
            $types = 'ssssssi';
        }

        $result = executeQuery($sql, $params, $types);
        
        if ($result !== false) {
            jsonResponse(['success' => true, 'message' => 'کاربر با موفقیت بروزرسانی شد']);
        } else {
            jsonResponse(['success' => false, 'error' => 'خطا در بروزرسانی کاربر']);
        }
        break;
        
    case 'DELETE':
        $data = json_decode(file_get_contents('php://input'), true);
        if (!$data || !isset($data['id'])) {
            jsonResponse(['success' => false, 'error' => 'شناسه کاربر الزامی است']);
        }
        
        $id = (int)$data['id'];
        
        $checkSql = "SELECT username FROM users WHERE id = ?";
        $user = fetchOne($checkSql, [$id], 'i');
        if ($user && $user['username'] === 'admin') {
            jsonResponse(['success' => false, 'error' => 'امکان حذف کاربر admin وجود ندارد']);
        }
        
        $sql = "DELETE FROM users WHERE id = ?";
        $result = executeQuery($sql, [$id], 'i');
        
        if ($result !== false) {
            jsonResponse(['success' => true, 'message' => 'کاربر با موفقیت حذف شد']);
        } else {
            jsonResponse(['success' => false, 'error' => 'خطا در حذف کاربر']);
        }
        break;
        
    default:
        jsonResponse(['success' => false, 'error' => 'متود غیرمجاز']);
        break;
}
?>