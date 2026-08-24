<?php

declare(strict_types=1);

require_once __DIR__ . '/../../connect.php';

$orderid = (int)filterRequest('orderid');
if ($orderid <= 0) {
    jsonResponse(['status' => 'failure', 'message' => 'ID de pedido inválido.'], 422);
}

$stmt = $con->prepare("SELECT 
    items.*,
    cart.cart_itemcount,
    cart.cart_orders_price
FROM items
JOIN cart ON cart.cart_itemid = items.item_id
WHERE cart.cart_orderid = ?");
$stmt->execute([$orderid]);

$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
jsonResponse([
    'status' => 'success',
    'data' => $data,
]);
