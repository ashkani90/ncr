<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!$data || !isset($data['user_id'])) {
    jsonResponse(['success' => false, 'error' => 'شناسه کاربر الزامی است']);
}

$userId = (int)$data['user_id'];

// ⭐ همه اعلان‌های شخصی + عمومی
$sql = "SELECT id FROM notifications WHERE user_id = ? OR user_id IS NULL";
$notifications = fetchAll($sql, [$userId], 'i');

foreach ($notifications as $n) {
    $checkSql = "SELECT id FROM notification_reads WHERE notification_id = ? AND user_id = ?";
    $existing = fetchOne($checkSql, [$n['id'], $userId], 'ii');
    
    if ($existing) {
        $updateSql = "UPDATE notification_reads SET is_read = 1, read_at = NOW() 
                      WHERE notification_id = ? AND user_id = ?";
        executeQuery($updateSql, [$n['id'], $userId], 'ii');
    } else {
        $insertSql = "INSERT INTO notification_reads (notification_id, user_id, is_read, read_at) 
                      VALUES (?, ?, 1, NOW())";
        executeInsert($insertSql, [$n['id'], $userId], 'ii');
    }
}

jsonResponse(['success' => true, 'message' => 'همه اعلان‌ها خوانده شدند']);
?>