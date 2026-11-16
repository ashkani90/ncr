<?php
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
        // دریافت همه نقش‌ها با دسترسی‌هایشان
        $sql = "SELECT r.id, r.name, r.description,
                GROUP_CONCAT(p.code) as permissions
                FROM roles r
                LEFT JOIN role_permissions rp ON r.id = rp.role_id
                LEFT JOIN permissions p ON rp.permission_id = p.id
                GROUP BY r.id
                ORDER BY r.id";
        $roles = fetchAll($sql);
        
        // تبدیل permissions به آرایه
        foreach ($roles as &$role) {
            $role['permissions'] = $role['permissions'] 
                ? explode(',', $role['permissions']) 
                : [];
            $role['id'] = (int)$role['id'];
        }
        unset($role);
        
        jsonResponse(['success' => true, 'data' => $roles]);
        break;
        
    case 'PUT':
        // بروزرسانی دسترسی‌های یک نقش
        $data = json_decode(file_get_contents('php://input'), true);
        
        if (!$data || !isset($data['role_name'])) {
            jsonResponse(['success' => false, 'error' => 'role_name الزامی است']);
        }
        
        $roleName = $data['role_name'];
        $permissionCodes = $data['permissions'] ?? [];
        
        $conn = getDBConnection();
        
        // پیدا کردن role_id
        $stmt = $conn->prepare("SELECT id FROM roles WHERE name = ?");
        $stmt->bind_param('s', $roleName);
        $stmt->execute();
        $result = $stmt->get_result();
        $role = $result->fetch_assoc();
        $stmt->close();
        
        if (!$role) {
            $conn->close();
            jsonResponse(['success' => false, 'error' => 'نقش یافت نشد']);
        }
        
        $roleId = (int)$role['id'];
        
        // حذف دسترسی‌های قبلی
        $conn->query("DELETE FROM role_permissions WHERE role_id = $roleId");
        
        // افزودن دسترسی‌های جدید
        if (!empty($permissionCodes)) {
            $placeholders = implode(',', array_fill(0, count($permissionCodes), '?'));
            $types = str_repeat('s', count($permissionCodes));
            
            $sql = "INSERT INTO role_permissions (role_id, permission_id) 
                    SELECT ?, id FROM permissions WHERE code IN ($placeholders)";
            $stmt = $conn->prepare($sql);
            
            $params = array_merge([$roleId], $permissionCodes);
            $bindTypes = 'i' . $types;
            $stmt->bind_param($bindTypes, ...$params);
            $stmt->execute();
            $stmt->close();
        }
        
        $conn->close();
        
        jsonResponse(['success' => true, 'message' => 'دسترسی‌ها بروزرسانی شد']);
        break;
        
    case 'POST':
        // ایجاد نقش جدید
        $data = json_decode(file_get_contents('php://input'), true);
        
        if (!$data || empty($data['name'])) {
            jsonResponse(['success' => false, 'error' => 'نام نقش الزامی است']);
        }
        
        $name = trim($data['name']);
        $description = trim($data['description'] ?? '');
        $permissionCodes = $data['permissions'] ?? [];
        
        $conn = getDBConnection();
        
        // بررسی تکراری نبودن
        $stmt = $conn->prepare("SELECT id FROM roles WHERE name = ?");
        $stmt->bind_param('s', $name);
        $stmt->execute();
        if ($stmt->get_result()->fetch_assoc()) {
            $stmt->close();
            $conn->close();
            jsonResponse(['success' => false, 'error' => 'این نقش قبلاً وجود دارد']);
        }
        $stmt->close();
        
        // درج نقش
        $stmt = $conn->prepare("INSERT INTO roles (name, description) VALUES (?, ?)");
        $stmt->bind_param('ss', $name, $description);
        $stmt->execute();
        $roleId = $conn->insert_id;
        $stmt->close();
        
        // افزودن دسترسی‌ها
        if (!empty($permissionCodes)) {
            $placeholders = implode(',', array_fill(0, count($permissionCodes), '?'));
            $types = str_repeat('s', count($permissionCodes));
            
            $sql = "INSERT INTO role_permissions (role_id, permission_id) 
                    SELECT ?, id FROM permissions WHERE code IN ($placeholders)";
            $stmt = $conn->prepare($sql);
            $params = array_merge([$roleId], $permissionCodes);
            $bindTypes = 'i' . $types;
            $stmt->bind_param($bindTypes, ...$params);
            $stmt->execute();
            $stmt->close();
        }
        
        $conn->close();
        
        jsonResponse(['success' => true, 'id' => $roleId, 'message' => 'نقش ایجاد شد']);
        break;
        
    default:
        jsonResponse(['success' => false, 'error' => 'متود غیرمجاز']);
}
?>