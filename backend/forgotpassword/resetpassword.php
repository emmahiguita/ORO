<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
$email=strtolower(filterRequest('email'));$verify=filterRequest('veridycode');$password=(string)($_POST['password']??'');
if(!filter_var($email,FILTER_VALIDATE_EMAIL)||!preg_match('/^[0-9]{6}$/',$verify)||strlen($password)<8)jsonResponse(['status'=>'failure'],422);
$stmt=$con->prepare('UPDATE user SET user_password=?,user_verifycode=0,user_verify_expires_at=NULL,user_verify_attempts=0,user_token_version=user_token_version+1 WHERE user_email=? AND user_verifycode=? AND user_verify_expires_at>=NOW() AND user_verify_attempts<5');
$stmt->execute([password_hash($password,PASSWORD_DEFAULT),$email,$verify]);
if($stmt->rowCount()!==1)jsonResponse(['status'=>'failure'],400);
jsonResponse(['status'=>'success']);
