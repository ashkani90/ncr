<?php
// change_password.php - تغییر رمز عبور کاربر جاری
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

if (!$data || !isset($data['user_id'])) {
    jsonResponse(['success' => false, 'error' => 'شناسه کاربر الزامی است']);
}

$userId = (int)$data['user_id'];
$currentPassword = isset($data['current_password']) ? (string)$data['current_password'] : '';
$newPassword = isset($data['new_password']) ? (string)$data['new_password'] : '';

if ($userId <= 0) {
    jsonResponse(['success' => false, 'error' => 'کاربر نامعتبر است']);
}

if ($currentPassword === '' || $newPassword === '') {
    jsonResponse(['success' => false, 'error' => 'رمز عبور فعلی و جدید الزامی است']);
}

if (strlen($newPassword) < 6) {
    jsonResponse(['success' => false, 'error' => 'رمز عبور جدید باید حداقل ۶ کاراکتر باشد']);
}

if ($currentPassword === $newPassword) {
    jsonResponse(['success' => false, 'error' => 'رمز عبور جدید باید با رمز فعلی متفاوت باشد']);
}

$user = fetchOne("SELECT id FROM users WHERE id = ? AND password = ?", [$userId, $currentPassword], 'is');

if (!$user) {
    jsonResponse(['success' => false, 'error' => 'رمز عبور فعلی اشتباه است']);
}

$result = executeQuery("UPDATE users SET password = ? WHERE id = ?", [$newPassword, $userId], 'si');

if ($result === false) {
    jsonResponse(['success' => false, 'error' => 'خطا در تغییر رمز عبور']);
}

jsonResponse(['success' => true, 'message' => 'رمز عبور با موفقیت تغییر کرد']);
