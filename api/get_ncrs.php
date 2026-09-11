<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

$sql = "SELECT * FROM ncrs ORDER BY created_at DESC";
$ncrs = fetchAll($sql);

jsonResponse([
    'success' => true,
    'data' => $ncrs,
    'count' => count($ncrs)
]);
?>