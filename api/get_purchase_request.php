<?php
// get_purchase_request.php - دریافت یک درخواست خرید بر اساس شماره
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

$number = isset($_GET['pr_number']) ? $_GET['pr_number'] : (isset($_GET['number']) ? $_GET['number'] : '');

if (empty($number)) {
    jsonResponse(['success' => false, 'error' => 'شماره درخواست خرید الزامی است']);
}

$sql = "SELECT * FROM purchase_requests WHERE pr_number = ?";
$purchase = fetchOne($sql, [$number], 's');

if ($purchase) {
    jsonResponse(['success' => true, 'data' => $purchase]);
} else {
    jsonResponse(['success' => false, 'error' => 'درخواست خرید پیدا نشد']);
}
