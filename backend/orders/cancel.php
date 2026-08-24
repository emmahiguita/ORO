<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
requireRole($authUser, [0, 2]);
require_once __DIR__ . '/../order_service.php';

$orderId = (int)filterRequest('orderid');
if ($orderId <= 0) jsonResponse(['status' => 'failure'], 422);
$ownerId = (int)$authUser['role'] === 2 ? null : (int)$authUser['id'];
$result = cancelPendingOrder($con, $orderId, $ownerId);
if (!$result['ok']) jsonResponse(['status' => $result['code']], (int)$result['status']);
jsonResponse(['status' => 'success']);
