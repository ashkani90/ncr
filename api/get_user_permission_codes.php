<?php
// get_user_permission_codes.php - دسترسی‌های سفارشی ذخیره‌شده برای یک کاربر
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

$userId = isset($_GET['user_id']) ? (int)$_GET['user_id'] : 0;

if ($userId <= 0) {
    jsonResponse(['success' => false, 'error' => 'شناسه کاربر الزامی است']);
}

$permissions = [];

try {
    // جدول دسترسی‌های سفارشی ممکن است هنوز ساخته نشده باشد
    $table = fetchOne("SHOW TABLES LIKE 'user_permissions'");

    if ($table) {
        $rows = fetchAll("SELECT permission_code FROM user_permissions WHERE user_id = ?", [$userId], 'i');
        $permissions = array_map(function ($row) {
            return $row['permission_code'];
        }, $rows);
    }
} catch (Exception $e) {
    $permissions = [];
}

jsonResponse([
    'success' => true,
    'permissions' => $permissions,
    'count' => count($permissions)
]);
