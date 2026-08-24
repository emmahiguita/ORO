<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
requireRole($authUser, [0]);
$userId = (int)$authUser['id'];
$itemId = (int)filterRequest('itemId');
if ($itemId <= 0) jsonResponse(['status'=>'failure'], 422);

try {
    $con->beginTransaction();
    $p = $con->prepare('SELECT item_count,item_active FROM items WHERE item_id=? LIMIT 1 FOR UPDATE');
    $p->execute([$itemId]);
    $item = $p->fetch(PDO::FETCH_ASSOC);
    if (!$item || (int)$item['item_active'] !== 1) {
        $con->rollBack();
        jsonResponse(['status'=>'product_unavailable'], 404);
    }
    $countStmt = $con->prepare('SELECT COUNT(*) FROM cart WHERE cart_userid=? AND cart_itemid=? AND cart_orderid=0');
    $countStmt->execute([$userId,$itemId]);
    $current = (int)$countStmt->fetchColumn();
    $stock = (int)$item['item_count'];
    if ($current >= $stock) {
        $con->rollBack();
        jsonResponse(['status'=>'insufficient_stock','available'=>$stock,'in_cart'=>$current], 409);
    }
    $ins = $con->prepare('INSERT INTO cart (cart_userid,cart_itemid,cart_orderid) VALUES (?,?,0)');
    $ins->execute([$userId,$itemId]);
    $con->commit();
    jsonResponse(['status'=>'success','count'=>$current+1], 201);
} catch (Throwable $e) {
    if ($con->inTransaction()) $con->rollBack();
    error_log('cart/add: '.$e->getMessage());
    jsonResponse(['status'=>'server_error'],500);
}
