<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

require_once '../config/database.php';

$sql = "SELECT * FROM ncrs ORDER BY created_at DESC";
$ncrs = fetchAll($sql);

jsonResponse([
    'success' => true,
    'data' => $ncrs,
    'count' => count($ncrs)
]);
?>