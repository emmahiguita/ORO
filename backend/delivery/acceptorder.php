<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
requireRole($authUser,[1]);
$orderId=(int)filterRequest('orderid');
$workerId=(int)$authUser['id'];
if($orderId<=0) jsonResponse(['status'=>'failure'],422);
try{
    $con->beginTransaction();
    $stmt=$con->prepare('SELECT order_userid,order_status,order_type FROM orders WHERE order_id=? LIMIT 1 FOR UPDATE');
    $stmt->execute([$orderId]);
    $order=$stmt->fetch(PDO::FETCH_ASSOC);
    if(!$order || (float)$order['order_status']!==1.5 || (int)$order['order_type']!==0){
        $con->rollBack(); jsonResponse(['status'=>'not_available'],409);
    }
    $assigned=$con->prepare('SELECT 1 FROM delivery WHERE delivery_orderid=? LIMIT 1 FOR UPDATE');
    $assigned->execute([$orderId]);
    if($assigned->fetchColumn()) { $con->rollBack(); jsonResponse(['status'=>'already_assigned'],409); }
    $up=$con->prepare('UPDATE orders SET order_status=2 WHERE order_id=? AND order_status=1.5 AND order_type=0');
    $up->execute([$orderId]);
    if($up->rowCount()!==1) throw new RuntimeException('Pedido tomado por otro repartidor.');
    $ins=$con->prepare('INSERT INTO delivery (delivery_workerid,delivery_orderid) VALUES (?,?)');
    $ins->execute([$workerId,$orderId]);
    $con->commit();
    sendToNotification('Tu pedido va en camino',"El pedido #$orderId fue asignado a un repartidor y está en ruta.",(int)$order['order_userid'],(string)$orderId,'order',null,'delivery');
    jsonResponse(['status'=>'success']);
}catch(Throwable $e){
    if($con->inTransaction())$con->rollBack();
    error_log('delivery/accept: '.$e->getMessage());
    jsonResponse(['status'=>'not_available'],409);
}
