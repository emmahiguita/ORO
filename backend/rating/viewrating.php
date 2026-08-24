<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
$userId=(int)$authUser['id'];
if((int)$authUser['role']===2 && filterRequest('userId')!=='') $userId=(int)filterRequest('userId');
$stmt=$con->prepare('SELECT rating.*,itemsview.* FROM rating JOIN itemsview ON rating.rating_itemid=itemsview.item_id WHERE rating.rating_userid=? ORDER BY rating.rating_datetime DESC');
$stmt->execute([$userId]);
$data=$stmt->fetchAll(PDO::FETCH_ASSOC);
jsonResponse($data?['status'=>'success','data'=>$data]:['status'=>'failure','data'=>[]]);
