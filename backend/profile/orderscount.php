<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
$userId=(int)$authUser['id'];
if((int)$authUser['role']===2 && filterRequest('id')!=='') $userId=(int)filterRequest('id');
$stmt=$con->prepare('SELECT COUNT(order_id) AS orders_count FROM orders WHERE order_userid=?');
$stmt->execute([$userId]);
jsonResponse(['status'=>'success','data'=>[['orders_count'=>(int)$stmt->fetchColumn()]]]);
