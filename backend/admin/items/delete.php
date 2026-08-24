<?php

declare(strict_types=1);

require_once __DIR__ . '/../../connect.php';

$id = (int)filterRequest('id');
if ($id <= 0) {
    jsonResponse(['status' => 'failure', 'message' => 'ID inválido.'], 422);
}

$imgname = filterRequest('imgname');
if ($imgname !== '') {
    $uploadDir = dirname(__DIR__, 2) . '/upload/items';
    deleteFile($uploadDir, $imgname);
}

deleteData('items', "item_id = $id");
