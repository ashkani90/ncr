<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

require_once '../config/database.php';

try {
    $sql = "SELECT * FROM ncrs ORDER BY created_at DESC";
    $ncrs = fetchAll($sql);
    
    if ($ncrs === false) {
        jsonResponse(['success' => false, 'error' => 'خطا در دریافت داده‌ها']);
    } else {
        jsonResponse([
            'success' => true,
            'data' => $ncrs,
            'count' => count($ncrs)
        ]);
    }
} catch (Exception $e) {
    jsonResponse(['success' => false, 'error' => $e->getMessage()]);
}
?>