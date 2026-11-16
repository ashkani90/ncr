<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

$sql = "SELECT id, name, code, resource, action FROM permissions ORDER BY resource, action";
$permissions = fetchAll($sql);

jsonResponse([
    'success' => true,
    'data' => $permissions,
    'count' => count($permissions)
]);
?>