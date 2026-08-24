<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
$userId=(int)$authUser['id'];
$stmt=$con->prepare('SELECT * FROM notification WHERE notification_userid=? ORDER BY notification_datetime DESC,notification_id DESC');
$stmt->execute([$userId]);
$data=$stmt->fetchAll(PDO::FETCH_ASSOC);
jsonResponse($data?['status'=>'success','data'=>$data]:['status'=>'failure','data'=>[]]);
