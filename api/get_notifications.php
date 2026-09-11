<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

// دریافت user_id از پارامتر (اختیاری)
$userId = isset($_GET['user_id']) ? (int)$_GET['user_id'] : 0;

$sql = "SELECT * FROM notifications";
$params = [];
$types = '';

if ($userId > 0) {
    $sql .= " WHERE user_id = ? OR user_id IS NULL";
    $params[] = $userId;
    $types = 'i';
}

$sql .= " ORDER BY created_at DESC LIMIT 50";

$notifications = fetchAll($sql, $params, $types);

jsonResponse([
    'success' => true,
    'data' => $notifications,
    'count' => count($notifications)
]);
?>