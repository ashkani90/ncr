<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { http_response_code(200); exit; }

require_once '../config/database.php';

$data = json_decode(file_get_contents('php://input'), true);
if (!$data || !isset($data['user_id'])) {
    jsonResponse(['success' => false, 'error' => 'user_id الزامی است']);
}

$userId = (int)$data['user_id'];
$permissions = isset($data['permissions']) ? $data['permissions'] : [];

$conn = getDBConnection();
if (!$conn) jsonResponse(['success' => false, 'error' => 'DB connection failed']);

// ساخت جدول اگر نیست
$conn->query("CREATE TABLE IF NOT EXISTS `user_permissions` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL,
    `permission_code` VARCHAR(100) NOT NULL,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `uk_user_perm` (`user_id`, `permission_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

// حذف دسترسی‌های قبلی
$stmt = $conn->prepare("DELETE FROM user_permissions WHERE user_id = ?");
$stmt->bind_param('i', $userId);
$stmt->execute();
$stmt->close();

// درج دسترسی‌های جدید
if (is_array($permissions) && count($permissions) > 0) {
    $stmt = $conn->prepare("INSERT INTO user_permissions (user_id, permission_code) VALUES (?, ?)");
    foreach ($permissions as $perm) {
        $stmt->bind_param('is', $userId, $perm);
        $stmt->execute();
    }
    $stmt->close();
}

$conn->close();
jsonResponse(['success' => true, 'count' => count($permissions)]);
?>