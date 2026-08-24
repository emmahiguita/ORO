<?php

declare(strict_types=1);
include __DIR__ . '/../../connect.php';
require_once __DIR__ . '/../../order_service.php';
$orderId=(int)filterRequest('orderid');
if($orderId<=0) jsonResponse(['status'=>'failure'],422);
$result=transitionOrderStatus($con,$orderId,[1],4,1);
if(!$result['ok']) jsonResponse(['status'=>$result['code']],(int)$result['status']);
sendToNotification('Pedido listo para recoger', 'Tu pedido está preparado y listo para recogida.', (int)$result['user_id'], (string)$orderId, 'order', null, 'pickup');
jsonResponse(['status'=>'success']);
