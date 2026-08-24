<?php

declare(strict_types=1);
include __DIR__ . '/../../connect.php';
require_once __DIR__ . '/../../order_service.php';
$orderId=(int)filterRequest('orderid');
if($orderId<=0) jsonResponse(['status'=>'failure'],422);
$result=transitionOrderStatus($con,$orderId,[0],1,null);
if(!$result['ok']) jsonResponse(['status'=>$result['code']],(int)$result['status']);
sendToNotification('Pedido aceptado', 'Tu pedido fue aceptado y está siendo preparado.', (int)$result['user_id'], (string)$orderId, 'order', null, 'approve');
jsonResponse(['status'=>'success']);
