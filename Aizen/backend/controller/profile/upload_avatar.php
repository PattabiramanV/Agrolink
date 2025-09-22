<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');
header('Access-Control-Allow-Credentials: true');

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    exit(0);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Validate file upload first so we can return accurate errors for upload issues
    if (!isset($_FILES['avatar'])) {
        http_response_code(400);
        echo json_encode(["message" => "No image file uploaded."]);
        exit;
    }

    // Map common PHP upload errors to friendly messages
    if ($_FILES['avatar']['error'] !== UPLOAD_ERR_OK) {
        $errorMessages = [
            UPLOAD_ERR_INI_SIZE   => 'Uploaded file exceeds the server limit (upload_max_filesize).',
            UPLOAD_ERR_FORM_SIZE  => 'Uploaded file exceeds the form limit (MAX_FILE_SIZE).',
            UPLOAD_ERR_PARTIAL    => 'File was only partially uploaded.',
            UPLOAD_ERR_NO_FILE    => 'No file was uploaded.',
            UPLOAD_ERR_NO_TMP_DIR => 'Missing a temporary folder on the server.',
            UPLOAD_ERR_CANT_WRITE => 'Failed to write file to disk.',
            UPLOAD_ERR_EXTENSION  => 'A PHP extension stopped the file upload.'
        ];
        $msg = $errorMessages[$_FILES['avatar']['error']] ?? 'Unknown file upload error.';
        http_response_code(400);
        echo json_encode(["message" => $msg]);
        exit;
    }

    // Only now require user_id, since we know the file is valid and present
    if (!isset($_POST['user_id']) || $_POST['user_id'] === '') {
        http_response_code(400);
        echo json_encode(['message' => 'User ID is required']);
        exit();
    }

    $userId = $_POST['user_id'];

    if (isset($_FILES['avatar']) && $_FILES['avatar']['error'] === UPLOAD_ERR_OK) {
        $file = $_FILES['avatar'];
        $allowedTypes = ['image/jpeg', 'image/png'];

        if (!in_array($file['type'], $allowedTypes)) {
            http_response_code(400);
            echo json_encode(["message" => "Invalid file type. Only JPEG and PNG types are allowed."]);
            exit;
        }

        // Max upload size (in MB) for avatar images.
        // Set to 0 to disable application-level limit (server/php.ini limits may still apply).
        $maxSizeMB = 0;
        if ($maxSizeMB > 0) {
            $maxSizeBytes = $maxSizeMB * 1024 * 1024;
            if ($file['size'] > $maxSizeBytes) {
                http_response_code(400);
                echo json_encode(["message" => "File size exceeds the limit of {$maxSizeMB}MB."]);
                exit;
            }
        }

        $uploadDir = './uploads/';
        if (!is_dir($uploadDir)) {
            mkdir($uploadDir, 0755, true);
        }

        // Retrieve the current avatar filename from the database
        require_once '../../vendor/autoload.php';
        require_once '../../model/Connection.php';

        $dbConnect = new DbConnect();
        $pdo = $dbConnect->connect();

        $stmt = $pdo->prepare("SELECT avatar FROM users WHERE id = :id");
        $stmt->bindParam(':id', $userId);
        $stmt->execute();
        $currentAvatar = $stmt->fetchColumn();

        // Delete the current avatar file if it exists
        if ($currentAvatar && file_exists($uploadDir . $currentAvatar)) {
            unlink($uploadDir . $currentAvatar);
        }

        $extension = pathinfo($file['name'], PATHINFO_EXTENSION);
        $fileName = $userId . '.' . $extension;
        $filePath = $uploadDir . $fileName;

        if (move_uploaded_file($file['tmp_name'], $filePath)) {
            $stmt = $pdo->prepare("UPDATE users SET avatar = :avatar WHERE id = :id");
            $stmt->bindParam(':avatar', $fileName);
            $stmt->bindParam(':id', $userId);

            if ($stmt->execute()) {
                $fullUrl = "http://localhost:8000/controller/profile/uploads/" . $fileName; 
                echo json_encode(["message" => "Avatar uploaded and updated successfully.", "url" => $fullUrl]);
                http_response_code(200);
            } else {
                http_response_code(500);
                echo json_encode(["message" => "Failed to update avatar in the database."]);
            }
        } else {
            http_response_code(500);
            echo json_encode(["message" => "Failed to move uploaded file."]);
        }
    } else {
        http_response_code(400);
        echo json_encode(["message" => "No image file uploaded or upload error."]);
    }
} else {
    http_response_code(405);
    echo json_encode(["message" => "Invalid request method."]);
}
?>
