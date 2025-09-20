<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *'); // Allow all origins, adjust as needed
header('Access-Control-Allow-Methods: GET, POST, OPTIONS'); // Allow necessary methods
header('Access-Control-Allow-Headers: Content-Type, Authorization'); // Allow necessary headers

// Handle preflight request for OPTIONS method
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

include "../model/Connection.php";
require '../vendor/autoload.php'; // Load PHPMailer using Composer's autoload

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

// Enable detailed error reporting
error_reporting(E_ALL);
ini_set('display_errors', 1);

class CheckoutController
{
    private $db;

    public function __construct()
    {
        $objDb = new DbConnect();
        $this->db = $objDb->connect();
    }

    private function columnExists($table, $column)
    {
        try {
            $stmt = $this->db->prepare("SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = :table AND COLUMN_NAME = :column");
            $stmt->execute(['table' => $table, 'column' => $column]);
            return (bool)$stmt->fetchColumn();
        } catch (Exception $e) {
            // Fallback: attempt a harmless query
            return false;
        }
    }

    public function handleCheckout()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $data = json_decode(file_get_contents('php://input'), true);

            // Debugging: Print the entire received data
            error_log('Received data: ' . print_r($data, true));

            if (!isset($data['cartItems'])) {
                echo json_encode(['status' => 'error', 'message' => 'Cart items are missing from the request.']);
                return;
            }

            // Extract and sanitize input data
            $shippingName = filter_var($data['shippingName'] ?? '', FILTER_SANITIZE_FULL_SPECIAL_CHARS);
            $userId = filter_var($data['userId'] ?? '', FILTER_SANITIZE_NUMBER_INT);
            $total = filter_var($data['total'] ?? 0, FILTER_SANITIZE_NUMBER_FLOAT, FILTER_FLAG_ALLOW_FRACTION);
            $houseDetail = filter_var($data['houseDetail'] ?? '', FILTER_SANITIZE_FULL_SPECIAL_CHARS);
            $areaTown = filter_var($data['city'] ?? '', FILTER_SANITIZE_FULL_SPECIAL_CHARS);
            $zipcode = filter_var($data['zipcode'] ?? '', FILTER_SANITIZE_FULL_SPECIAL_CHARS);
            $phoneNo = filter_var($data['phoneNo'] ?? '', FILTER_SANITIZE_FULL_SPECIAL_CHARS);
            $countryId = filter_var($data['Country'] ?? '', FILTER_SANITIZE_NUMBER_INT); // Expecting country ID
            $stateId = filter_var($data['stateSelect'] ?? '', FILTER_SANITIZE_NUMBER_INT); // Expecting state ID
            $paymentMethod = filter_var($data['paymentMethod'] ?? '', FILTER_SANITIZE_FULL_SPECIAL_CHARS);
            $cartItems = $data['cartItems'] ?? [];

            // Debugging: Check the cart items structure
            error_log('Cart Items: ' . print_r($cartItems, true));

            $validPaymentMethods = ['cod']; // Add more valid methods if needed

            // Validate required fields with detailed feedback
            $missing = [];
            if (empty($userId)) $missing[] = 'userId';
            if (empty($shippingName)) $missing[] = 'shippingName';
            if (empty($houseDetail)) $missing[] = 'houseDetail';
            if (empty($areaTown)) $missing[] = 'city';
            if (empty($zipcode)) $missing[] = 'zipcode';
            if (empty($phoneNo)) $missing[] = 'phoneNo';
            if (empty($countryId)) $missing[] = 'Country';
            if (empty($stateId)) $missing[] = 'stateSelect';
            if (!empty($missing)) {
                echo json_encode(['status' => 'error', 'message' => 'Required fields are missing.', 'missing' => $missing]);
                return;
            }

            // If a payment method is provided, ensure it's valid; otherwise allow empty (schema may not store it)
            if (!empty($paymentMethod) && !in_array($paymentMethod, $validPaymentMethods)) {
                echo json_encode(['status' => 'error', 'message' => 'Invalid payment method specified.']);
                return;
            }

            try {
                // Validate and Get Country
                $findCountry = $this->db->prepare("SELECT id FROM countries WHERE id = :id");
                $findCountry->execute(['id' => $countryId]);
                if (!$findCountry->fetch(PDO::FETCH_ASSOC)) {
                    echo json_encode(['status' => 'error', 'message' => 'Invalid country specified.']);
                    return;
                }

                // Validate and Get State
                $findState = $this->db->prepare("SELECT id FROM states WHERE id = :id AND country_id = :countryId");
                $findState->execute(['id' => $stateId, 'countryId' => $countryId]);
                if (!$findState->fetch(PDO::FETCH_ASSOC)) {
                    echo json_encode(['status' => 'error', 'message' => 'Invalid state specified or the state does not belong to the specified country.']);
                    return;
                }

                // Determine correct user id column name in orders table
                $userIdColumn = $this->columnExists('orders', 'user_id') ? 'user_id' : ($this->columnExists('orders', 'customer_id') ? 'customer_id' : null);
                if ($userIdColumn === null) {
                    echo json_encode(['status' => 'error', 'message' => "Orders table is missing a user reference column (expected 'user_id' or 'customer_id')."]);
                    return;
                }

                // Compute total from cart items if not provided
                if (empty($total) && !empty($cartItems)) {
                    $sum = 0;
                    foreach ($cartItems as $ci) {
                        $q = (int)($ci['quantity'] ?? 0);
                        $p = (float)($ci['selling_price'] ?? 0);
                        $sum += ($q * $p);
                    }
                    $total = $sum;
                }

                // Build dynamic insert based on available columns in orders table
                $columns = ['shipping_name', $userIdColumn, 'house_detail', 'area_town', 'zipcode', 'phone_no', 'country_id', 'state_id'];
                $values = [$shippingName, $userId, $houseDetail, $areaTown, $zipcode, $phoneNo, $countryId, $stateId];

                if ($this->columnExists('orders', 'total')) {
                    array_splice($columns, 2, 0, 'total'); // after shipping_name and userIdColumn
                    array_splice($values, 2, 0, $total);
                }
                if ($this->columnExists('orders', 'payment_method') && !empty($paymentMethod)) {
                    // Insert payment_method at end
                    $columns[] = 'payment_method';
                    $values[] = $paymentMethod;
                }

                $placeholders = implode(', ', array_fill(0, count($columns), '?'));
                $columnsSql = implode(', ', $columns);
                $sql = "INSERT INTO orders ($columnsSql) VALUES ($placeholders)";
                $stmt = $this->db->prepare($sql);
                $success = $stmt->execute($values);

                if ($success) {
                    $orderId = $this->db->lastInsertId();
                    error_log("Order ID: $orderId");

                    // Check if cart items are provided
                    if (empty($cartItems)) {
                        echo json_encode(['status' => 'warning', 'message' => 'No items in the cart.']);
                        return;
                    }

                    // Update cart item quantities and insert order items
                    foreach ($cartItems as $item) {
                        // Debugging: Print each cart item
                        error_log('Processing cart item: ' . print_r($item, true));

                        // Extract cart item details
                        $cartItemId = filter_var($item['cart_item_id'] ?? null, FILTER_SANITIZE_NUMBER_INT);
                        $productId = filter_var($item['product_id'] ?? null, FILTER_SANITIZE_NUMBER_INT);
                        $quantity = filter_var($item['quantity'] ?? 0, FILTER_SANITIZE_NUMBER_INT);
                        $price = filter_var($item['selling_price'] ?? 0, FILTER_SANITIZE_NUMBER_FLOAT, FILTER_FLAG_ALLOW_FRACTION);

                        if (!$cartItemId || !$quantity) {
                            error_log('Missing cart_item_id or quantity for cart item: ' . print_r($item, true));
                            echo json_encode(['status' => 'error', 'message' => 'Cart item ID or quantity is required.']);
                            return;
                        }

                        // Verify if product exists
                        $findProduct = $this->db->prepare("SELECT id FROM products WHERE id = :id");
                        $findProduct->execute(['id' => $productId]);
                        if (!$findProduct->fetch(PDO::FETCH_ASSOC)) {
                            error_log('Product ID not found: ' . $productId);
                            echo json_encode(['status' => 'error', 'message' => 'Invalid product ID: ' . $productId]);
                            return;
                        }

                        // Update cart item quantity
                        $updateCartItem = $this->db->prepare("UPDATE cart_item SET quantity = :quantity WHERE cart_item_id = :cart_item_id");
                        $updateCartItem->bindParam(':quantity', $quantity, PDO::PARAM_INT);
                        $updateCartItem->bindParam(':cart_item_id', $cartItemId, PDO::PARAM_INT);
                        $updateCartItem->execute();

                        // Insert order item
                        $stmt = $this->db->prepare("INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)");
                        $success = $stmt->execute([$orderId, $productId, $quantity, $price]);

                        if (!$success) {
                            error_log('Failed to process cart item: ' . implode(' ', $this->db->errorInfo()));
                            echo json_encode(['status' => 'error', 'message' => 'Failed to process cart item.']);
                            return;
                        }
                    }

                    // Remove cart items after successful order placement
                    $deleteCartItems = $this->db->prepare("DELETE FROM cart_item WHERE cart_id = (SELECT cart_id FROM cart WHERE user_id = ?)");
                    $deleteCartItems->execute([$userId]);

                    // Retrieve user email
                    $getUserEmail = $this->db->prepare("SELECT email FROM users WHERE id = :userId");
                    $getUserEmail->execute(['userId' => $userId]);
                    $user = $getUserEmail->fetch(PDO::FETCH_ASSOC);
                    
                    if ($user) {
                        $userEmail = $user['email'];
                        // Send confirmation email
                        $this->sendConfirmationEmail($shippingName, $userEmail, $total, $orderId);
                    } else {
                        error_log('User not found: ' . $userId);
                        echo json_encode(['status' => 'error', 'message' => 'User email not found.']);
                        return;
                    }

                    echo json_encode(['status' => 'success', 'message' => 'Order submitted successfully.']);
                } else {
                    error_log('Failed to submit order: ' . implode(' ', $this->db->errorInfo()));
                    echo json_encode(['status' => 'error', 'message' => 'Failed to submit order.']);
                }
            } catch (PDOException $e) {
                error_log('PDOException: ' . $e->getMessage());
                echo json_encode(['status' => 'error', 'message' => 'An error occurred while processing the order: ' . $e->getMessage()]);
            }
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Invalid request method.']);
        }
    }

    private function sendConfirmationEmail($userName, $userEmail, $total, $orderId)
    {
        $mail = new PHPMailer(true);
    
        try {
            // Server settings
            $mail->isSMTP();
            $mail->Host = 'smtp.gmail.com'; // Replace with your SMTP host
            $mail->SMTPAuth = true;
            $mail->Username = 'aizendckap@gmail.com'; // Replace with your SMTP username
            $mail->Password = 'nxwe euhq phcg zjsz'; // Replace with your SMTP password
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
            $mail->Port = 587;
    
            // Recipients
            $mail->setFrom('no-reply@example.com', 'Agrolink Orders');
            $mail->addAddress($userEmail); // Use the customer's email
    
            // Retrieve order items
            $orderItemsQuery = $this->db->prepare("
                SELECT p.name AS product_name, oi.quantity, oi.price 
                FROM order_items oi 
                JOIN products p ON oi.product_id = p.id 
                WHERE oi.order_id = ?
            ");
            $orderItemsQuery->execute([$orderId]);
            $orderItems = $orderItemsQuery->fetchAll(PDO::FETCH_ASSOC);
    
            // Build the cart items summary
            $itemsHtml = '';
            foreach ($orderItems as $item) {
                $itemsHtml .= "
                    <tr>
                        <td style='padding: 10px; border-bottom: 1px solid #ddd;'>{$item['product_name']}</td>
                        <td style='padding: 10px; border-bottom: 1px solid #ddd; text-align: center;'>{$item['quantity']}</td>
                        <td style='padding: 10px; border-bottom: 1px solid #ddd; text-align: right;'>₹{$item['price']}</td>
                    </tr>";
            }
    
            // Content
            $imageUrl = 'https://cdn.discordapp.com/attachments/1163859351568650270/1277507116361580544/Successful_purchase-pana.png?ex=66cf64f7&is=66ce1377&hm=46f21165a33fd221285dcb8b51df6b2cdc15074e2de562cd22176b71169a1c62&';
    
            $mail->isHTML(true);
            $mail->Subject = 'Order Confirmation';
            $mail->Body = "
            <html>
            <head>
                <style>
                    body {
                        font-family: Montserrat, sans-serif;
                        color: #333;
                        margin: 0;
                        padding: 0;
                        background-color: #f7f7f7;
                    }
                    .container {
                        max-width: 600px;
                        margin: 20px auto;
                        padding: 20px;
                        border: 1px solid #ddd;
                        border-radius: 8px;
                        background-color: #ffffff;
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                    }
                    h1 {
                        text-align: center;
                        color: #4CAF50;
                        font-size: 32px;
                        margin-top: 0;
                        font-family:'Montserrat, cursive';
                    }
                    h3{
                        text-align: center;
                        color:black;
                    }

                    p {
                        font-size: 16px;
                        line-height: 1.6;
                        margin: 0 0 10px;
                    }
                    .highlight {
                        color: #4CAF50;
                    }
                    .footer {
                        margin-top: 30px;
                        font-size: 14px;
                        color: #4CAF50;
                        text-align: center;
                    }
                    .footer p {
                        margin: 5px 0;
                    }
                    .order-summary {
                        margin-top: 20px;
                        border: 1px solid #ddd;
                        border-radius: 8px;
                        overflow: hidden;
                    }
                    .order-summary-header {
                        background-color: #4CAF50;
                        padding: 10px;
                        font-size: 18px;
                        color: #ffffff;
                    }
                    .order-summary-content {
                        padding: 10px;
                    }
                    table {
                        width: 100%;
                        border-collapse: collapse;
                    }
                    th, td {
                        padding: 10px;
                        text-align: left;
                    }
                    th {
                        background-color: #f4f4f4;
                    }
                    .total {
                        font-size: 18px;
                        font-weight: bold;
                        text-align: right;
                        padding: 10px;
                        border-top: 2px solid #4CAF50;
                    }
                        img {
                        max-width: 100%;
                        height: 350px;
                        display: block;
                        margin: 20px 0;
                    }
                </style>
            </head>
            <body>
                <div class='container'>
                    <h1>Agrolink</h1>
                    <h3>Order Confirmation</h3>
                                        <center><img src='" . htmlspecialchars($imageUrl, ENT_QUOTES, 'UTF-8') . "' alt='Welcome Image'></center>

                    <p>Dear <span class='highlight'>" . htmlspecialchars($userName, ENT_QUOTES, 'UTF-8') . "</span>,</p>
                    <p>Thank you for your order! Your order ID is <strong>" . htmlspecialchars($orderId, ENT_QUOTES, 'UTF-8') . "</strong> and the total amount is <strong>₹" . htmlspecialchars($total, ENT_QUOTES, 'UTF-8') . "</strong>.</p>
                    <p>Below is the summary of your order:</p>
                    <div class='order-summary'>
                        <div class='order-summary-header'>
                            Order Summary
                        </div>
                        <div class='order-summary-content'>
                            <table>
                                <thead>
                                    <tr>
                                        <th>Product</th>
                                        <th>Quantity</th>
                                        <th>Price</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    " . $itemsHtml . "
                                    <tr>
                                        <td colspan='2' class='total'>Total</td>
                                        <td class='total'>₹" . htmlspecialchars($total, ENT_QUOTES, 'UTF-8') . "</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <p>We are currently processing your order and will notify you once it has been shipped. If you have any questions, please do not hesitate to contact us.</p>
                    <div class='footer'>
                        <p>Thank you for your purchase</p>
                        <p><strong>Agrolink</strong></p>
                    </div>
                </div>
            </body>
            </html>
            ";
    
            // Send email
            $mail->send();
        } catch (Exception $e) {
            echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
        }
    }
    
    }
    
    
    
    

$checkoutController = new CheckoutController();
$checkoutController->handleCheckout();
?>