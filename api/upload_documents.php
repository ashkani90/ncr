<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

$ncrNumber = isset($_POST['ncr_number']) ? $_POST['ncr_number'] : '';

if (empty($ncrNumber)) {
    echo json_encode(['success' => false, 'error' => 'شماره NCR الزامی است']);
    exit;
}

// ⭐ ساخت پوشه مخصوص این NCR
$uploadDir = '../uploads/' . preg_replace('/[^A-Za-z0-9\-]/', '_', $ncrNumber) . '/';
if (!file_exists($uploadDir)) {
    mkdir($uploadDir, 0755, true);
}

$uploadedFiles = [];
$allowedExtensions = ['jpg', 'jpeg', 'png', 'gif', 'pdf', 'doc', 'docx', 'xls', 'xlsx'];
$maxFileSize = 5 * 1024 * 1024; // 5MB

if (isset($_FILES['documents']) && !empty($_FILES['documents']['name'][0])) {
    $fileCount = count($_FILES['documents']['name']);
    
    for ($i = 0; $i < $fileCount; $i++) {
        $fileName = $_FILES['documents']['name'][$i];
        $fileTmp = $_FILES['documents']['tmp_name'][$i];
        $fileSize = $_FILES['documents']['size'][$i];
        $fileError = $_FILES['documents']['error'][$i];
        
        if ($fileError !== UPLOAD_ERR_OK) continue;
        if ($fileSize > $maxFileSize) continue;
        
        // ⭐ بررسی پسوند
        $extension = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));
        if (!in_array($extension, $allowedExtensions)) continue;
        
        // ⭐ نام منحصر به فرد
        $uniqueName = time() . '_' . $i . '_' . preg_replace('/[^A-Za-z0-9\.\-_]/', '_', $fileName);
        $fullPath = $uploadDir . $uniqueName;
        
        if (move_uploaded_file($fileTmp, $fullPath)) {
            $uploadedFiles[] = [
                'name' => $fileName,
                'path' => 'uploads/' . preg_replace('/[^A-Za-z0-9\-]/', '_', $ncrNumber) . '/' . $uniqueName,
                'size' => $fileSize,
                'type' => $extension,
                'uploaded_at' => date('Y-m-d H:i:s')
            ];
        }
    }
}

echo json_encode([
    'success' => true,
    'files' => $uploadedFiles,
    'count' => count($uploadedFiles)
], JSON_UNESCAPED_UNICODE);
?>