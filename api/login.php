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

// دریافت داده‌های ارسالی
$data = json_decode(file_get_contents('php://input'), true);

// اگر داده‌ای دریافت نشد، خطا برگردان
if (!$data || !isset($data['username']) || !isset($data['password'])) {
    jsonResponse(['success' => false, 'error' => 'نام کاربری و رمز عبور الزامی است']);
}

$username = trim($data['username']);
$password = trim($data['password']);

// اتصال به دیتابیس
$conn = getDBConnection();
if (!$conn) {
    jsonResponse(['success' => false, 'error' => 'خطا در اتصال به دیتابیس']);
}

// بررسی وجود جدول users
$tableCheck = $conn->query("SHOW TABLES LIKE 'users'");
if ($tableCheck->num_rows == 0) {
    // اگر جدول وجود ندارد، ایجاد کن
    $createTable = "CREATE TABLE IF NOT EXISTS users (
        id INT PRIMARY KEY AUTO_INCREMENT,
        username VARCHAR(50) UNIQUE NOT NULL,
        password VARCHAR(255) NOT NULL,
        full_name VARCHAR(100) NOT NULL,
        email VARCHAR(100),
        role VARCHAR(50) NOT NULL,
        department VARCHAR(100),
        avatar VARCHAR(255),
        language VARCHAR(10) DEFAULT 'fa',
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        last_login DATETIME
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";
    $conn->query($createTable);
    
    // کاربران پیش‌فرض
    $insertUsers = "INSERT INTO users (username, password, full_name, email, role, department, language) VALUES 
        ('admin', 'admin123', 'مدیر سیستم', 'admin@ncr-system.com', 'admin', 'مدیریت', 'fa'),
        ('quality', 'quality123', 'علی حسینی', 'quality@ncr-system.com', 'quality', 'کنترل کیفیت', 'fa'),
        ('production', 'prod123', 'احمد رضایی', 'production@ncr-system.com', 'production', 'تولید', 'fa'),
        ('purchasing', 'purch123', 'محمد کریمی', 'purchasing@ncr-system.com', 'purchasing', 'خرید', 'fa'),
        ('warehouse', 'ware123', 'سارا محمدی', 'warehouse@ncr-system.com', 'warehouse', 'انبار', 'fa'),
        ('engineering', 'eng123', 'حسین طاهری', 'engineering@ncr-system.com', 'engineering', 'مهندسی', 'fa'),
        ('ceo', 'ceo123', 'مدیرعامل', 'ceo@ncr-system.com', 'ceo', 'مدیریت', 'fa')";
    $conn->query($insertUsers);
}

// جستجوی کاربر
$sql = "SELECT id, username, full_name, role, department, avatar, language 
        FROM users WHERE username = ? AND password = ?";

$stmt = $conn->prepare($sql);
if (!$stmt) {
    $conn->close();
    jsonResponse(['success' => false, 'error' => 'خطا در اجرای کوئری']);
}

$stmt->bind_param('ss', $username, $password);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();
$stmt->close();

if ($user) {
    // بروزرسانی آخرین ورود
    $updateSql = "UPDATE users SET last_login = NOW() WHERE id = ?";
    $updateStmt = $conn->prepare($updateSql);
    if ($updateStmt) {
        $updateStmt->bind_param('i', $user['id']);
        $updateStmt->execute();
        $updateStmt->close();
    }
    
    $conn->close();
    jsonResponse([
        'success' => true,
        'user' => $user
    ]);
} else {
    $conn->close();
    jsonResponse(['success' => false, 'error' => 'نام کاربری یا رمز عبور اشتباه است']);
}
?>