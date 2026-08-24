<?php
include __DIR__ . '/../connect.php';
requireRole($authUser,[0,2]);
$addressId=(int)filterRequest('addressid');
if($addressId<=0) jsonResponse(['status'=>'failure'],422);
if((int)$authUser['role']===2){$stmt=$con->prepare('DELETE FROM address WHERE address_id=?');$stmt->execute([$addressId]);}
else{$stmt=$con->prepare('DELETE FROM address WHERE address_id=? AND address_userid=?');$stmt->execute([$addressId,(int)$authUser['id']]);}
jsonResponse(['status'=>$stmt->rowCount()>0?'success':'failure'], $stmt->rowCount()>0?200:404);
