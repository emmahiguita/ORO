<?php

declare(strict_types=1);

require_once __DIR__ . '/../../connect.php';

$stmt = $con->query("SELECT 
    orders.order_id,
    orders.order_type,
    orders.order_price,
    orders.order_pricedelivery,
    orders.order_totalprice,
    orders.order_paymenttype,
    orders.order_status,
    orders.order_datetime,
    coupon.coupon_code,
    coupon.coupon_discount, 
    user.user_id,
    user.user_name,
    user.user_email,
    user.user_phone,
    user.user_pfp,
    address.address_id,
    address.address_city,
    address.address_street,
    address.address_lat,
    address.address_long,
    address.address_name,
    address.address_deliverytime,
    address.address_marker
FROM `orders`
JOIN `user` ON orders.order_userid = user.user_id
LEFT JOIN `address` ON address.address_id = orders.order_addressid AND orders.order_addressid != 0
LEFT JOIN `coupon` ON coupon.coupon_id = orders.order_coupon AND orders.order_coupon != 0
ORDER BY orders.order_datetime DESC");

$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
jsonResponse([
    'status' => 'success',
    'data' => $data,
]);
