<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
requireRole($authUser,[0,2]);
$userId=(int)$authUser['id'];
if((int)$authUser['role']===2 && filterRequest('userID')!=='') $userId=(int)filterRequest('userID');
$stmt=$con->prepare('SELECT * FROM orders WHERE order_userid=? AND order_status<>6 ORDER BY order_datetime DESC,order_id DESC');
$stmt->execute([$userId]);
$data=$stmt->fetchAll(PDO::FETCH_ASSOC);
jsonResponse($data?['status'=>'success','data'=>$data]:['status'=>'failure','data'=>[]]);
