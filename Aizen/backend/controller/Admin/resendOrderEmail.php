<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Handle preflight
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

require_once '../../vendor/autoload.php';
require_once '../../model/Connection.php';

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

$response = [ 'status' => 'error', 'message' => 'Unknown error' ];

try {
    $objDb = new DbConnect();
    $db = $objDb->connect();

    if (!$db) {
        throw new Exception('Database connection failed');
    }

    // Accept orderId from GET or JSON body
    $orderId = null;
    if (isset($_GET['orderId'])) {
        $orderId = (int)$_GET['orderId'];
    } else {
        $body = json_decode(file_get_contents('php://input'), true);
        if (isset($body['orderId'])) {
            $orderId = (int)$body['orderId'];
        }
    }

    if (!$orderId) {
        throw new Exception('Missing orderId');
    }

    // Fetch order basic info
    $stmt = $db->prepare("SELECT id, shipping_name, total, user_id, customer_id FROM orders WHERE id = :id");
    $stmt->execute(['id' => $orderId]);
    $order = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$order) {
        throw new Exception('Order not found');
    }

    $userId = $order['user_id'] ?? null;
    if (!$userId && isset($order['customer_id'])) {
        $userId = $order['customer_id'];
    }

    if (!$userId) {
        throw new Exception('Order has no associated user');
    }

    // Get user email and name (fallback to shipping_name if name unavailable)
    $userStmt = $db->prepare('SELECT email, name FROM users WHERE id = :id');
    $userStmt->execute(['id' => $userId]);
    $user = $userStmt->fetch(PDO::FETCH_ASSOC);

    if (!$user) {
        throw new Exception('User not found for order');
    }

    $userEmail = $user['email'];
    $userName = $order['shipping_name'] ?: ($user['name'] ?? 'Customer');

    // Fetch order items
    $itemsStmt = $db->prepare('SELECT p.name AS product_name, oi.quantity, oi.price FROM order_items oi JOIN products p ON oi.product_id = p.id WHERE oi.order_id = :orderId');
    $itemsStmt->execute(['orderId' => $orderId]);
    $orderItems = $itemsStmt->fetchAll(PDO::FETCH_ASSOC);

    // Build items HTML
    $itemsHtml = '';
    foreach ($orderItems as $item) {
        $pname = htmlspecialchars($item['product_name'], ENT_QUOTES, 'UTF-8');
        $qty = (int)$item['quantity'];
        $price = number_format((float)$item['price'], 2);
        $itemsHtml .= "<tr>\n<td style='padding: 10px; border-bottom: 1px solid #ddd;'>$pname</td>\n<td style='padding: 10px; border-bottom: 1px solid #ddd; text-align: center;'>$qty</td>\n<td style='padding: 10px; border-bottom: 1px solid #ddd; text-align: right;'>₹$price</td>\n</tr>";
    }

    // Compute total if missing
    $total = $order['total'];
    if (!$total) {
        $sum = 0.0;
        foreach ($orderItems as $item) {
            $sum += ((float)$item['price']) * ((int)$item['quantity']);
        }
        $total = $sum;
    }

    // Prepare mail
    $mail = new PHPMailer(true);
    $mail->isSMTP();
    $mail->Host = 'smtp.gmail.com';
    $mail->SMTPAuth = true;
    $mail->Username = 'aizendckap@gmail.com';
    $mail->Password = 'nxwe euhq phcg zjsz';
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
    $mail->Port = 587;

    $mail->setFrom('aizendckap@gmail.com', 'Agrolink Orders');
    $mail->addAddress($userEmail, $userName);

    // Embed image or fallback
    $imageTag = '';
    $localImagePath = __DIR__ . '/../assets/images/order_success.png';
    if (file_exists($localImagePath)) {
        $mail->addEmbeddedImage($localImagePath, 'order_success');
        $imageTag = "<center><img src='cid:order_success' alt='Order Success Image' style=\"max-width:100%;height:350px;display:block;margin:20px 0;\"></center>";
    } else {
        $fallbackUrl = 'https://cdn-icons-png.flaticon.com/512/845/845646.png';
        $imageTag = "<center><img src='" . htmlspecialchars($fallbackUrl, ENT_QUOTES, 'UTF-8') . "' alt='Order Success Image' style=\"max-width:100%;height:350px;display:block;margin:20px 0;\"></center>";
    }

    $safeName = htmlspecialchars($userName, ENT_QUOTES, 'UTF-8');
    $safeOrderId = htmlspecialchars((string)$orderId, ENT_QUOTES, 'UTF-8');
    $safeTotal = htmlspecialchars(number_format((float)$total, 2), ENT_QUOTES, 'UTF-8');

    $mail->isHTML(true);
    $mail->Subject = 'Order Confirmation (Resend)';
    $mail->Body = "<html><head><style>
        body { font-family: Montserrat, sans-serif; color:#333; margin:0; padding:0; background:#f7f7f7; }
        .container { max-width:600px; margin:20px auto; padding:20px; border:1px solid #ddd; border-radius:8px; background:#fff; box-shadow:0 4px 8px rgba(0,0,0,0.1); }
        h1 { text-align:center; color:#4CAF50; font-size:32px; margin-top:0; }
        h3 { text-align:center; color:black; }
        .order-summary { margin-top:20px; border:1px solid #ddd; border-radius:8px; overflow:hidden; }
        .order-summary-header { background:#4CAF50; padding:10px; font-size:18px; color:#fff; }
        table { width:100%; border-collapse:collapse; }
        th, td { padding:10px; text-align:left; }
        th { background:#f4f4f4; }
        .total { font-size:18px; font-weight:bold; text-align:right; padding:10px; border-top:2px solid #4CAF50; }
    </style></head><body>
    <div class='container'>
        <h1>Agrolink</h1>
        <h3>Order Confirmation</h3>
        $imageTag
        <p>Dear <span style='color:#4CAF50;'>$safeName</span>,</p>
        <p>Thank you for your order! Your order ID is <strong>$safeOrderId</strong> and the total amount is <strong>₹$safeTotal</strong>.</p>
        <p>Below is the summary of your order:</p>
        <div class='order-summary'>
            <div class='order-summary-header'>Order Summary</div>
            <table>
                <thead><tr><th>Product</th><th>Quantity</th><th>Price</th></tr></thead>
                <tbody>
                    $itemsHtml
                    <tr><td colspan='2' class='total'>Total</td><td class='total'>₹$safeTotal</td></tr>
                </tbody>
            </table>
        </div>
        <p>We are currently processing your order and will notify you once it has been shipped. If you have any questions, please reply to this email.</p>
        <div style='margin-top:30px; font-size:14px; color:#4CAF50; text-align:center;'>
            <p>Thank you for your purchase</p>
            <p><strong>Agrolink</strong></p>
        </div>
    </div>
    </body></html>";

    $mail->send();

    $response['status'] = 'success';
    $response['message'] = 'Order confirmation email resent successfully';
} catch (Exception $e) {
    $response['status'] = 'error';
    $response['message'] = 'Mailer error: ' . $e->getMessage();
} catch (\Throwable $t) {
    $response['status'] = 'error';
    $response['message'] = $t->getMessage();
}

echo json_encode($response);
