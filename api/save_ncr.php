<?php
// ⭐ فعال کردن نمایش خطاها برای دیباگ
error_reporting(E_ALL);
ini_set('display_errors', 0); // در پاسخ JSON نمایش نده
ini_set('log_errors', 1);

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

if (!$data) {
    jsonResponse(['success' => false, 'error' => 'داده‌های ارسالی نامعتبر است']);
}

if (empty($data['ncr_number'])) {
    jsonResponse(['success' => false, 'error' => 'شماره NCR الزامی است']);
}

$conn = getDBConnection();
if (!$conn) {
    jsonResponse(['success' => false, 'error' => 'خطا در اتصال به دیتابیس']);
}

// ⭐ بررسی وجود NCR تکراری
$checkSql = "SELECT id FROM ncrs WHERE ncr_number = ?";
$stmt = $conn->prepare($checkSql);
$stmt->bind_param('s', $data['ncr_number']);
$stmt->execute();
$checkResult = $stmt->get_result();
$existing = $checkResult->fetch_assoc();
$stmt->close();

if ($existing) {
    // ⭐ NCR تکراری → UPDATE
    $updateFields = [
        'report_date', 'reporter_name', 'reporter_position', 'reporter_department',
        'location_found', 'inspection_number', 'work_station',
        'skeleton_process', 'sheet_metal_process', 'fiber_process', 'painting_process',
        'product_type', 'bus_model', 'car_model', 'truck_model', 'minibus_model', 'tractor_model',
        'part_code', 'part_name', 'quantity', 'unit', 'description', 'batch_number','documents','part_image',
        'status', 'current_step', 'step1_completed', 'step1_submitted_at'
    ];
    
    $setParts = [];
    $params = [];
    $types = '';
    
    foreach ($updateFields as $field) {
        if (array_key_exists($field, $data)) {
            $setParts[] = "$field = ?";
            $params[] = $data[$field];
            $types .= 's';
        }
    }
    
    if (empty($setParts)) {
        $conn->close();
        jsonResponse(['success' => false, 'error' => 'هیچ فیلدی برای بروزرسانی وجود ندارد']);
    }
    
    $params[] = $data['ncr_number'];
    $types .= 's';
    $sql = "UPDATE ncrs SET " . implode(', ', $setParts) . ", updated_at = NOW() WHERE ncr_number = ?";
    
    $stmt = $conn->prepare($sql);
    if (!$stmt) {
        $err = $conn->error;
        $conn->close();
        jsonResponse(['success' => false, 'error' => 'Prepare failed: ' . $err]);
    }
    
    $stmt->bind_param($types, ...$params);
    $success = $stmt->execute();
    $stmt->close();
    $conn->close();
    
    if ($success) {
        jsonResponse([
            'success' => true,
            'id' => $existing['id'],
            'ncr_number' => $data['ncr_number'],
            'updated' => true
        ]);
    } else {
        jsonResponse(['success' => false, 'error' => 'خطا در بروزرسانی NCR']);
    }
    exit;
}

// ⭐ NCR جدید → INSERT
// فقط ستون‌هایی که مطمئنیم در جدول ncrs هستند
$columns = [
    'ncr_number', 'status', 'current_step',
    'report_date', 'reporter_name', 'reporter_department',
    'location_found', 'part_code', 'part_name',
    'quantity', 'unit', 'description', 'batch_number','documents','part_image',
    'created_by'
];

// ستون‌های اختیاری (اگر در جدول نباشند، خطا نمی‌دهد)
$optionalColumns = [
    'reporter_position', 'inspection_number', 'work_station',
    'skeleton_process', 'sheet_metal_process', 'fiber_process', 'painting_process',
    'product_type', 'bus_model', 'car_model', 'truck_model', 'minibus_model', 'tractor_model',
    'step1_completed', 'step1_submitted_at'
];

// ⭐ بررسی وجود ستون‌های اختیاری در جدول
$existingColumns = [];
$colResult = $conn->query("SHOW COLUMNS FROM ncrs");
while ($col = $colResult->fetch_assoc()) {
    $existingColumns[] = $col['Field'];
}

$allColumns = [];
foreach ($columns as $c) {
    if (in_array($c, $existingColumns)) $allColumns[] = $c;
}
foreach ($optionalColumns as $c) {
    if (in_array($c, $existingColumns)) $allColumns[] = $c;
}

$placeholders = array_fill(0, count($allColumns), '?');
$sql = "INSERT INTO ncrs (" . implode(', ', $allColumns) . ", created_at) VALUES (" . implode(', ', $placeholders) . ", NOW())";

$params = [];
$types = '';
foreach ($allColumns as $col) {
    switch ($col) {
        case 'ncr_number':
            $params[] = $data['ncr_number'];
            $types .= 's';
            break;
        case 'status':
            $params[] = $data['status'] ?? 'step1_submitted';
            $types .= 's';
            break;
        case 'current_step':
            $params[] = isset($data['current_step']) ? (int)$data['current_step'] : 1;
            $types .= 'i';
            break;
        case 'report_date':
            $params[] = $data['report_date'] ?? null;
            $types .= 's';
            break;
        case 'quantity':
            $params[] = isset($data['quantity']) ? (int)$data['quantity'] : 0;
            $types .= 'i';
            break;
        case 'step1_completed':
            $params[] = isset($data['step1_completed']) ? (int)$data['step1_completed'] : 1;
            $types .= 'i';
            break;
        case 'step1_submitted_at':
            $params[] = $data['step1_submitted_at'] ?? date('Y-m-d H:i:s');
            $types .= 's';
            break;
        default:
            $params[] = $data[$col] ?? '';
            $types .= 's';
            break;
    }
}

$stmt = $conn->prepare($sql);
if (!$stmt) {
    $err = $conn->error;
    $conn->close();
    jsonResponse(['success' => false, 'error' => 'Prepare failed: ' . $err]);
}

$stmt->bind_param($types, ...$params);
$success = $stmt->execute();
$insertId = $conn->insert_id;
$stmt->close();
$conn->close();

if ($success) {
    jsonResponse([
        'success' => true,
        'id' => $insertId,
        'ncr_number' => $data['ncr_number'],
        'created' => true,
        'columns_used' => $allColumns
    ]);
} else {
    jsonResponse(['success' => false, 'error' => 'خطا در ذخیره NCR']);
}
?>