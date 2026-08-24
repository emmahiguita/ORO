<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
$username = trim(filterRequest('username'));
$email = strtolower(filterRequest('email'));
$phonenumber = trim(filterRequest('phonenumber'));
$password = (string)($_POST['password'] ?? '');
if ($username === '' || strlen($username) > 100 || !filter_var($email,FILTER_VALIDATE_EMAIL) || $phonenumber === '' || strlen($password) < 8) {
    jsonResponse(['status'=>'invalid'],422);
}
$checks=[['user_email',$email,'emailfail'],['user_name',$username,'userfail'],['user_phone',$phonenumber,'phonefail']];
foreach($checks as [$field,$value,$status]){
    $stmt=$con->prepare("SELECT 1 FROM user WHERE $field=? LIMIT 1");$stmt->execute([$value]);
    if($stmt->fetchColumn())jsonResponse(['status'=>$status],409);
}
$id=generateUniqueUserId();
$verifycode=random_int(100000,999999);
$expires=date('Y-m-d H:i:s',time()+900);
$stmt=$con->prepare('INSERT INTO user (user_id,user_name,user_email,user_phone,user_password,user_verifycode,user_verify_expires_at,user_verify_attempts,user_pfp,user_banner,user_approve,user_keyaccess) VALUES (?,?,?,?,?,?,?,?,?,?,0,0)');
$stmt->execute([$id,$username,$email,$phonenumber,password_hash($password,PASSWORD_DEFAULT),$verifycode,$expires,0,'default.png','default.png']);
$sent=sendEmail($email,'Verifica tu cuenta',"Tu código de verificación es: $verifycode. Expira en 15 minutos.");
$data=['user_id'=>$id,'user_name'=>$username,'user_email'=>$email,'user_phone'=>$phonenumber,'user_pfp'=>'default.png','user_banner'=>'default.png','user_approve'=>0,'user_keyaccess'=>0];
$out=['status'=>'success','data'=>$data,'email_sent'=>$sent];
if(!$sent && (($GLOBALS['APP_CONFIG']['app_env']??'development')!=='production'))$out['dev_verify_code']=$verifycode;
jsonResponse($out,201);
