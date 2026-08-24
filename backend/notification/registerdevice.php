<?php
include __DIR__ . '/../connect.php';
requireRole($authUser, [0, 1, 2]);
$token = trim((string)($_POST['token'] ?? ''));
$platform = strtolower(filterRequest('platform'));
if ($token === '' || strlen($token) > 4096 || !in_array($platform, ['android','ios','web','macos','windows','linux','fuchsia'], true)) {
    jsonResponse(['status' => 'failure'], 422);
}
$tokenHash = hash('sha256', $token);
$stmt = $con->prepare(
    'INSERT INTO device_tokens (user_id, token_hash, token, platform, updated_at) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP) '
    . 'ON DUPLICATE KEY UPDATE user_id=VALUES(user_id), token=VALUES(token), platform=VALUES(platform), updated_at=CURRENT_TIMESTAMP'
);
$stmt->execute([(int)$authUser['id'], $tokenHash, $token, $platform]);
jsonResponse(['status' => 'success']);
