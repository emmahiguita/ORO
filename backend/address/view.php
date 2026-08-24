<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
requireRole($authUser,[0,2]);
$userId=(int)$authUser['id'];
if((int)$authUser['role']===2 && filterRequest('userid')!=='') $userId=(int)filterRequest('userid');
$stmt=$con->prepare('SELECT * FROM address WHERE address_userid=? ORDER BY address_id DESC');
$stmt->execute([$userId]);
$data=$stmt->fetchAll(PDO::FETCH_ASSOC);
jsonResponse($data?['status'=>'success','data'=>$data]:['status'=>'failure','data'=>[]]);
