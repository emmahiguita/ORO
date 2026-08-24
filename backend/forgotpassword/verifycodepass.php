<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
$email=strtolower(filterRequest('email'));$verify=filterRequest('veridycode');
if(!filter_var($email,FILTER_VALIDATE_EMAIL)||!preg_match('/^[0-9]{6}$/',$verify))jsonResponse(['status'=>'failure'],422);
$stmt=$con->prepare('SELECT 1 FROM user WHERE user_email=? AND user_verifycode=? AND user_verify_expires_at>=NOW() AND user_verify_attempts<5 LIMIT 1');$stmt->execute([$email,$verify]);
$ok=(bool)$stmt->fetchColumn();
if(!$ok){$up=$con->prepare('UPDATE user SET user_verify_attempts=LEAST(user_verify_attempts+1,5) WHERE user_email=?');$up->execute([$email]);}
jsonResponse(['status'=>$ok?'success':'failure'],$ok?200:400);
