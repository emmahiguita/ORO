<?php

declare(strict_types=1);

require_once __DIR__ . '/../../connect.php';

$title = filterRequest('title');
$body = filterRequest('body');

if ($title === '' && $body === '') {
    jsonResponse(['status' => 'failure', 'message' => 'Contenido requerido.'], 422);
}

$uploadDir = dirname(__DIR__, 2) . '/upload/home';
$imgname = imageUpload($uploadDir, 'files');

$data = [
    'mainpage_title' => $title,
    'mainpage_body' => $body,
];

if ($imgname !== 'empty' && $imgname !== 'fail') {
    $oldimg = filterRequest('oldimg');
    if ($oldimg !== '') {
        deleteFile($uploadDir, $oldimg);
    }
    $data['mainpage_image'] = $imgname;
}

// Verifica si existe registro 1; si no, inserta
$stmt = $con->query('SELECT COUNT(*) FROM mainpage WHERE mainpage_id = 1');
if ((int)$stmt->fetchColumn() === 0) {
    $data['mainpage_id'] = 1;
    insertData('mainpage', $data);
} else {
    updateData('mainpage', $data, 'mainpage_id = 1');
}
