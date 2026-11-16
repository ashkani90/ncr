<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

require_once '../config/database.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!$data || !isset($data['username']) || !isset($data['password'])) {
    jsonResponse(['success' => false, 'error' => 'نام کاربری و رمز عبور الزامی است']);
}

$username = trim($data['username']);
$password = trim($data['password']);

// ⭐ کوئری ۱: دریافت اطلاعات کاربر
$sql = "SELECT id, user_id, username, full_name, email, role, department, avatar, language 
        FROM users WHERE username = ? AND password = ?";

$user = fetchOne($sql, [$username, $password], 'ss');

if (!$user) {
    jsonResponse(['success' => false, 'error' => 'نام کاربری یا رمز عبور اشتباه است']);
}

// ⭐ کوئری ۲: دریافت نام نمایشی نقش از جدول roles
$roleSql = "SELECT description FROM roles WHERE name = ?";
$roleData = fetchOne($roleSql, [$user['role']], 's');

$roleDisplay = $roleData && !empty($roleData['description']) 
    ? $roleData['description'] 
    : $user['role'];

// ⭐ اضافه کردن role_display به کاربر
$user['role_display'] = $roleDisplay;

// بروزرسانی last_login
executeInsert("UPDATE users SET last_login = NOW() WHERE id = ?", [$user['id']], 'i');

// ⭐ دریافت دسترسی‌های کاربر
$permSql = "SELECT p.code 
            FROM permissions p
            JOIN role_permissions rp ON p.id = rp.permission_id
            JOIN roles r ON rp.role_id = r.id
            WHERE r.name = ?";
$permissions = fetchAll($permSql, [$user['role']], 's');
$permissionCodes = array_map(function($p) { return $p['code']; }, $permissions);

// ⭐ دریافت همه نقش‌ها
$rolesSql = "SELECT id, name, description FROM roles ORDER BY id";
$roles = fetchAll($rolesSql);

$user['id']      = (int)$user['id'];
$user['user_id'] = (int)$user['user_id'];

jsonResponse([
    'success' => true,
    'user' => $user,
    'permissions' => $permissionCodes,
    'roles' => $roles
]);
?>