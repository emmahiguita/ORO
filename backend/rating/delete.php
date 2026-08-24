<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
requireRole($authUser,[0,2]);
$rateId=(int)filterRequest('rateid');
if($rateId<=0) jsonResponse(['status'=>'failure'],422);
if((int)$authUser['role']===2){$stmt=$con->prepare('DELETE FROM rating WHERE rating_id=?');$stmt->execute([$rateId]);}
else{$stmt=$con->prepare('DELETE FROM rating WHERE rating_id=? AND rating_userid=?');$stmt->execute([$rateId,(int)$authUser['id']]);}
jsonResponse(['status'=>$stmt->rowCount()===1?'success':'failure'], $stmt->rowCount()===1?200:404);
