<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
requireRole($authUser,[0]);
$userId=(int)$authUser['id'];
$itemId=(int)filterRequest('itemId');
if($itemId<=0) jsonResponse(['status'=>'failure'],422);
$item=$con->prepare('SELECT 1 FROM items WHERE item_id=? AND item_active=1 LIMIT 1');
$item->execute([$itemId]);
if(!$item->fetchColumn()) jsonResponse(['status'=>'product_unavailable'],404);
$exists=$con->prepare('SELECT 1 FROM favourites WHERE favourite_userid=? AND favourite_itemid=? LIMIT 1');
$exists->execute([$userId,$itemId]);
if($exists->fetchColumn()) jsonResponse(['status'=>'success','already_exists'=>true]);
$stmt=$con->prepare('INSERT INTO favourites (favourite_userid,favourite_itemid) VALUES (?,?)');
$stmt->execute([$userId,$itemId]);
jsonResponse(['status'=>'success'],201);
