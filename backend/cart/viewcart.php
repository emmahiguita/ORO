<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
requireRole($authUser, [0]);
$userId=(int)$authUser['id'];
$stmt=$con->prepare('SELECT * FROM cartview WHERE cart_userid=?');
$stmt->execute([$userId]);
$data=$stmt->fetchAll(PDO::FETCH_ASSOC);
if(!$data) jsonResponse(['status'=>'failure','datacart'=>[],'totalCountAndPrice'=>['carttotal'=>0,'itemstotal'=>0]]);
$total=$con->prepare('SELECT COALESCE(SUM(totalprice),0) AS carttotal, COALESCE(SUM(countitems),0) AS itemstotal FROM cartview WHERE cart_userid=?');
$total->execute([$userId]);
jsonResponse(['status'=>'success','datacart'=>$data,'totalCountAndPrice'=>$total->fetch(PDO::FETCH_ASSOC)]);
