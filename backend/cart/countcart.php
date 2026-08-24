<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
requireRole($authUser,[0]);
$userId=(int)$authUser['id'];
$itemId=(int)filterRequest('itemId');
if($itemId<=0) jsonResponse(['status'=>'failure'],422);
$stmt=$con->prepare('SELECT COUNT(*) FROM cart WHERE cart_userid=? AND cart_itemid=? AND cart_orderid=0');
$stmt->execute([$userId,$itemId]);
jsonResponse(['status'=>'success','data'=>(string)(int)$stmt->fetchColumn()]);
