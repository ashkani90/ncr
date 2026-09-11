<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

$stats = [];

// کل NCRها
$result = executeQuery("SELECT COUNT(*) as total FROM ncrs");
$row = $result->fetch_assoc();
$stats['total_ncr'] = (int)$row['total'];

// NCR باز
$result = executeQuery("SELECT COUNT(*) as total FROM ncrs WHERE final_status = 'open'");
$row = $result->fetch_assoc();
$stats['open_ncr'] = (int)$row['total'];

// NCR در حال بررسی
$result = executeQuery("SELECT COUNT(*) as total FROM ncrs WHERE final_status = 'in_progress'");
$row = $result->fetch_assoc();
$stats['in_progress_ncr'] = (int)$row['total'];

// NCR بسته
$result = executeQuery("SELECT COUNT(*) as total FROM ncrs WHERE final_status = 'closed'");
$row = $result->fetch_assoc();
$stats['closed_ncr'] = (int)$row['total'];

// NCR رد شده
$result = executeQuery("SELECT COUNT(*) as total FROM ncrs WHERE final_status = 'rejected'");
$row = $result->fetch_assoc();
$stats['rejected_ncr'] = (int)$row['total'];

// کلیم‌ها
$result = executeQuery("SELECT COUNT(*) as total FROM claims");
$row = $result->fetch_assoc();
$stats['total_claims'] = (int)$row['total'];

// کلیم باز
$result = executeQuery("SELECT COUNT(*) as total FROM claims WHERE final_status != 'closed'");
$row = $result->fetch_assoc();
$stats['open_claims'] = (int)$row['total'];

// کلیم بسته
$result = executeQuery("SELECT COUNT(*) as total FROM claims WHERE final_status = 'closed'");
$row = $result->fetch_assoc();
$stats['closed_claims'] = (int)$row['total'];

// عدم ارسال قطعه
$result = executeQuery("SELECT COUNT(*) as total FROM shortages");
$row = $result->fetch_assoc();
$stats['total_shortages'] = (int)$row['total'];

// درخواست خرید
$result = executeQuery("SELECT COUNT(*) as total FROM purchase_requests");
$row = $result->fetch_assoc();
$stats['total_purchases'] = (int)$row['total'];

// اولویت بالا
$result = executeQuery("SELECT COUNT(*) as total FROM ncrs WHERE priority = 'high'");
$row = $result->fetch_assoc();
$stats['high_priority_ncr'] = (int)$row['total'];

jsonResponse(['success' => true, 'data' => $stats]);
?>