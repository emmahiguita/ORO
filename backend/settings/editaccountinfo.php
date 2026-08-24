<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';

$id = (int)filterRequest('id');
requireOwnerOrAdmin($authUser, $id);
if ($id <= 0) jsonResponse(['status' => 'failure'], 422);

$currentStmt = $con->prepare('SELECT * FROM user WHERE user_id = ? LIMIT 1');
$currentStmt->execute([$id]);
$current = $currentStmt->fetch(PDO::FETCH_ASSOC);
if (!$current) jsonResponse(['status' => 'not_found'], 404);

$username = filterRequest('username');
$email = strtolower(filterRequest('email'));
$phone = filterRequest('phonenumber');
$newPassword = (string)($_POST['password'] ?? '');
$currentPassword = (string)($_POST['currentpassword'] ?? '');
$oldpfp = basename(filterRequest('oldpfp'));
$oldbanner = basename(filterRequest('oldbanner'));
$data = [];
$errors = [];

if ($username !== '') {
    if (mb_strlen($username) > 100) $errors[] = 'invalidusername'; else $data['user_name'] = $username;
}
if ($email !== '') {
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) $errors[] = 'invalidemail'; else $data['user_email'] = $email;
}
if ($phone !== '') {
    if (mb_strlen($phone) > 100) $errors[] = 'invalidphone'; else $data['user_phone'] = $phone;
}

$emailChanged = isset($data['user_email']) && $data['user_email'] !== strtolower((string)$current['user_email']);
$passwordChanged = $newPassword !== '';
$sensitiveChange = $emailChanged || $passwordChanged;
if ($sensitiveChange) {
    if ($currentPassword === '' || !password_verify($currentPassword, (string)$current['user_password'])) {
        $errors[] = 'currentpasswordfail';
    }
}
if ($passwordChanged) {
    if (strlen($newPassword) < 10) $errors[] = 'weakpassword';
    else $data['user_password'] = password_hash($newPassword, PASSWORD_DEFAULT);
}

foreach ([['user_email',$email,'emailfail'],['user_name',$username,'userfail'],['user_phone',$phone,'phonefail']] as [$field,$value,$error]) {
    if (!array_key_exists($field, $data)) continue;
    $stmt = $con->prepare("SELECT 1 FROM user WHERE $field = ? AND user_id <> ? LIMIT 1");
    $stmt->execute([$value, $id]);
    if ($stmt->fetchColumn()) $errors[] = $error;
}

$newPfp = imageUpload(__DIR__ . '/../upload/pfp', 'pfp');
if ($newPfp === 'fail') $errors[] = 'pfpfail';
$newBanner = imageUpload(__DIR__ . '/../upload/banner', 'banner');
if ($newBanner === 'fail') $errors[] = 'bannerfail';
if ($newPfp !== 'empty' && $newPfp !== 'fail') $data['user_pfp'] = $newPfp;
if ($newBanner !== 'empty' && $newBanner !== 'fail') $data['user_banner'] = $newBanner;

if ($errors) {
    if ($newPfp !== 'empty' && $newPfp !== 'fail') deleteFile(__DIR__ . '/../upload/pfp', $newPfp);
    if ($newBanner !== 'empty' && $newBanner !== 'fail') deleteFile(__DIR__ . '/../upload/banner', $newBanner);
    jsonResponse(['status' => 'error', 'errors' => array_values(array_unique($errors))], 422);
}

$verificationCode = null;
$requiresVerification = false;
if ($emailChanged && (int)$current['user_keyaccess'] === 0) {
    $verificationCode = random_int(100000, 999999);
    $data['user_approve'] = 0;
    $data['user_verifycode'] = $verificationCode;
    $data['user_verify_expires_at'] = date('Y-m-d H:i:s', time() + 900);
    $data['user_verify_attempts'] = 0;
    $requiresVerification = true;
}
if ($sensitiveChange) {
    $data['user_token_version'] = (int)$current['user_token_version'] + 1;
}

if (!$data) jsonResponse(['status' => 'nochanges']);
$parts = [];
$values = [];
foreach ($data as $key => $value) {
    $parts[] = "`$key` = ?";
    $values[] = $value;
}
$values[] = $id;
$stmt = $con->prepare('UPDATE user SET ' . implode(', ', $parts) . ' WHERE user_id = ?');
$stmt->execute($values);

if ($newPfp !== 'empty' && $newPfp !== 'fail' && $oldpfp !== '' && $oldpfp !== 'default.png') deleteFile(__DIR__ . '/../upload/pfp', $oldpfp);
if ($newBanner !== 'empty' && $newBanner !== 'fail' && $oldbanner !== '' && $oldbanner !== 'default.png') deleteFile(__DIR__ . '/../upload/banner', $oldbanner);

$effective = [
    'user_name' => $data['user_name'] ?? $current['user_name'],
    'user_email' => $data['user_email'] ?? $current['user_email'],
    'user_phone' => $data['user_phone'] ?? $current['user_phone'],
    'user_pfp' => $data['user_pfp'] ?? $current['user_pfp'],
    'user_banner' => $data['user_banner'] ?? $current['user_banner'],
];
$response = ['status' => 'success', 'data' => $effective, 'requires_verification' => $requiresVerification];

if ($requiresVerification && $verificationCode !== null) {
    $sent = sendEmail($effective['user_email'], 'Verifica tu nuevo correo', "Tu código de verificación es: $verificationCode. Expira en 15 minutos.");
    $response['email_sent'] = $sent;
    if (!$sent && (($GLOBALS['APP_CONFIG']['app_env'] ?? 'development') !== 'production')) $response['dev_verify_code'] = $verificationCode;
} elseif ($sensitiveChange) {
    $response['token'] = issueAuthToken($id, (int)$current['user_keyaccess']);
}
jsonResponse($response);
