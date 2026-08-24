<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
requireRole($authUser,[0]);
$stmt=$con->prepare('SELECT * FROM favourite WHERE favourite_userid=?');
$stmt->execute([(int)$authUser['id']]);
$data=$stmt->fetchAll(PDO::FETCH_ASSOC);
jsonResponse($data?['status'=>'success','data'=>$data]:['status'=>'failure','data'=>[]]);
