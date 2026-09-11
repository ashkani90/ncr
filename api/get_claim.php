<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

$number = isset($_GET['number']) ? $_GET['number'] : '';

if (empty($number)) {
    jsonResponse(['success' => false, 'error' => 'شماره کلیم الزامی است']);
}

$sql = "SELECT * FROM claims WHERE claim_number = ?";
$claim = fetchOne($sql, [$number], 's');

if ($claim) {
    jsonResponse(['success' => true, 'data' => $claim]);
} else {
    jsonResponse(['success' => false, 'error' => 'کلیم یافت نشد']);
}
?>