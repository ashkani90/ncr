<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!$data || !isset($data['notification_id'])) {
    jsonResponse(['success' => false, 'error' => 'شناسه اعلان الزامی است']);
}

$sql = "UPDATE notifications SET is_read = 1 WHERE id = ?";
$result = executeQuery($sql, [$data['notification_id']], 'i');

if ($result !== false) {
    jsonResponse(['success' => true]);
} else {
    jsonResponse(['success' => false, 'error' => 'خطا در بروزرسانی']);
}
?>