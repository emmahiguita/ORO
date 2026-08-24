<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
$userId=(int)$authUser['id'];
$notificationId=(int)filterRequest('notificationID');
if($notificationId<=0) $notificationId=(int)filterRequest('notificationid');
if($notificationId<=0) jsonResponse(['status'=>'failure'],422);
$stmt=$con->prepare('DELETE FROM notification WHERE notification_userid=? AND notification_id=?');
$stmt->execute([$userId,$notificationId]);
jsonResponse(['status'=>$stmt->rowCount()===1?'success':'failure'], $stmt->rowCount()===1?200:404);
