<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
requireRole($authUser,[1,2]);
$orderId=(int)filterRequest('orderid');
if($orderId<=0)jsonResponse(['status'=>'failure'],422);
if((int)$authUser['role']!==2){
    $access=$con->prepare('SELECT 1 FROM orders o LEFT JOIN delivery d ON d.delivery_orderid=o.order_id WHERE o.order_id=? AND (o.order_status=1.5 OR d.delivery_workerid=?) LIMIT 1');
    $access->execute([$orderId,(int)$authUser['id']]);
    if(!$access->fetchColumn())jsonResponse(['status'=>'forbidden'],403);
}
$stmt=$con->prepare('SELECT i.* FROM items i JOIN cart c ON c.cart_itemid=i.item_id WHERE c.cart_orderid=? ORDER BY c.cart_id');
$stmt->execute([$orderId]);
$data=$stmt->fetchAll(PDO::FETCH_ASSOC);
jsonResponse($data?['status'=>'success','data'=>$data]:['status'=>'failure','data'=>[]]);
