<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

$sql = "SELECT * FROM purchase_requests ORDER BY created_at DESC";
$purchases = fetchAll($sql);

jsonResponse([
    'success' => true,
    'data' => $purchases,
    'count' => count($purchases)
]);
?>