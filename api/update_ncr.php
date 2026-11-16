<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

require_once '../config/database.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!$data || !isset($data['ncr_number'])) {
    jsonResponse(['success' => false, 'error' => 'شماره NCR الزامی است']);
}

$ncrNumber = $data['ncr_number'];

// ⭐ لیست کامل فیلدهای مجاز
$allowedFields = [
    // مرحله 1
    'report_date', 'reporter_name', 'reporter_position', 'reporter_department',
    'location_found', 'inspection_number', 'work_station',
    'skeleton_process', 'sheet_metal_process', 'fiber_process', 'painting_process',
    'product_type', 'bus_model', 'car_model', 'truck_model', 'minibus_model', 'tractor_model',
    'part_code', 'part_name', 'quantity', 'unit', 'description', 'batch_number','documents','part_image',
    'step1_completed', 'step1_submitted_at',
    // مرحله 2
    'standard_ref', 'immediate_action', 'severity', 'quality_notes',
    'analysis_method', 'fishbone_checks', 'fishbone_other',
    'why1', 'why2', 'why3', 'why4', 'why5', 'analysis_conclusion',
    'quality_checker', 'quality_check_date',
    'step2_completed', 'step2_submitted_at',
    // مرحله 3
    'confirmation', 'reject_reason', 'disposition_type',
    'rework_responsible', 'rework_deadline', 'rework_action_number',
    'concession_number', 'hold_reason', 'claim_number', 'purchase_number',
    'corrective_action', 'corrective_number',
    'cft_committee', 'cft_date',
    'step3_completed', 'step3_submitted_at',
    // مرحله 4
    'effectiveness', 'ineffective_action_number',
    'monitoring_date', 'monitoring_responsible', 'monitoring_notes',
    'final_status', 'closure_date', 'closure_by',
    'step4_completed', 'step4_submitted_at',
    // عمومی
    'status', 'current_step', 'assigned_role'
];

try {
    $conn = getDBConnection();
    if (!$conn) {
        jsonResponse(['success' => false, 'error' => 'خطا در اتصال به دیتابیس']);
    }

    // ⭐ بررسی وجود ستون‌های جدول
    $existingColumns = [];
    $colResult = $conn->query("SHOW COLUMNS FROM ncrs");
    while ($col = $colResult->fetch_assoc()) {
        $existingColumns[] = $col['Field'];
    }

    // ⭐ ساخت پویای SET
    $setParts = [];
    $params = [];
    $types = '';

    foreach ($allowedFields as $field) {
        if (array_key_exists($field, $data) && in_array($field, $existingColumns)) {
            $setParts[] = "`$field` = ?";
            $value = $data[$field];
            
            // تبدیل مقادیر NULL
            if ($value === null || $value === '') {
                $params[] = null;
                $types .= 's';
            } else {
                $params[] = $value;
                $types .= 's';
            }
        }
    }

    if (empty($setParts)) {
        $conn->close();
        jsonResponse(['success' => false, 'error' => 'هیچ فیلد معتبری برای بروزرسانی وجود ندارد']);
    }

    $params[] = $ncrNumber;
    $types .= 's';

    $sql = "UPDATE ncrs SET " . implode(', ', $setParts) . ", updated_at = NOW() WHERE ncr_number = ?";
    
    error_log("UPDATE SQL: " . $sql);
    error_log("Params: " . json_encode($params));
    
    $stmt = $conn->prepare($sql);
    if (!$stmt) {
        $conn->close();
        jsonResponse(['success' => false, 'error' => 'Prepare failed: ' . $conn->error]);
    }

    $stmt->bind_param($types, ...$params);
    $success = $stmt->execute();
    $affectedRows = $stmt->affected_rows;
    $stmtError = $stmt->error;
    
    $stmt->close();
    $conn->close();

    if ($success) {
        jsonResponse([
            'success' => true,
            'message' => 'NCR بروزرسانی شد',
            'affected_rows' => $affectedRows
        ]);
    } else {
        jsonResponse(['success' => false, 'error' => 'خطا در اجرای UPDATE: ' . $stmtError]);
    }

} catch (Exception $e) {
    error_log("Exception: " . $e->getMessage());
    jsonResponse(['success' => false, 'error' => $e->getMessage()]);
}
?>