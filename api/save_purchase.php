<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!$data) {
    jsonResponse(['success' => false, 'error' => 'داده‌های ارسالی نامعتبر است']);
}

$sql = "INSERT INTO purchase_requests (
    pr_number, request_date, requester_name, requester_department,
    part_code, part_name, quantity, unit, urgency, required_date,
    budget_estimate, reason, ncr_number, claim_number, documents,
    supervisor_status, supervisor_approved_date, supervisor_notes,
    finance_status, finance_approved_date, finance_notes,
    procurement_status, procurement_notes, po_number, supplier_name, order_date,
    final_status, created_at
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";

$params = [
    $data['pr_number'],
    $data['request_date'],
    $data['requester_name'],
    $data['requester_department'] ?? '',
    $data['part_code'],
    $data['part_name'],
    $data['quantity'] ?? 0,
    $data['unit'] ?? 'عدد',
    $data['urgency'] ?? 'normal',
    $data['required_date'] ?? null,
    $data['budget_estimate'] ?? 0,
    $data['reason'] ?? '',
    $data['ncr_number'] ?? null,
    $data['claim_number'] ?? null,
    $data['documents'] ?? '',
    $data['supervisor_status'] ?? 'pending',
    $data['supervisor_approved_date'] ?? null,
    $data['supervisor_notes'] ?? '',
    $data['finance_status'] ?? 'pending',
    $data['finance_approved_date'] ?? null,
    $data['finance_notes'] ?? '',
    $data['procurement_status'] ?? 'pending',
    $data['procurement_notes'] ?? '',
    $data['po_number'] ?? '',
    $data['supplier_name'] ?? '',
    $data['order_date'] ?? null,
    $data['final_status'] ?? 'pending'
];

$result = executeInsert($sql, $params);

if ($result) {
    jsonResponse(['success' => true, 'id' => $result]);
} else {
    jsonResponse(['success' => false, 'error' => 'خطا در ذخیره درخواست خرید']);
}
?>