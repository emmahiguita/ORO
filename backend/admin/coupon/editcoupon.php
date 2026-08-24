<?php

declare(strict_types=1);

require_once __DIR__ . '/../../connect.php';

$id = (int)filterRequest('id');
$code = strtoupper(trim(filterRequest('code')));
$count = (int)filterRequest('count');
$discount = (float)filterRequest('discount');
$expirydate = filterRequest('expirydate');

if ($id <= 0 || $code === '' || $count < 0 || $discount <= 0 || $discount > 100 || $expirydate === '') {
    jsonResponse(['status' => 'failure', 'message' => 'Parámetros de cupón inválidos.'], 422);
}

// Verifica si ya existe otro cupón con el mismo código
$stmt = $con->prepare('SELECT coupon_id FROM coupon WHERE coupon_code = ? AND coupon_id != ? LIMIT 1');
$stmt->execute([$code, $id]);
if ($stmt->fetchColumn()) {
    jsonResponse(['status' => 'failure', 'message' => 'Ya existe otro cupón con este código.'], 409);
}

$data = [
    'coupon_code' => $code,
    'coupon_count' => $count,
    'coupon_discount' => $discount,
    'coupon_expirydate' => $expirydate,
];

updateData('coupon', $data, "coupon_id = $id");
