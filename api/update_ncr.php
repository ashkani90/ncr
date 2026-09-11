<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!$data || !isset($data['ncr_number'])) {
    jsonResponse(['success' => false, 'error' => 'شماره NCR الزامی است']);
}

$fields = [
    'report_date', 'reporter_name', 'reporter_department', 'subject',
    'part_code', 'part_name', 'requested_qty', 'sent_qty', 'shortage_qty',
    'shortage_reason', 'unit', 'batch_number', 'location_found',
    'inspector_name', 'inspector_department', 'description', 'initial_diagnosis',
    'quality_status', 'quality_check_date', 'quality_checker', 'quality_notes',
    'root_cause', 'root_cause_category', 'fmea_status', 'fmea_date',
    'fmea_engineer', 'fmea_risk_priority_number', 'fmea_notes',
    'cft_status', 'cft_date', 'cft_committee', 'disposition',
    'disposition_details', 'responsible_person', 'due_date',
    'final_quality_status', 'final_quality_date', 'final_quality_checker',
    'action_result', 'effectiveness', 'corrective_action_needed',
    'corrective_action_number', 'priority', 'final_status',
    'closure_date', 'closure_by', 'closure_notes', 'updated_by'
];

$setParts = [];
$params = [];

foreach ($fields as $field) {
    if (isset($data[$field])) {
        $setParts[] = "$field = ?";
        $params[] = $data[$field];
    }
}

if (empty($setParts)) {
    jsonResponse(['success' => false, 'error' => 'هیچ داده‌ای برای بروزرسانی وجود ندارد']);
}

$params[] = $data['ncr_number'];
$sql = "UPDATE ncrs SET " . implode(', ', $setParts) . ", updated_at = NOW() WHERE ncr_number = ?";

$conn = getDBConnection();
$stmt = $conn->prepare($sql);

if (!$stmt) {
    jsonResponse(['success' => false, 'error' => $conn->error]);
}

$types = str_repeat('s', count($params));
$stmt->bind_param($types, ...$params);
$success = $stmt->execute();
$stmt->close();
$conn->close();

if ($success) {
    jsonResponse(['success' => true]);
} else {
    jsonResponse(['success' => false, 'error' => 'خطا در بروزرسانی']);
}
?>