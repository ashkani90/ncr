<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!$data || !isset($data['notification_id']) || !isset($data['user_id'])) {
    jsonResponse(['success' => false, 'error' => 'notification_id و user_id الزامی است']);
}

$notification_id = (int)$data['notification_id'];
$user_id         = (int)$data['user_id'];
$is_read         = isset($data['is_read']) ? (int)$data['is_read'] : 1;

// بررسی وجود رکورد
$checkSql = "SELECT id FROM notification_reads 
             WHERE notification_id = ? AND user_id = ?";
$existing = fetchOne($checkSql, [$notification_id, $user_id], 'ii');

if ($existing) {
    if ($is_read) {
        $updateSql = "UPDATE notification_reads 
                      SET is_read = 1, read_at = NOW() 
                      WHERE notification_id = ? AND user_id = ?";
        executeQuery($updateSql, [$notification_id, $user_id], 'ii');
    } else {
        $updateSql = "UPDATE notification_reads 
                      SET is_read = 0, read_at = NULL 
                      WHERE notification_id = ? AND user_id = ?";
        executeQuery($updateSql, [$notification_id, $user_id], 'ii');
    }
} else {
    if ($is_read) {
        $insertSql = "INSERT INTO notification_reads (notification_id, user_id, is_read, read_at) 
                      VALUES (?, ?, 1, NOW())";
        executeInsert($insertSql, [$notification_id, $user_id], 'ii');
    } else {
        $insertSql = "INSERT INTO notification_reads (notification_id, user_id, is_read) 
                      VALUES (?, ?, 0)";
        executeInsert($insertSql, [$notification_id, $user_id], 'ii');
    }
}

// شمارش تعداد خوانده‌نشده‌ها
$countSql = "SELECT COUNT(*) as unread_count 
             FROM notifications n
             LEFT JOIN notification_reads nr 
                 ON n.id = nr.notification_id AND nr.user_id = ?
             WHERE (n.user_id = ? OR n.user_id IS NULL)
               AND COALESCE(nr.is_read, 0) = 0";
$countResult = fetchOne($countSql, [$user_id, $user_id], 'ii');
$unreadCount = $countResult ? (int)$countResult['unread_count'] : 0;

jsonResponse([
    'success'      => true,
    'is_read'      => $is_read,
    'unread_count' => $unreadCount
]);
?>