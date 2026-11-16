<?php
// ⭐⭐ نسخه دیباگ - نمایش خطاها
error_reporting(E_ALL);
ini_set('display_errors', 1);
ini_set('log_errors', 1);

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

require_once '../config/database.php';

$rawInput = file_get_contents('php://input');
error_log("RAW INPUT: " . $rawInput);

$data = json_decode($rawInput, true);

if (!$data) {
    jsonResponse(['success' => false, 'error' => 'JSON نامعتبر', 'raw' => $rawInput]);
}

if (!isset($data['title']) || !isset($data['message'])) {
    jsonResponse(['success' => false, 'error' => 'عنوان و پیام الزامی است']);
}

$user_id = null;
if (isset($data['user_id']) && $data['user_id'] !== null && $data['user_id'] !== '' && $data['user_id'] !== 0) {
    $user_id = (int)$data['user_id'];
    if ($user_id <= 0) $user_id = null;
}

$title   = $data['title'];
$message = $data['message'];
$type    = $data['type'] ?? 'info';
$link    = $data['link'] ?? '';

error_log("PARSED: user_id=$user_id, title=$title");

try {
    $conn = getDBConnection();
    if (!$conn) {
        jsonResponse(['success' => false, 'error' => 'خطا در اتصال به دیتابیس']);
    }

    // بررسی وجود کاربر
    if ($user_id !== null) {
        $checkSql = "SELECT id FROM users WHERE id = ?";
        $checkStmt = $conn->prepare($checkSql);
        if (!$checkStmt) {
            jsonResponse(['success' => false, 'error' => 'Prepare failed: ' . $conn->error]);
        }
        $checkStmt->bind_param('i', $user_id);
        $checkStmt->execute();
        $checkResult = $checkStmt->get_result();
        $userExists = $checkResult->fetch_assoc();
        $checkStmt->close();

        if (!$userExists) {
            error_log("User $user_id does not exist, making public notification");
            $user_id = null;
        }
    }

    // درج اعلان
    if ($user_id === null) {
        $sql = "INSERT INTO notifications (user_id, title, message, type, link) VALUES (NULL, ?, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        if (!$stmt) {
            jsonResponse(['success' => false, 'error' => 'Prepare failed: ' . $conn->error]);
        }
        $stmt->bind_param('ssss', $title, $message, $type, $link);
    } else {
        $sql = "INSERT INTO notifications (user_id, title, message, type, link) VALUES (?, ?, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        if (!$stmt) {
            jsonResponse(['success' => false, 'error' => 'Prepare failed: ' . $conn->error]);
        }
        $stmt->bind_param('issss', $user_id, $title, $message, $type, $link);
    }

    $success = $stmt->execute();
    $insertId = $conn->insert_id;
    $stmtError = $stmt->error;
    $stmt->close();

    error_log("INSERT result: success=$success, insertId=$insertId, error=$stmtError");

    if (!$success) {
        $conn->close();
        jsonResponse(['success' => false, 'error' => 'خطا در درج: ' . $stmtError]);
    }

    // درج notification_reads برای اعلان‌های شخصی
    if ($user_id !== null && $insertId) {
        $sql2 = "INSERT INTO notification_reads (notification_id, user_id, is_read) VALUES (?, ?, 0)";
        $stmt2 = $conn->prepare($sql2);
        if ($stmt2) {
            $stmt2->bind_param('ii', $insertId, $user_id);
            $readSuccess = $stmt2->execute();
            $readError = $stmt2->error;
            $stmt2->close();
            error_log("notification_reads insert: success=$readSuccess, error=$readError");
        } else {
            error_log("notification_reads prepare failed: " . $conn->error);
        }
    }

    $conn->close();

    jsonResponse([
        'success' => true,
        'id' => $insertId,
        'user_id' => $user_id,
        'is_public' => ($user_id === null)
    ]);

} catch (Exception $e) {
    error_log("EXCEPTION: " . $e->getMessage());
    jsonResponse(['success' => false, 'error' => $e->getMessage()]);
}
?>