<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

require_once __DIR__ . '/../config/database.php';

$uploadDir = __DIR__ . '/../uploads/part_images/';
if (!is_dir($uploadDir)) {
    mkdir($uploadDir, 0755, true);
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'error' => 'Invalid request method']);
    exit;
}

if (!isset($_FILES['part_image']) || $_FILES['part_image']['error'] !== UPLOAD_ERR_OK) {
    echo json_encode(['success' => false, 'error' => 'No file uploaded or upload error']);
    exit;
}

$ncrNumber = isset($_POST['ncr_number']) ? $_POST['ncr_number'] : 'unknown';
$file = $_FILES['part_image'];

// بررسی نوع فایل
$allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
if (!in_array($file['type'], $allowedTypes)) {
    echo json_encode(['success' => false, 'error' => 'Invalid file type']);
    exit;
}

// بررسی حجم (5 مگابایت)
if ($file['size'] > 5 * 1024 * 1024) {
    echo json_encode(['success' => false, 'error' => 'File too large']);
    exit;
}

// ساخت نام فایل
$ext = pathinfo($file['name'], PATHINFO_EXTENSION);
$newFileName = 'part_' . preg_replace('/[^A-Za-z0-9\-]/', '_', $ncrNumber) . '_' . time() . '.' . $ext;
$targetPath = $uploadDir . $newFileName;

if (!move_uploaded_file($file['tmp_name'], $targetPath)) {
    echo json_encode(['success' => false, 'error' => 'Failed to move uploaded file']);
    exit;
}

$fileInfo = [
    'name' => $file['name'],
    'size' => $file['size'],
    'type' => $file['type'],
    'path' => 'uploads/part_images/' . $newFileName,
    'url' => SITE_URL . 'uploads/part_images/' . $newFileName,
    'uploaded_at' => date('Y-m-d H:i:s')
];

echo json_encode([
    'success' => true,
    'file' => $fileInfo,
    'message' => 'Part image uploaded successfully'
]);
?>