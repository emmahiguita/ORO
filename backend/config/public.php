<?php

declare(strict_types=1);

include '../connect.php';

$config = $GLOBALS['APP_CONFIG'] ?? [];
jsonResponse([
    'status' => 'success',
    'data' => [
        'delivery_fee' => round((float)($config['delivery_fee'] ?? 10.0), 2),
        'currency' => (string)($config['currency'] ?? 'COP'),
        'online_payments_enabled' => false,
    ],
]);
