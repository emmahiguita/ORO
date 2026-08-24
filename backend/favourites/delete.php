<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
requireRole($authUser,[0]);
$userId=(int)$authUser['id'];
$itemId=(int)filterRequest('itemId');
if($itemId<=0) jsonResponse(['status'=>'failure'],422);
$stmt=$con->prepare('DELETE FROM favourites WHERE favourite_userid=? AND favourite_itemid=?');
$stmt->execute([$userId,$itemId]);
jsonResponse(['status'=>'success']);
