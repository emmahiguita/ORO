<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
$email=strtolower(filterRequest('email'));$verify=filterRequest('veridycode');
if(!filter_var($email,FILTER_VALIDATE_EMAIL)||!preg_match('/^[0-9]{6}$/',$verify))jsonResponse(['status'=>'failure'],422);
$stmt=$con->prepare('SELECT user_id,user_email,user_name,user_pfp,user_banner,user_phone,user_approve,user_keyaccess,user_verify_attempts FROM user WHERE user_email=? AND user_verifycode=? AND user_verify_expires_at>=NOW() AND user_verify_attempts<5 LIMIT 1');
$stmt->execute([$email,$verify]);$user=$stmt->fetch(PDO::FETCH_ASSOC);
if(!$user){$up=$con->prepare('UPDATE user SET user_verify_attempts=LEAST(user_verify_attempts+1,5) WHERE user_email=?');$up->execute([$email]);jsonResponse(['status'=>'failure','message'=>'Código incorrecto o vencido.'],400);}
$up=$con->prepare('UPDATE user SET user_approve=1,user_verifycode=0,user_verify_expires_at=NULL,user_verify_attempts=0 WHERE user_id=?');$up->execute([(int)$user['user_id']]);
$user['user_approve']=1;unset($user['user_verify_attempts']);
$token=issueAuthToken((int)$user['user_id'],(int)$user['user_keyaccess']);
jsonResponse(['status'=>'success','data'=>$user,'token'=>$token]);
