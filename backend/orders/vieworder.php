<?php
include __DIR__ . '/../connect.php';
requireRole($authUser,[0,2]);
$orderId=(int)filterRequest('orderID');
$userId=(int)$authUser['id'];
if((int)$authUser['role']===2 && filterRequest('userID')!=='') $userId=(int)filterRequest('userID');
$stmt=$con->prepare('SELECT * FROM ordersview WHERE order_userid=? AND cart_orderid=?');
$stmt->execute([$userId,$orderId]);
$data=$stmt->fetchAll(PDO::FETCH_ASSOC);
jsonResponse($data?['status'=>'success','data'=>$data]:['status'=>'failure'], $data?200:404);
