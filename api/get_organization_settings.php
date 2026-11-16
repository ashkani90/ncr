<?php
// ⭐ فعال‌سازی نمایش خطاها برای عیب‌یابی
error_reporting(E_ALL);
ini_set('display_errors', 0); // در production نباید نمایش داده شود
ini_set('log_errors', 1);

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// ⭐ مدیریت خطاهای Fatal
register_shutdown_function(function() {
    $error = error_get_last();
    if ($error && in_array($error['type'], [E_ERROR, E_PARSE, E_CORE_ERROR, E_COMPILE_ERROR])) {
        echo json_encode([
            'success' => false,
            'message' => 'Fatal PHP Error: ' . $error['message'],
            'file' => $error['file'],
            'line' => $error['line']
        ], JSON_UNESCAPED_UNICODE);
    }
});

try {
    // ⭐ بررسی وجود فایل database.php
    $dbPath = __DIR__ . '/../config/database.php';
    
    if (!file_exists($dbPath)) {
        throw new Exception('database.php not found at: ' . $dbPath);
    }
    
    require_once $dbPath;
    
    if (!isset($pdo)) {
        throw new Exception('$pdo variable is not defined in database.php');
    }
    
    // ⭐ دریافت تنظیمات
    $stmt = $pdo->query("SELECT setting_key, setting_value, setting_type FROM organization_settings");
    $settings = [];
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $settings[$row['setting_key']] = $row['setting_value'];
    }

    // ⭐ آدرس پایه سایت
    $baseUrl = rtrim(SITE_URL, '/') . '/';

    // ⭐ تبدیل مسیر نسبی لوگو به کامل
    if (!empty($settings['company_logo']) 
        && !preg_match('/^https?:\/\//', $settings['company_logo'])
        && strpos($settings['company_logo'], 'data:') !== 0) {
        
        $relativePath = ltrim($settings['company_logo'], '/');
        $settings['company_logo'] = $baseUrl . $relativePath;
    }

    echo json_encode([
        'success'  => true,
        'settings' => $settings
    ], JSON_UNESCAPED_UNICODE);

} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ], JSON_UNESCAPED_UNICODE);
} catch (Error $e) {
    echo json_encode([
        'success' => false,
        'message' => 'PHP Error: ' . $e->getMessage(),
        'file' => $e->getFile(),
        'line' => $e->getLine()
    ], JSON_UNESCAPED_UNICODE);
}
?>