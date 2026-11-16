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

try {
    $year = date('Y');
    
    // ⭐ پیدا کردن آخرین شماره NCR در این سال
    $sql = "SELECT ncr_number FROM ncrs 
            WHERE ncr_number LIKE ? 
            ORDER BY ncr_number DESC 
            LIMIT 1";
    $pattern = 'NCR-' . $year . '-%';
    $last = fetchOne($sql, [$pattern], 's');
    
    $nextNumber = 1;
    if ($last && isset($last['ncr_number'])) {
        // استخراج عدد از انتهای شماره
        $parts = explode('-', $last['ncr_number']);
        $lastNum = (int)end($parts);
        $nextNumber = $lastNum + 1;
    }
    
    $ncrNumber = 'NCR-' . $year . '-' . str_pad($nextNumber, 4, '0', STR_PAD_LEFT);
    
    jsonResponse([
        'success' => true,
        'ncr_number' => $ncrNumber,
        'next_number' => $nextNumber
    ]);
    
} catch (Exception $e) {
    jsonResponse(['success' => false, 'error' => $e->getMessage()]);
}
?>