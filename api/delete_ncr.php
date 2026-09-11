<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!$data || !isset($data['ncr_number'])) {
    jsonResponse(['success' => false, 'error' => 'شماره NCR الزامی است']);
}

$sql = "DELETE FROM ncrs WHERE ncr_number = ?";
$result = executeQuery($sql, [$data['ncr_number']], 's');

if ($result !== false) {
    jsonResponse(['success' => true]);
} else {
    jsonResponse(['success' => false, 'error' => 'خطا در حذف NCR']);
}
?>