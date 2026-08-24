<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
requireRole($authUser,[0]);
$userId=(int)$authUser['id'];
$itemId=(int)filterRequest('itemid');
$stars=(float)filterRequest('stars');
$comment=trim(filterRequest('comment'));
if($itemId<=0 || $stars<1 || $stars>5) jsonResponse(['status'=>'invalid'],422);
if(function_exists('mb_substr')) $comment=mb_substr($comment,0,255); else $comment=substr($comment,0,255);
$eligible=$con->prepare('SELECT 1 FROM cart c JOIN orders o ON o.order_id=c.cart_orderid WHERE c.cart_userid=? AND c.cart_itemid=? AND o.order_status IN (3,5,6) LIMIT 1');
$eligible->execute([$userId,$itemId]);
if(!$eligible->fetchColumn()) jsonResponse(['status'=>'not_eligible'],403);
$exists=$con->prepare('SELECT 1 FROM rating WHERE rating_userid=? AND rating_itemid=? LIMIT 1');
$exists->execute([$userId,$itemId]);
if($exists->fetchColumn()) jsonResponse(['status'=>'already_rated'],409);
$stmt=$con->prepare('INSERT INTO rating (rating_userid,rating_itemid,rating_stars,rating_comment) VALUES (?,?,?,?)');
$stmt->execute([$userId,$itemId,$stars,$comment]);
jsonResponse(['status'=>'success','data'=>['rating_id'=>(int)$con->lastInsertId()]],201);
