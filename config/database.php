<?php
// ============================================
// تنظیمات اتصال به دیتابیس - نسخه نهایی با پشتیبانی PDO + MySQLi
// ============================================

// تنظیمات پیش‌فرض برای پشتیبانی کامل از UTF-8
mb_internal_encoding('UTF-8');
mb_http_output('UTF-8');

// ============================================
// تشخیص محیط اجرا: لوکال (XAMPP) یا هاست (InfinityFree)
//   لوکال : http://localhost:8080/ncr  →  MySQL لوکال (root / بدون رمز)
//   هاست  : https://ncr.page.gd        →  MySQL InfinityFree
// ============================================
$httpHost = strtolower(preg_replace('/:\d+$/', '', $_SERVER['HTTP_HOST'] ?? ''));
$isLocalEnv = (PHP_SAPI === 'cli')
    || $httpHost === ''
    || $httpHost === 'localhost'
    || $httpHost === '127.0.0.1'
    || $httpHost === '::1'
    || strpos($httpHost, 'localhost') !== false
    || strpos($httpHost, '127.0.0.1') !== false;

if ($isLocalEnv) {
    // ---- XAMPP لوکال ----
    define('DB_HOST', 'localhost');
    define('DB_NAME', 'ncr_db');
    define('DB_USER', 'root');
    define('DB_PASS', '');
} else {
    // ---- هاست InfinityFree ----
    define('DB_HOST', 'sql210.infinityfree.com');
    define('DB_NAME', 'if0_42715068_ncr_system');
    define('DB_USER', 'if0_42715068');
    define('DB_PASS', 'Poursan8253');
}

// تنظیمات سایت
$protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off')
    || (($_SERVER['HTTP_X_FORWARDED_PROTO'] ?? '') === 'https') ? 'https://' : 'http://';
$host = $_SERVER['HTTP_HOST'] ?? 'localhost';

// آدرس پوشه پروژه؛ فایل‌های داخل api/ باید یک پوشه بالاتر بروند
$baseDir = str_replace('\\', '/', dirname($_SERVER['SCRIPT_NAME'] ?? '/'));
if (basename($baseDir) === 'api') {
    $baseDir = dirname($baseDir);
}
$base_path = rtrim($baseDir, '/') . '/';

define('SITE_URL', $protocol . $host . $base_path);
define('API_URL', SITE_URL . 'api/');

// ============================================
// ⭐ اتصال PDO (برای فایل‌های جدید مثل get_organization_settings.php)
// ============================================
try {
    $pdo = new PDO(
        "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8mb4",
        DB_USER,
        DB_PASS,
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
            PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci"
        ]
    );
} catch (PDOException $e) {
    // اگر اتصال PDO شکست خورد، خطا را لاگ کن (نباید اینجا die کنیم چون ممکن است فایل‌های دیگر از mysqli استفاده کنند)
    error_log("PDO Connection failed: " . $e->getMessage());
    $pdo = null;
}

// ============================================
// ⭐ اتصال MySQLi (برای فایل‌های قدیمی)
// ============================================
function getDBConnection() {
    $conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
    
    if ($conn->connect_error) {
        error_log("MySQLi Connection failed: " . $conn->connect_error);
        return null;
    }
    
    if (!$conn->set_charset('utf8mb4')) {
        error_log("Error loading character set utf8mb4: " . $conn->error);
    }
    
    $conn->query("SET NAMES 'utf8mb4' COLLATE 'utf8mb4_unicode_ci'");
    $conn->query("SET CHARACTER SET utf8mb4");
    $conn->query("SET SESSION collation_connection = 'utf8mb4_unicode_ci'");
    
    return $conn;
}

// ============================================
// توابع کمکی MySQLi
// ============================================
function executeQuery($sql, $params = [], $types = '') {
    $conn = getDBConnection();
    if (!$conn) return false;
    
    if (empty($params)) {
        $result = $conn->query($sql);
        $conn->close();
        return $result;
    }
    
    $stmt = $conn->prepare($sql);
    if (!$stmt) {
        error_log("Prepare failed: " . $conn->error);
        $conn->close();
        return false;
    }
    
    if (empty($types)) {
        $types = str_repeat('s', count($params));
    }
    $stmt->bind_param($types, ...$params);
    
    $success = $stmt->execute();
    $result = $stmt->get_result();
    $stmt->close();
    $conn->close();

    if (!$success) return false;

    // برای UPDATE/DELETE/EDIT نتیجه‌ای (result set) وجود ندارد؛ true برگردان
    return $result !== false ? $result : true;
}

function fetchAll($sql, $params = [], $types = '') {
    $result = executeQuery($sql, $params, $types);
    if ($result === false || !$result) return [];
    
    $data = [];
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
    return $data;
}

function fetchOne($sql, $params = [], $types = '') {
    $result = executeQuery($sql, $params, $types);
    if ($result === false || !$result) return null;
    return $result->fetch_assoc();
}

function executeInsert($sql, $params = [], $types = '') {
    $conn = getDBConnection();
    if (!$conn) return false;
    
    $stmt = $conn->prepare($sql);
    if (!$stmt) {
        error_log("Prepare failed: " . $conn->error);
        $conn->close();
        return false;
    }
    
    if (!empty($params)) {
        if (empty($types)) {
            $types = str_repeat('s', count($params));
        }
        $stmt->bind_param($types, ...$params);
    }
    
    $success = $stmt->execute();
    $insertId = $conn->insert_id;
    $stmt->close();
    $conn->close();
    
    return $success ? $insertId : false;
}

// ============================================
// تابع jsonResponse
// ============================================
function jsonResponse($data, $statusCode = 200) {
    http_response_code($statusCode);
    header('Content-Type: application/json; charset=utf-8');
    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
    header('Access-Control-Allow-Headers: Content-Type, Authorization');
    echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

// ============================================
// تابع تست اتصال دیتابیس
// ============================================
function testDBConnection() {
    $conn = getDBConnection();
    if ($conn) {
        $result = $conn->query("SELECT @@character_set_connection AS charset, @@collation_connection AS collation");
        $info = $result->fetch_assoc();
        $conn->close();
        return [
            'success' => true,
            'message' => 'اتصال به دیتابیس برقرار است',
            'charset' => $info['charset'],
            'collation' => $info['collation']
        ];
    } else {
        return ['success' => false, 'error' => 'خطا در اتصال به دیتابیس'];
    }
}
?>