<?php
error_reporting(E_ALL);
ini_set('display_errors', 0);

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

require_once '../config/database.php';

$userId = isset($_GET['user_id']) ? (int)$_GET['user_id'] : 0;

if ($userId <= 0) {
    jsonResponse(['success' => false, 'error' => 'user_id الزامی است']);
}

// ⭐ اعلان‌های شخصی (user_id = X) + اعلان‌های عمومی (user_id IS NULL)
$sql = "SELECT 
            n.id,
            n.user_id,
            n.title,
            n.message,
            n.type,
            n.link,
            n.created_at,
            COALESCE(nr.is_read, 0) AS is_read,
            nr.read_at
        FROM notifications n
        LEFT JOIN notification_reads nr 
            ON n.id = nr.notification_id AND nr.user_id = ?
        WHERE (n.user_id = ? OR n.user_id IS NULL)
        ORDER BY n.created_at DESC
        LIMIT 100";

$notifications = fetchAll($sql, [$userId, $userId], 'ii');

foreach ($notifications as &$n) {
    $n['id']      = (int)$n['id'];
    $n['user_id'] = $n['user_id'] !== null ? (int)$n['user_id'] : null;
    $n['is_read'] = (int)$n['is_read'];
}
unset($n);

jsonResponse([
    'success' => true,
    'data'    => $notifications,
    'count'   => count($notifications),
    'debug_user_id' => $userId
]);
?>