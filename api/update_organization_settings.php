<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

// ⭐ مسیر صحیح
require_once __DIR__ . '/../config/database.php';

$input = json_decode(file_get_contents('php://input'), true);
if (!$input || !isset($input['settings'])) {
    echo json_encode(['success' => false, 'message' => 'داده نامعتبر']);
    exit;
}

try {
    $pdo->beginTransaction();
    $stmt = $pdo->prepare("
        INSERT INTO organization_settings (setting_key, setting_value, setting_type)
        VALUES (:k, :v, :t)
        ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)
    ");

    foreach ($input['settings'] as $key => $value) {
        $type = 'text';
        if (strpos($key, 'logo') !== false) $type = 'image';
        elseif (strpos($key, 'show_') === 0) $type = 'number';
        $stmt->execute([':k' => $key, ':v' => $value, ':t' => $type]);
    }

    $pdo->commit();
    echo json_encode(['success' => true]);
} catch (Exception $e) {
    $pdo->rollBack();
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>