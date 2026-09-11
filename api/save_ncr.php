<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!$data) {
    jsonResponse(['success' => false, 'error' => 'داده‌های ارسالی نامعتبر است']);
}

$sql = "INSERT INTO ncrs (
    ncr_number, report_date, reporter_name, reporter_department,
    subject, part_code, part_name, requested_qty, sent_qty,
    shortage_qty, shortage_reason, unit, batch_number,
    location_found, inspector_name, inspector_department,
    description, initial_diagnosis, priority, final_status,
    created_at, created_by
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?)";

$params = [
    $data['ncr_number'],
    $data['report_date'],
    $data['reporter_name'],
    $data['reporter_department'],
    $data['subject'],
    $data['part_code'],
    $data['part_name'],
    $data['requested_qty'] ?? 0,
    $data['sent_qty'] ?? 0,
    $data['shortage_qty'] ?? 0,
    $data['shortage_reason'] ?? '',
    $data['unit'] ?? 'عدد',
    $data['batch_number'] ?? '',
    $data['location_found'] ?? '',
    $data['inspector_name'] ?? '',
    $data['inspector_department'] ?? '',
    $data['description'] ?? '',
    $data['initial_diagnosis'] ?? '',
    $data['priority'] ?? 'medium',
    $data['final_status'] ?? 'open',
    $data['created_by'] ?? ''
];

$result = executeInsert($sql, $params);

if ($result) {
    jsonResponse(['success' => true, 'id' => $result]);
} else {
    jsonResponse(['success' => false, 'error' => 'خطا در ذخیره NCR']);
}
?>