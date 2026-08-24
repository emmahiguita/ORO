<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
requireRole($authUser,[0]);
$itemId=(int)filterRequest('itemid');
if($itemId<=0) jsonResponse(['status'=>'failure'],422);
$stmt=$con->prepare('SELECT EXISTS(SELECT 1 FROM cart c JOIN orders o ON c.cart_orderid=o.order_id WHERE c.cart_userid=? AND c.cart_itemid=? AND o.order_status IN (3,5,6) AND NOT EXISTS(SELECT 1 FROM rating r WHERE r.rating_userid=c.cart_userid AND r.rating_itemid=c.cart_itemid))');
$stmt->execute([(int)$authUser['id'],$itemId]);
jsonResponse(['status'=>(int)$stmt->fetchColumn()===1?'success':'failure']);
