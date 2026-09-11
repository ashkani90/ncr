<?php
// فعال کردن نمایش خطاها برای دیباگ
error_reporting(E_ALL);
ini_set('display_errors', 1);

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

require_once '../config/database.php';

// تست اتصال به دیتابیس
$conn = getDBConnection();
if (!$conn) {
    jsonResponse(['success' => false, 'error' => 'خطا در اتصال به دیتابیس']);
}
$conn->close();

$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET':
        // دریافت لیست کاربران
        try {
            $sql = "SELECT id, username, full_name, email, role, department, language, created_at, last_login FROM users ORDER BY id";
            $users = fetchAll($sql);
            
            if ($users === false) {
                jsonResponse(['success' => false, 'error' => 'خطا در دریافت کاربران']);
            } else {
                jsonResponse(['success' => true, 'data' => $users]);
            }
        } catch (Exception $e) {
            jsonResponse(['success' => false, 'error' => $e->getMessage()]);
        }
        break;
        
    case 'POST':
        // ایجاد کاربر جدید
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
        
        if (empty($username) || empty($password) || empty($full_name)) {
            jsonResponse(['success' => false, 'error' => 'نام کاربری، رمز عبور و نام کامل الزامی است']);
        }
        
        // بررسی تکراری نبودن نام کاربری
        $checkSql = "SELECT COUNT(*) as count FROM users WHERE username = ?";
        $checkResult = fetchOne($checkSql, [$username], 's');
        if ($checkResult && $checkResult['count'] > 0) {
            jsonResponse(['success' => false, 'error' => 'نام کاربری قبلاً ثبت شده است']);
        }
        
        $sql = "INSERT INTO users (username, password, full_name, email, role, department, language) VALUES (?, ?, ?, ?, ?, ?, ?)";
        $result = executeInsert($sql, [$username, $password, $full_name, $email, $role, $department, $language], 'sssssss');
        
        if ($result) {
            jsonResponse(['success' => true, 'id' => $result, 'message' => 'کاربر با موفقیت ایجاد شد']);
        } else {
            jsonResponse(['success' => false, 'error' => 'خطا در ایجاد کاربر']);
        }
        break;
        
    case 'PUT':
        // بروزرسانی کاربر
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
        
        $sql = "UPDATE users SET full_name = ?, email = ?, role = ?, department = ?, language = ? WHERE id = ?";
        $result = executeQuery($sql, [$full_name, $email, $role, $department, $language, $id], 'sssssi');
        
        if ($result !== false) {
            jsonResponse(['success' => true, 'message' => 'کاربر با موفقیت بروزرسانی شد']);
        } else {
            jsonResponse(['success' => false, 'error' => 'خطا در بروزرسانی کاربر']);
        }
        break;
        
    case 'DELETE':
        // حذف کاربر
        $data = json_decode(file_get_contents('php://input'), true);
        if (!$data || !isset($data['id'])) {
            jsonResponse(['success' => false, 'error' => 'شناسه کاربر الزامی است']);
        }
        
        $id = (int)$data['id'];
        
        // جلوگیری از حذف کاربر admin
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