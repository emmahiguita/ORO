<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
$userId=(int)$authUser['id'];
$notificationId=(int)filterRequest('notificationid');
if($notificationId<=0) jsonResponse(['status'=>'failure'],422);
$stmt=$con->prepare('UPDATE notification SET is_read=1 WHERE notification_userid=? AND notification_id=?');
$stmt->execute([$userId,$notificationId]);
// Idempotente: si ya estaba leída sigue siendo éxito siempre que exista.
$exists=$con->prepare('SELECT 1 FROM notification WHERE notification_userid=? AND notification_id=? LIMIT 1');
$exists->execute([$userId,$notificationId]);
$found=(bool)$exists->fetchColumn();
jsonResponse(['status'=>$found?'success':'failure'], $found?200:404);
