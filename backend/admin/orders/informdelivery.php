<?php

declare(strict_types=1);
include __DIR__ . '/../../connect.php';
require_once __DIR__ . '/../../order_service.php';
$orderId=(int)filterRequest('orderid');
if($orderId<=0) jsonResponse(['status'=>'failure'],422);
$result=transitionOrderStatus($con,$orderId,[1],1.5,0);
if(!$result['ok']) jsonResponse(['status'=>$result['code']],(int)$result['status']);

sendNotifications(
    1,
    'Nueva entrega disponible',
    "El pedido #$orderId está listo para entrega.",
    (string)$orderId,
    'delivery',
    null,
    'awaitingdelivery'
);
jsonResponse(['status'=>'success']);
