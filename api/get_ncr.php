<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

require_once '../config/database.php';

$number = isset($_GET['number']) ? $_GET['number'] : '';

if (empty($number)) {
    // اگر شماره داده نشد، همه NCRها را برگردان
    $sql = "SELECT * FROM ncrs ORDER BY created_at DESC";
    $ncrs = fetchAll($sql);
    jsonResponse([
        'success' => true,
        'data' => $ncrs,
        'count' => count($ncrs)
    ]);
}

$sql = "SELECT * FROM ncrs WHERE ncr_number = ?";
$ncr = fetchOne($sql, [$number], 's');

if ($ncr) {
    jsonResponse(['success' => true, 'data' => $ncr]);
} else {
    jsonResponse(['success' => false, 'error' => 'NCR یافت نشد']);
}
?>