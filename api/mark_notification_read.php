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

// ⭐ اگر رکورد وجود دارد، آپدیت کن؛ اگر ندارد، درج کن
$sql = "INSERT INTO notification_reads (notification_id, user_id, is_read, read_at) 
        VALUES (?, ?, 1, NOW())
        ON DUPLICATE KEY UPDATE is_read = 1, read_at = NOW()";

$conn = getDBConnection();
$stmt = $conn->prepare($sql);
$stmt->bind_param('ii', $notification_id, $user_id);
$success = $stmt->execute();
$stmt->close();
$conn->close();

if ($success) {
    jsonResponse(['success' => true]);
} else {
    jsonResponse(['success' => false, 'error' => 'خطا در بروزرسانی']);
}