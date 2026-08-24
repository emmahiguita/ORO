<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
$stmt=$con->prepare('SELECT COUNT(*) AS unread_count FROM notification WHERE notification_userid=? AND is_read=0');
$stmt->execute([(int)$authUser['id']]);
jsonResponse(['status'=>'success','data'=>[['unread_count'=>(int)$stmt->fetchColumn()]]]);
