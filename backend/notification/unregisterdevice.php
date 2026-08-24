<?php
include __DIR__ . '/../connect.php';
requireRole($authUser, [0, 1, 2]);
$token = trim((string)($_POST['token'] ?? ''));
if ($token === '' || strlen($token) > 4096) jsonResponse(['status' => 'failure'], 422);
$stmt = $con->prepare('DELETE FROM device_tokens WHERE user_id = ? AND token_hash = ?');
$stmt->execute([(int)$authUser['id'], hash('sha256', $token)]);
jsonResponse(['status' => 'success']);
