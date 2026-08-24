<?php

declare(strict_types=1);

/**
 * Cancela un pedido pendiente y devuelve al inventario las unidades reservadas
 * en el checkout. La operación completa es atómica.
 */
function cancelPendingOrder(PDO $con, int $orderId, ?int $ownerId = null): array
{
    $con->beginTransaction();
    try {
        $sql = 'SELECT order_id,order_userid,order_coupon,order_status FROM orders WHERE order_id=?';
        $params = [$orderId];
        if ($ownerId !== null) {
            $sql .= ' AND order_userid=?';
            $params[] = $ownerId;
        }
        $sql .= ' FOR UPDATE';
        $stmt = $con->prepare($sql);
        $stmt->execute($params);
        $order = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$order) {
            $con->rollBack();
            return ['ok' => false, 'status' => 404, 'code' => 'not_found'];
        }
        if ((float)$order['order_status'] !== 0.0) {
            $con->rollBack();
            return ['ok' => false, 'status' => 409, 'code' => 'invalid_status'];
        }

        $items = $con->prepare('SELECT cart_itemid FROM cart WHERE cart_orderid=? FOR UPDATE');
        $items->execute([$orderId]);
        $quantities = [];
        foreach ($items->fetchAll(PDO::FETCH_COLUMN) as $itemId) {
            $id = (int)$itemId;
            $quantities[$id] = ($quantities[$id] ?? 0) + 1;
        }
        $restore = $con->prepare('UPDATE items SET item_count=item_count+? WHERE item_id=?');
        foreach ($quantities as $itemId => $qty) $restore->execute([$qty, $itemId]);

        $couponId = (int)($order['order_coupon'] ?? 0);
        if ($couponId > 0) {
            $coupon = $con->prepare('UPDATE coupon SET coupon_count=coupon_count+1 WHERE coupon_id=?');
            $coupon->execute([$couponId]);
        }

        $up = $con->prepare('UPDATE orders SET order_status=-1 WHERE order_id=? AND order_status=0');
        $up->execute([$orderId]);
        if ($up->rowCount() !== 1) throw new RuntimeException('No se pudo cancelar el pedido.');

        $con->commit();
        return ['ok' => true, 'user_id' => (int)$order['order_userid']];
    } catch (Throwable $e) {
        if ($con->inTransaction()) $con->rollBack();
        error_log('cancelPendingOrder: ' . $e->getMessage());
        return ['ok' => false, 'status' => 500, 'code' => 'server_error'];
    }
}


/** Cambia el estado de un pedido comprobando el estado anterior dentro de una transacción. */
function transitionOrderStatus(PDO $con, int $orderId, array $allowedFrom, float|int $to, ?int $requiredType = null): array
{
    $con->beginTransaction();
    try {
        $stmt = $con->prepare('SELECT order_id,order_userid,order_type,order_status FROM orders WHERE order_id=? LIMIT 1 FOR UPDATE');
        $stmt->execute([$orderId]);
        $order = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$order) {
            $con->rollBack();
            return ['ok'=>false,'status'=>404,'code'=>'not_found'];
        }
        $current = (float)$order['order_status'];
        $allowed = array_map('floatval', $allowedFrom);
        if (!in_array($current, $allowed, true)) {
            $con->rollBack();
            return ['ok'=>false,'status'=>409,'code'=>'invalid_status'];
        }
        if ($requiredType !== null && (int)$order['order_type'] !== $requiredType) {
            $con->rollBack();
            return ['ok'=>false,'status'=>409,'code'=>'invalid_order_type'];
        }
        $up = $con->prepare('UPDATE orders SET order_status=? WHERE order_id=? AND order_status=?');
        $up->execute([$to,$orderId,$current]);
        if ($up->rowCount() !== 1) throw new RuntimeException('La transición perdió una carrera concurrente.');
        $con->commit();
        return [
            'ok'=>true,
            'user_id'=>(int)$order['order_userid'],
            'order_type'=>(int)$order['order_type'],
            'from'=>$current,
            'to'=>(float)$to,
        ];
    } catch (Throwable $e) {
        if ($con->inTransaction()) $con->rollBack();
        error_log('transitionOrderStatus: '.$e->getMessage());
        return ['ok'=>false,'status'=>500,'code'=>'server_error'];
    }
}
