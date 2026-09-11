<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

$sql = "SELECT * FROM shortages ORDER BY created_at DESC";
$shortages = fetchAll($sql);

jsonResponse([
    'success' => true,
    'data' => $shortages,
    'count' => count($shortages)
]);
?>