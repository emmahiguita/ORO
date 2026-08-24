<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
$email=strtolower(filterRequest('email'));
if(!filter_var($email,FILTER_VALIDATE_EMAIL))jsonResponse(['status'=>'failure'],422);
$stmt=$con->prepare('SELECT user_id,user_approve FROM user WHERE user_email=? LIMIT 1');$stmt->execute([$email]);$user=$stmt->fetch(PDO::FETCH_ASSOC);
if(!$user)jsonResponse(['status'=>'failure'],404);
if((int)$user['user_approve']===1)jsonResponse(['status'=>'already_verified']);
$code=random_int(100000,999999);$expires=date('Y-m-d H:i:s',time()+900);
$up=$con->prepare('UPDATE user SET user_verifycode=?,user_verify_expires_at=?,user_verify_attempts=0 WHERE user_id=?');$up->execute([$code,$expires,(int)$user['user_id']]);
$sent=sendEmail($email,'Código de verificación',"Tu código es: $code. Expira en 15 minutos.");
$response=['status'=>'success','email_sent'=>$sent];
if(!$sent && (($GLOBALS['APP_CONFIG']['app_env']??'development')!=='production'))$response['dev_verify_code']=$code;
jsonResponse($response);
