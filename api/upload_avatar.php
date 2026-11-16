<?php
// upload_avatar.php - آپلود تصویر کاربر
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

require_once __DIR__ . '/../config/database.php';

$uploadDir = __DIR__ . '/../uploads/avatars/';
if (!is_dir($uploadDir)) {
    mkdir($uploadDir, 0755, true);
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['success' => false, 'error' => 'Invalid request method']);
    exit;
}

if (!isset($_FILES['avatar']) || $_FILES['avatar']['error'] !== UPLOAD_ERR_OK) {
    echo json_encode(['success' => false, 'error' => 'فایلی ارسال نشده است']);
    exit;
}

$file = $_FILES['avatar'];

$allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/webp'];
if (!in_array($file['type'], $allowedTypes, true)) {
    echo json_encode(['success' => false, 'error' => 'فرمت تصویر مجاز نیست (JPG, PNG, GIF, WEBP)']);
    exit;
}

if ($file['size'] > 2 * 1024 * 1024) {
    echo json_encode(['success' => false, 'error' => 'حجم تصویر نباید بیشتر از ۲ مگابایت باشد']);
    exit;
}

$ext = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
if (!in_array($ext, ['jpg', 'jpeg', 'png', 'gif', 'webp'], true)) {
    $ext = 'png';
}

$newFileName = 'avatar_' . date('Ymd_His') . '_' . bin2hex(random_bytes(4)) . '.' . $ext;
$targetPath = $uploadDir . $newFileName;

if (!move_uploaded_file($file['tmp_name'], $targetPath)) {
    echo json_encode(['success' => false, 'error' => 'ذخیره تصویر ناموفق بود']);
    exit;
}

$relativePath = 'uploads/avatars/' . $newFileName;

echo json_encode([
    'success' => true,
    'path' => $relativePath,
    'url' => SITE_URL . $relativePath,
    'message' => 'تصویر با موفقیت بارگذاری شد'
]);
