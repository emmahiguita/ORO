<?php

declare(strict_types=1);
include __DIR__ . '/../../connect.php';
require_once __DIR__ . '/../../order_service.php';

$orderId = (int)filterRequest('orderid');
if ($orderId <= 0) jsonResponse(['status' => 'failure'], 422);
$result = cancelPendingOrder($con, $orderId, null);
if (!$result['ok']) jsonResponse(['status' => $result['code']], (int)$result['status']);
$userId = (int)$result['user_id'];
sendToNotification(
    'Pedido cancelado',
    "Tu pedido #$orderId fue cancelado. Si necesitas ayuda, contacta a soporte.",
    $userId,
    (string)$orderId,
    'order',
    null,
    'cancel'
);
jsonResponse(['status' => 'success']);
