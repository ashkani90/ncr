<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!$data) {
    jsonResponse(['success' => false, 'error' => 'داده‌های ارسالی نامعتبر است']);
}

$sql = "INSERT INTO shortages (
    shortage_number, report_date, reporter_name, reporter_department,
    subject, part_code, part_name, requested_qty, sent_qty,
    shortage_qty, unit, batch_number, documents, description,
    ceo_status, ceo_approved_date, ceo_notes,
    supplier_status, supplier_response_date, supplier_approved,
    supplier_replacement_date, supplier_cost_amount, supplier_notes,
    corrective_action_number, action_result,
    warehouse_status, replacement_received_date, replacement_quantity, warehouse_notes,
    final_status, created_at
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";

$params = [
    $data['shortage_number'],
    $data['report_date'],
    $data['reporter_name'],
    $data['reporter_department'] ?? '',
    $data['subject'],
    $data['part_code'],
    $data['part_name'],
    $data['requested_qty'] ?? 0,
    $data['sent_qty'] ?? 0,
    $data['shortage_qty'] ?? 0,
    $data['unit'] ?? 'عدد',
    $data['batch_number'] ?? '',
    $data['documents'] ?? '',
    $data['description'] ?? '',
    $data['ceo_status'] ?? 'pending',
    $data['ceo_approved_date'] ?? null,
    $data['ceo_notes'] ?? '',
    $data['supplier_status'] ?? 'pending',
    $data['supplier_response_date'] ?? null,
    $data['supplier_approved'] ?? null,
    $data['supplier_replacement_date'] ?? null,
    $data['supplier_cost_amount'] ?? 0,
    $data['supplier_notes'] ?? '',
    $data['corrective_action_number'] ?? '',
    $data['action_result'] ?? '',
    $data['warehouse_status'] ?? 'pending',
    $data['replacement_received_date'] ?? null,
    $data['replacement_quantity'] ?? 0,
    $data['warehouse_notes'] ?? '',
    $data['final_status'] ?? 'open'
];

$result = executeInsert($sql, $params);

if ($result) {
    jsonResponse(['success' => true, 'id' => $result]);
} else {
    jsonResponse(['success' => false, 'error' => 'خطا در ذخیره گزارش']);
}
?>