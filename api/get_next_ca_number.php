<?php
error_reporting(E_ALL);
ini_set('display_errors', 0);

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

register_shutdown_function(function() {
    $error = error_get_last();
    if ($error && in_array($error['type'], [E_ERROR, E_PARSE, E_CORE_ERROR, E_COMPILE_ERROR])) {
        echo json_encode([
            'success' => false,
            'message' => 'Fatal PHP Error: ' . $error['message']
        ], JSON_UNESCAPED_UNICODE);
    }
});

try {
    $dbPath = __DIR__ . '/../config/database.php';
    
    if (!file_exists($dbPath)) {
        throw new Exception('database.php not found');
    }
    
    require_once $dbPath;
    
    if (!isset($pdo)) {
        throw new Exception('$pdo variable is not defined');
    }
    
    $year = date('Y');
    $pattern = 'CA-' . $year . '-%';
    
    // بررسی وجود جدول corrective_actions
    try {
        $stmt = $pdo->prepare("SELECT action_number FROM corrective_actions WHERE action_number LIKE :pattern ORDER BY id DESC LIMIT 1");
        $stmt->execute([':pattern' => $pattern]);
        $last = $stmt->fetch(PDO::FETCH_ASSOC);
        
        $nextNum = 1;
        if ($last && preg_match('/CA-\d{4}-(\d+)/', $last['action_number'], $m)) {
            $nextNum = intval($m[1]) + 1;
        }
    } catch (Exception $e) {
        // جدول وجود ندارد، از شماره پیش‌فرض استفاده کن
        $nextNum = 1;
    }
    
    echo json_encode([
        'success' => true,
        'ca_number' => 'CA-' . $year . '-' . str_pad($nextNum, 4, '0', STR_PAD_LEFT)
    ], JSON_UNESCAPED_UNICODE);
    
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ], JSON_UNESCAPED_UNICODE);
} catch (Error $e) {
    echo json_encode([
        'success' => false,
        'message' => 'PHP Error: ' . $e->getMessage()
    ], JSON_UNESCAPED_UNICODE);
}
?>