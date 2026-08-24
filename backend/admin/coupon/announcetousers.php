<?php

declare(strict_types=1);

require_once __DIR__ . '/../../connect.php';

$title = filterRequest('title');
$body = filterRequest('body');

if ($title === '' || $body === '') {
    jsonResponse(['status' => 'failure', 'message' => 'Título y cuerpo requeridos.'], 422);
}

$uploadDir = dirname(__DIR__, 2) . '/upload/notification';
$imgname = imageUpload($uploadDir, 'files');
$imageUrl = ($imgname !== 'empty' && $imgname !== 'fail') ? $imgname : null;

$success = sendNotifications(
    0, // Usuarios regulares
    $title,
    $body,
    '',
    '',
    $imageUrl,
    'coupon',
    'default',
    '#C6A15B',
    '/home',
    0,
    'high',
    false
);

jsonResponse(['status' => $success ? 'success' : 'failure']);
