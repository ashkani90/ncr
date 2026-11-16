<?php
// test_db.php - تست اتصال به دیتابیس
error_reporting(E_ALL);
ini_set('display_errors', 1);
header('Content-Type: text/plain; charset=utf-8');

echo "Step 1: Starting test...\n";

// بررسی وجود فایل database.php
$dbPath = __DIR__ . '/../config/database.php';
echo "Step 2: Looking for database.php at: " . $dbPath . "\n";

if (!file_exists($dbPath)) {
    die("❌ ERROR: database.php NOT FOUND at " . $dbPath . "\n");
}
echo "✅ Step 3: database.php found\n";

// تلاش برای include
require_once $dbPath;
echo "✅ Step 4: database.php included successfully\n";

// بررسی وجود $pdo
if (!isset($pdo)) {
    die("❌ ERROR: \$pdo variable is NOT defined in database.php\n");
}
echo "✅ Step 5: \$pdo variable exists\n";

// تست کوئری ساده
try {
    $stmt = $pdo->query("SELECT COUNT(*) as cnt FROM organization_settings");
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    echo "✅ Step 6: Query successful. Rows in organization_settings: " . $row['cnt'] . "\n";
} catch (Exception $e) {
    die("❌ ERROR in query: " . $e->getMessage() . "\n");
}

echo "\n🎉 ALL TESTS PASSED!\n";
?>