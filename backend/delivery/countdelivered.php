<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
requireRole($authUser,[1,2]);
$workerId=(int)$authUser['id'];
if((int)$authUser['role']===2 && filterRequest('id')!=='')$workerId=(int)filterRequest('id');
$stmt=$con->prepare('SELECT COUNT(o.order_id) AS count_total FROM orders o JOIN delivery d ON o.order_id=d.delivery_orderid WHERE o.order_status>=3 AND d.delivery_workerid=?');
$stmt->execute([$workerId]);
jsonResponse(['status'=>'success','data'=>[['count_total'=>(int)$stmt->fetchColumn()]]]);
