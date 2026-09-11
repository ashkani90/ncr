<?php
// ============================================
// تنظیمات اتصال به دیتابیس - نسخه نهایی
// ============================================

// تنظیمات دیتابیس (مطابق اطلاعات شما)
define('DB_HOST', 'sql210.infinityfree.com');
define('DB_NAME', 'if0_42715068_ncr_system');
define('DB_USER', 'if0_42715068');
define('DB_PASS', 'Poursan8253');

// تنظیمات سایت
$protocol = isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? 'https://' : 'http://';
$host = $_SERVER['HTTP_HOST'];
$base_path = rtrim(dirname($_SERVER['SCRIPT_NAME']), '/') . '/';

define('SITE_URL', $protocol . $host . $base_path);
define('API_URL', SITE_URL . 'api/');

// ============================================
// تابع اتصال به دیتابیس
// ============================================
function getDBConnection() {
    $conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
    
    if ($conn->connect_error) {
        error_log("Connection failed: " . $conn->connect_error);
        return null;
    }
    
    // تنظیم charset به utf8mb4 برای پشتیبانی از فارسی
    $conn->set_charset('utf8mb4');
    
    return $conn;
}

// ============================================
// توابع کمکی
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
    $result = $stmt->get_result();
    $stmt->close();
    $conn->close();
    
    return $success ? $result : false;
}

function fetchAll($sql, $params = [], $types = '') {
    $result = executeQuery($sql, $params, $types);
    if ($result === false) return [];
    
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
    echo json_encode($data, JSON_UNESCAPED_UNICODE);
    exit;
}

// ============================================
// تابع تست اتصال دیتابیس
// ============================================
function testDBConnection() {
    $conn = getDBConnection();
    if ($conn) {
        $conn->close();
        return ['success' => true, 'message' => 'اتصال به دیتابیس برقرار است'];
    } else {
        return ['success' => false, 'error' => 'خطا در اتصال به دیتابیس'];
    }
}
?>