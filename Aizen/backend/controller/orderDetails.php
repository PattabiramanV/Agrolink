<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *'); // Adjust as needed for production
header('Access-Control-Allow-Methods: GET, POST, OPTIONS'); // Allow necessary methods
header('Access-Control-Allow-Headers: Content-Type, Authorization');

include "../model/Connection.php"; // Include your DB connection file

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

// Get user ID from query parameters and validate it
$userId = isset($_GET['id']) ? (int)$_GET['id'] : 0;
if ($userId <= 0) {
    echo json_encode([
        'success' => false,
        'message' => 'Invalid user ID'
    ]);
    exit;
}

try {
    $db = new DbConnect();
    $pdo = $db->connect();

    // Determine correct user reference column on orders
    $userIdColumn = null;
    try {
        $probe = $pdo->prepare("SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'orders' AND COLUMN_NAME = 'user_id'");
        $probe->execute();
        if ($probe->fetchColumn()) {
            $userIdColumn = 'user_id';
        } else {
            $probe = $pdo->prepare("SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'orders' AND COLUMN_NAME = 'customer_id'");
            $probe->execute();
            if ($probe->fetchColumn()) {
                $userIdColumn = 'customer_id';
            }
        }
    } catch (Exception $e) {
        $userIdColumn = 'user_id'; // best-effort fallback
    }

    if (!$userIdColumn) {
        echo json_encode([
            'success' => false,
            'message' => "Orders table missing user reference column ('user_id' or 'customer_id')"
        ]);
        exit;
    }

    // Detect optional columns on orders
    $hasPaymentMethod = false;
    $hasStatus = false;
    $hasTotal = false;
    try {
        $probe = $pdo->prepare("SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'orders' AND COLUMN_NAME = 'payment_method'");
        $probe->execute();
        $hasPaymentMethod = (bool)$probe->fetchColumn();
        $probe = $pdo->prepare("SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'orders' AND COLUMN_NAME = 'status'");
        $probe->execute();
        $hasStatus = (bool)$probe->fetchColumn();
        $probe = $pdo->prepare("SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'orders' AND COLUMN_NAME = 'total'");
        $probe->execute();
        $hasTotal = (bool)$probe->fetchColumn();
    } catch (Exception $e) {
        // leave defaults as false
    }

    // Build SQL dynamically with detected columns
    $selects = [
        "o.id AS order_id",
        // Prefer o.total if exists; otherwise compute per order via subquery
        $hasTotal ? "o.total AS total_amount" : "(SELECT SUM(oi2.quantity * oi2.price) FROM order_items oi2 WHERE oi2.order_id = o.id) AS total_amount",
        "oi.product_id",
        "oi.quantity",
        "p.name AS product_name",
        "p.images AS product_image",
        "p.selling_price AS price",
        "o.shipping_name",
        "o.house_detail",
        "o.area_town",
        "o.zipcode",
        "o.phone_no",
        $hasPaymentMethod ? "o.payment_method" : "NULL AS payment_method",
        $hasStatus ? "o.status" : "NULL AS status",
        "o.created_at",
    ];

    $sql = "
    SELECT 
        " . implode(",\n        ", $selects) . "
    FROM 
        orders o
    JOIN 
        order_items oi ON o.id = oi.order_id
    JOIN 
        products p ON oi.product_id = p.id
    WHERE 
        o.$userIdColumn = :userId
    ";

    $stmt = $pdo->prepare($sql);
    $stmt->bindParam(':userId', $userId, PDO::PARAM_INT);
    $stmt->execute();
    $orderDetails = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if ($orderDetails) {
        $response = [
            'success' => true,
            'data' => $orderDetails
        ];
    } else {
        $response = [
            'success' => false,
            'message' => 'No orders found for this user'
        ];
    }
    
} catch (PDOException $e) {
    // Log the error internally, but do not expose detailed errors to users
    error_log('Database error: ' . $e->getMessage());
    $response = [
        'success' => false,
        'message' => 'An error occurred while fetching order details'
    ];
}

echo json_encode($response);
?>
