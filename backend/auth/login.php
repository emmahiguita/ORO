<?php
include __DIR__ . '/../connect.php';

$username = filterRequest('username');
$password = (string)($_POST['password'] ?? '');
if ($username === '' || $password === '') jsonResponse(['status'=>'failure'], 400);

$stmt = $con->prepare('SELECT * FROM user WHERE user_name = ? OR user_email = ? LIMIT 1');
$stmt->execute([$username, $username]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$user) jsonResponse(['status'=>'failure'], 401);

$stored = (string)$user['user_password'];
$valid = password_verify($password, $stored);
// LEGACY_SHA1_MIGRATION_ONLY: verifica una vez hashes antiguos y migra inmediatamente a password_hash().
$legacy = !$valid && strlen($stored) === 40 && hash_equals($stored, sha1($password));
if (!$valid && !$legacy) jsonResponse(['status'=>'failure'], 401);

if ($legacy || password_needs_rehash($stored, PASSWORD_DEFAULT)) {
    $newHash = password_hash($password, PASSWORD_DEFAULT);
    $up = $con->prepare('UPDATE user SET user_password = ? WHERE user_id = ?');
    $up->execute([$newHash, $user['user_id']]);
}

unset($user['user_password'], $user['user_verifycode'], $user['user_verify_expires_at'], $user['user_verify_attempts']);
if ((int)$user['user_keyaccess'] === 0 && (int)$user['user_approve'] !== 1) {
    jsonResponse(['status'=>'unverified','data'=>$user]);
}
$token = issueAuthToken((int)$user['user_id'], (int)$user['user_keyaccess']);
jsonResponse(['status'=>'success','data'=>$user,'token'=>$token]);
