<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

require_once '../config/database.php';

$userId = isset($_GET['user_id']) ? (int)$_GET['user_id'] : 0;

if ($userId <= 0) {
    jsonResponse(['success' => false, 'error' => 'user_id الزامی است']);
}

// ⭐ دریافت اطلاعات کاربر + نام نمایشی نقش از جدول roles
$sql = "SELECT u.id, u.user_id, u.username, u.full_name, u.role, u.department,
               COALESCE(r.description, u.role) as role_display
        FROM users u
        LEFT JOIN roles r ON u.role = r.name
        WHERE u.id = ?";
$user = fetchOne($sql, [$userId], 'i');

if (!$user) {
    jsonResponse(['success' => false, 'error' => 'کاربر یافت نشد']);
}

// دریافت دسترسی‌های نقش کاربر
$sql = "SELECT p.code, p.name, p.resource, p.action
        FROM permissions p
        JOIN role_permissions rp ON p.id = rp.permission_id
        JOIN roles r ON rp.role_id = r.id
        WHERE r.name = ?";

$permissions = fetchAll($sql, [$user['role']], 's');
$permissionCodes = array_map(function($p) { return $p['code']; }, $permissions);

// ⭐ دریافت لیست همه نقش‌ها (برای استفاده در UI)
$rolesSql = "SELECT id, name, description FROM roles ORDER BY id";
$roles = fetchAll($rolesSql);

jsonResponse([
    'success' => true,
    'user' => [
        'id' => (int)$user['id'],
        'user_id' => (int)$user['user_id'],
        'username' => $user['username'],
        'full_name' => $user['full_name'],
        'role' => $user['role'],
        'role_display' => $user['role_display'],  // ⭐ نام نمایشی
        'department' => $user['department']
    ],
    'permissions' => $permissionCodes,
    'roles' => $roles  // ⭐ همه نقش‌ها
]);
?>