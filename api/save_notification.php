<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!$data || !isset($data['title']) || !isset($data['message'])) {
    jsonResponse(['success' => false, 'error' => 'عنوان و پیام الزامی است']);
}

$sql = "INSERT INTO notifications (user_id, title, message, type, link, is_read, created_at) 
        VALUES (?, ?, ?, ?, ?, 0, NOW())";

$params = [
    $data['user_id'] ?? null,
    $data['title'],
    $data['message'],
    $data['type'] ?? 'info',
    $data['link'] ?? ''
];

$result = executeInsert($sql, $params);

if ($result) {
    jsonResponse(['success' => true, 'id' => $result]);
} else {
    jsonResponse(['success' => false, 'error' => 'خطا در ذخیره اعلان']);
}
?>