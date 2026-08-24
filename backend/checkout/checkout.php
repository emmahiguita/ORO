<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
requireRole($authUser, [0]);

$userId = (int)$authUser['id'];
$deliveryType = (int)filterRequest('type');       // 0 = domicilio, 1 = recogida
$paymentType = (int)filterRequest('paymenttype'); // 4 = contra entrega/recogida
$couponId = max(0, (int)filterRequest('coupon'));
$addressId = max(0, (int)filterRequest('ordaddressiderid'));

if (!in_array($deliveryType, [0, 1], true)) {
    jsonResponse(['status' => 'failure', 'message' => 'Tipo de entrega inválido.'], 422);
}
if ($paymentType !== 4) {
    jsonResponse([
        'status' => 'payment_not_supported',
        'message' => 'Los pagos en línea no están habilitados. Usa pago contra entrega/recogida.',
    ], 422);
}

$config = $GLOBALS['APP_CONFIG'] ?? [];
$deliveryFee = $deliveryType === 0 ? max(0, (int)round((float)($config['delivery_fee'] ?? 0))) : 0;
$currency = (string)($config['currency'] ?? 'COP');

try {
    $con->beginTransaction();

    if ($deliveryType === 0) {
        if ($addressId <= 0) {
            $con->rollBack();
            jsonResponse(['status' => 'address_required'], 422);
        }
        $address = $con->prepare('SELECT address_id FROM address WHERE address_id=? AND address_userid=? LIMIT 1 FOR UPDATE');
        $address->execute([$addressId, $userId]);
        if (!$address->fetchColumn()) {
            $con->rollBack();
            jsonResponse(['status' => 'invalid_address'], 403);
        }
    } else {
        $addressId = 0;
    }

    // Bloquea carrito + productos durante el cálculo para que stock/precio no
    // cambien a mitad del checkout.
    $cartStmt = $con->prepare(
        'SELECT c.cart_id,c.cart_itemid,i.item_price,i.item_discount,i.item_count,i.item_active '
        . 'FROM cart c JOIN items i ON i.item_id=c.cart_itemid '
        . 'WHERE c.cart_userid=? AND c.cart_orderid=0 ORDER BY c.cart_id FOR UPDATE'
    );
    $cartStmt->execute([$userId]);
    $rows = $cartStmt->fetchAll(PDO::FETCH_ASSOC);
    if (!$rows) {
        $con->rollBack();
        jsonResponse(['status' => 'empty_cart'], 409);
    }

    $quantities = [];
    $products = [];
    foreach ($rows as $row) {
        $itemId = (int)$row['cart_itemid'];
        $quantities[$itemId] = ($quantities[$itemId] ?? 0) + 1;
        $products[$itemId] = $row;
    }

    $subtotal = 0.0;
    foreach ($quantities as $itemId => $qty) {
        $product = $products[$itemId];
        if ((int)$product['item_active'] !== 1) {
            $con->rollBack();
            jsonResponse(['status' => 'product_unavailable', 'item_id' => $itemId], 409);
        }
        if ((int)$product['item_count'] < $qty) {
            $con->rollBack();
            jsonResponse([
                'status' => 'insufficient_stock',
                'item_id' => $itemId,
                'available' => (int)$product['item_count'],
                'requested' => $qty,
            ], 409);
        }
        $base = max(0.0, (float)$product['item_price']);
        $discount = min(100.0, max(0.0, (float)$product['item_discount']));
        $unit = $base * (1 - ($discount / 100));
        $subtotal += $unit * $qty;
    }
    $subtotal = round($subtotal, 2);

    $couponDiscount = 0;
    if ($couponId > 0) {
        $couponStmt = $con->prepare(
            'SELECT coupon_id,coupon_discount,coupon_count,coupon_expirydate FROM coupon WHERE coupon_id=? LIMIT 1 FOR UPDATE'
        );
        $couponStmt->execute([$couponId]);
        $coupon = $couponStmt->fetch(PDO::FETCH_ASSOC);
        if (!$coupon || (int)$coupon['coupon_count'] <= 0 || strtotime((string)$coupon['coupon_expirydate']) < time()) {
            $con->rollBack();
            jsonResponse(['status' => 'invalid_coupon'], 409);
        }
        $couponDiscount = (int)min(100, max(0, (int)$coupon['coupon_discount']));
    }

    // El descuento SIEMPRE resta; el código original lo sumaba.
    $discountAmount = round($subtotal * ($couponDiscount / 100), 2);
    $total = max(0.0, round($subtotal - $discountAmount + $deliveryFee, 2));

    // El esquema legacy almacena montos de pedido como INT. La edición Colombia
    // usa COP (sin centavos), por eso el valor persistido se redondea de forma explícita.
    $subtotalStored = (int)round($subtotal);
    $totalStored = (int)round($total);

    $orderStmt = $con->prepare(
        'INSERT INTO orders '
        . '(order_userid,order_addressid,order_type,order_price,order_pricedelivery,order_totalprice,order_paymenttype,order_coupon,order_status) '
        . 'VALUES (?,?,?,?,?,?,?,?,0)'
    );
    $orderStmt->execute([
        $userId,
        $addressId,
        $deliveryType,
        $subtotalStored,
        $deliveryFee,
        $totalStored,
        $paymentType,
        $couponId,
    ]);
    $orderId = (int)$con->lastInsertId();
    if ($orderId <= 0) throw new RuntimeException('No se obtuvo el ID del pedido.');

    $stockStmt = $con->prepare('UPDATE items SET item_count=item_count-? WHERE item_id=? AND item_count>=? AND item_active=1');
    foreach ($quantities as $itemId => $qty) {
        $stockStmt->execute([$qty, $itemId, $qty]);
        if ($stockStmt->rowCount() !== 1) throw new RuntimeException("Stock cambió durante checkout: $itemId");
    }

    $cartUpdate = $con->prepare('UPDATE cart SET cart_orderid=? WHERE cart_userid=? AND cart_orderid=0');
    $cartUpdate->execute([$orderId, $userId]);
    if ($cartUpdate->rowCount() !== count($rows)) throw new RuntimeException('El carrito cambió durante checkout.');

    if ($couponId > 0) {
        $couponUpdate = $con->prepare('UPDATE coupon SET coupon_count=coupon_count-1 WHERE coupon_id=? AND coupon_count>0');
        $couponUpdate->execute([$couponId]);
        if ($couponUpdate->rowCount() !== 1) throw new RuntimeException('El cupón dejó de estar disponible.');
    }

    $con->commit();

    // Notificar fuera de la transacción: una caída de FCM no debe revertir la compra.
    sendNotifications(
        2,
        'Nuevo pedido',
        "Se creó el pedido #$orderId y está pendiente de revisión.",
        (string)$orderId,
        'order',
        null,
        'orderplaced'
    );

    jsonResponse([
        'status' => 'success',
        'data' => [
            'order_id' => $orderId,
            'subtotal' => $subtotalStored,
            'coupon_discount_percent' => $couponDiscount,
            'discount_amount' => (int)round($discountAmount),
            'delivery_fee' => $deliveryFee,
            'total' => $totalStored,
            'currency' => $currency,
            'payment_type' => $paymentType,
        ],
    ], 201);
} catch (Throwable $e) {
    if ($con->inTransaction()) $con->rollBack();
    error_log('checkout failed: ' . $e->getMessage());
    jsonResponse(['status' => 'checkout_failed'], 500);
}
