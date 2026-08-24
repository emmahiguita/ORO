<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
requireRole($authUser,[1]);
$orderId=(int)filterRequest('orderid');
$workerId=(int)$authUser['id'];
if($orderId<=0) jsonResponse(['status'=>'failure'],422);
try{
    $con->beginTransaction();
    $stmt=$con->prepare('SELECT o.order_userid,o.order_status FROM orders o JOIN delivery d ON d.delivery_orderid=o.order_id WHERE o.order_id=? AND d.delivery_workerid=? LIMIT 1 FOR UPDATE');
    $stmt->execute([$orderId,$workerId]);
    $order=$stmt->fetch(PDO::FETCH_ASSOC);
    if(!$order || (float)$order['order_status']!==2.0){$con->rollBack();jsonResponse(['status'=>'invalid_status'],409);}
    $up=$con->prepare('UPDATE orders SET order_status=3 WHERE order_id=? AND order_status=2');
    $up->execute([$orderId]);
    if($up->rowCount()!==1) throw new RuntimeException('No se pudo completar la entrega.');
    $con->commit();
    sendToNotification('Pedido entregado',"El pedido #$orderId fue marcado como entregado.",(int)$order['order_userid'],(string)$orderId,'order',null,'donedelivery');
    jsonResponse(['status'=>'success']);
}catch(Throwable $e){
    if($con->inTransaction())$con->rollBack();
    error_log('delivery/delivered: '.$e->getMessage());
    jsonResponse(['status'=>'server_error'],500);
}
