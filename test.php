<?php
echo "<h1>🔍 System Diagnostic Test</h1>";

// اطلاعات سرور
echo "<h2>Server Information:</h2>";
echo "PHP Version: " . phpversion() . "<br>";
echo "MySQLi: " . (extension_loaded('mysqli') ? '✅ Enabled' : '❌ Disabled') . "<br>";

require_once 'config/database.php';

echo "<h2>Database Connection Test:</h2>";

// تست اتصال با تابع
$result = testDBConnection();
echo "<pre>";
print_r($result);
echo "</pre>";

// تست اتصال مستقیم
echo "<h2>Direct Connection Test:</h2>";
$conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
if ($conn->connect_error) {
    echo "❌ Connection failed: " . $conn->connect_error . "<br>";
} else {
    echo "✅ Connection successful!<br>";
    $conn->set_charset('utf8mb4');
    
    // نمایش لیست جداول
    $tables = $conn->query("SHOW TABLES");
    echo "<h3>📋 Tables in database:</h3><ul>";
    $hasUsers = false;
    while ($row = $tables->fetch_row()) {
        echo "<li>" . $row[0] . "</li>";
        if ($row[0] === 'users') $hasUsers = true;
    }
    echo "</ul>";
    
    // اگر جدول users وجود ندارد، ایجاد کن
    if (!$hasUsers) {
        echo "<h3>⚠️ Table 'users' not found! Creating...</h3>";
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
        
        if ($conn->query($createTable)) {
            echo "✅ Table 'users' created successfully!<br>";
            
            // اضافه کردن کاربران پیش‌فرض
            $insertUsers = "INSERT INTO users (username, password, full_name, email, role, department, language) VALUES 
                ('admin', 'admin123', 'مدیر سیستم', 'admin@ncr-system.com', 'admin', 'مدیریت', 'fa'),
                ('quality', 'quality123', 'علی حسینی', 'quality@ncr-system.com', 'quality', 'کنترل کیفیت', 'fa'),
                ('production', 'prod123', 'احمد رضایی', 'production@ncr-system.com', 'production', 'تولید', 'fa'),
                ('purchasing', 'purch123', 'محمد کریمی', 'purchasing@ncr-system.com', 'purchasing', 'خرید', 'fa'),
                ('warehouse', 'ware123', 'سارا محمدی', 'warehouse@ncr-system.com', 'warehouse', 'انبار', 'fa'),
                ('engineering', 'eng123', 'حسین طاهری', 'engineering@ncr-system.com', 'engineering', 'مهندسی', 'fa'),
                ('ceo', 'ceo123', 'مدیرعامل', 'ceo@ncr-system.com', 'ceo', 'مدیریت', 'fa')";
            
            if ($conn->query($insertUsers)) {
                echo "✅ Default users inserted!<br>";
            } else {
                echo "❌ Error inserting users: " . $conn->error . "<br>";
            }
        } else {
            echo "❌ Error creating table: " . $conn->error . "<br>";
        }
    }
    
    // نمایش کاربران
    echo "<h3>👤 Users in database:</h3>";
    $users = $conn->query("SELECT * FROM users");
    if ($users && $users->num_rows > 0) {
        echo "<table border='1' cellpadding='8'>";
        echo "<tr><th>ID</th><th>Username</th><th>Full Name</th><th>Role</th><th>Department</th></tr>";
        while ($u = $users->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . $u['id'] . "</td>";
            echo "<td>" . $u['username'] . "</td>";
            echo "<td>" . $u['full_name'] . "</td>";
            echo "<td>" . $u['role'] . "</td>";
            echo "<td>" . ($u['department'] ?? '-') . "</td>";
            echo "</tr>";
        }
        echo "</table>";
    } else {
        echo "<p>❌ No users found!</p>";
    }
    
    $conn->close();
}

echo "<h2>API Test:</h2>";
echo "<a href='api/get_users.php' target='_blank'>Test get_users.php</a><br>";
echo "<a href='api/test_connection.php' target='_blank'>Test API Connection</a>";
?>