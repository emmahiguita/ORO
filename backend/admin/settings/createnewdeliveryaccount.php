<?php
include __DIR__ . '/../../connect.php';

$username = filterRequest('username');
$email = strtolower(filterRequest('email'));
$phone = filterRequest('phonenumber');
$password = (string)($_POST['password'] ?? '');
if ($username === '' || !filter_var($email, FILTER_VALIDATE_EMAIL) || $phone === '' || strlen($password) < 10) {
    jsonResponse(['status'=>'invalid'], 422);
}
foreach ([['user_email',$email,'emailfail'],['user_name',$username,'userfail'],['user_phone',$phone,'phonefail']] as [$field,$value,$status]) {
    $stmt=$con->prepare("SELECT 1 FROM user WHERE $field=? LIMIT 1"); $stmt->execute([$value]);
    if ($stmt->fetchColumn()) jsonResponse(['status'=>$status],409);
}
$id=generateUniqueUserId();
$stmt=$con->prepare('INSERT INTO user (user_id,user_name,user_email,user_phone,user_password,user_verifycode,user_approve,user_keyaccess,user_pfp,user_banner) VALUES (?,?,?,?,?,?,?,?,?,?)');
$stmt->execute([$id,$username,$email,$phone,password_hash($password,PASSWORD_DEFAULT),random_int(100000,999999),1,1,'default.png','default.png']);
jsonResponse(['status'=>'success','data'=>['user_id'=>$id,'user_name'=>$username,'user_email'=>$email,'user_phone'=>$phone,'user_approve'=>1,'user_keyaccess'=>1]],201);
