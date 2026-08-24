<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
requireRole($authUser, [0]);
$userId=(int)$authUser['id'];
$itemId=(int)filterRequest('itemId');
if($itemId<=0) jsonResponse(['status'=>'failure'],422);
$stmt=$con->prepare('SELECT cart_id FROM cart WHERE cart_userid=? AND cart_itemid=? AND cart_orderid=0 ORDER BY cart_id LIMIT 1');
$stmt->execute([$userId,$itemId]);
$cartId=(int)($stmt->fetchColumn() ?: 0);
if($cartId<=0) jsonResponse(['status'=>'failure'],404);
$del=$con->prepare('DELETE FROM cart WHERE cart_id=? AND cart_userid=? AND cart_orderid=0');
$del->execute([$cartId,$userId]);
jsonResponse(['status'=>$del->rowCount()===1?'success':'failure'], $del->rowCount()===1?200:409);
