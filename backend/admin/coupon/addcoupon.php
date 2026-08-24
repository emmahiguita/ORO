<?php

declare(strict_types=1);

require_once __DIR__ . '/../../connect.php';

$code = strtoupper(trim(filterRequest('code')));
$count = (int)filterRequest('count');
$discount = (float)filterRequest('discount');
$expirydate = filterRequest('expirydate');

if ($code === '' || $count <= 0 || $discount <= 0 || $discount > 100 || $expirydate === '') {
    jsonResponse(['status' => 'failure', 'message' => 'Parámetros de cupón inválidos.'], 422);
}

// Verifica si ya existe un cupón activo con el mismo código
$stmt = $con->prepare('SELECT coupon_id FROM coupon WHERE coupon_code = ? LIMIT 1');
$stmt->execute([$code]);
if ($stmt->fetchColumn()) {
    jsonResponse(['status' => 'failure', 'message' => 'Ya existe un cupón con este código.'], 409);
}

$data = [
    'coupon_code' => $code,
    'coupon_count' => $count,
    'coupon_discount' => $discount,
    'coupon_expirydate' => $expirydate,
];

insertData('coupon', $data);
