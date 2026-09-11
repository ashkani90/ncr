<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

$sql = "SELECT * FROM claims ORDER BY created_at DESC";
$claims = fetchAll($sql);

jsonResponse([
    'success' => true,
    'data' => $claims,
    'count' => count($claims)
]);
?>