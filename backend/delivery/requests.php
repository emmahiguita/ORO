<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
requireRole($authUser,[1,2]);
$stmt=$con->prepare('SELECT o.order_totalprice,o.order_datetime,o.order_paymenttype,o.order_id,o.order_userid,u.user_name,u.user_phone,a.address_name,a.address_building,a.address_apt,a.address_floor,a.address_street,a.address_block,a.address_way,a.address_additional,a.address_bymap,a.address_deliverytime,a.address_marker,a.address_lat,a.address_long FROM orders o JOIN user u ON o.order_userid=u.user_id JOIN address a ON a.address_id=o.order_addressid WHERE o.order_status=1.5 AND o.order_type=0 ORDER BY o.order_datetime ASC,o.order_id ASC');
$stmt->execute();
$data=$stmt->fetchAll(PDO::FETCH_ASSOC);
jsonResponse($data?['status'=>'success','data'=>$data]:['status'=>'failure','data'=>[]]);
