<?php

declare(strict_types=1);

require_once __DIR__ . '/../../connect.php';

$id = (int)filterRequest('id');
if ($id <= 0) {
    jsonResponse(['status' => 'failure', 'message' => 'ID inválido.'], 422);
}

$category_name = filterRequest('nameen');
$category_name_ar = filterRequest('namear');
$category_name_es = filterRequest('namees');
if ($category_name === '' && $category_name_es === '') {
    jsonResponse(['status' => 'failure', 'message' => 'Nombre de categoría requerido.'], 422);
}
if ($category_name === '') $category_name = $category_name_es;
if ($category_name_es === '') $category_name_es = $category_name;
if ($category_name_ar === '') $category_name_ar = $category_name;

$uploadDir = dirname(__DIR__, 2) . '/upload/categories';
$imgname = imageUpload($uploadDir, 'files');

$data = [
    'category_name' => $category_name,
    'category_name_ar' => $category_name_ar,
    'category_name_es' => $category_name_es,
];

if ($imgname !== 'empty' && $imgname !== 'fail') {
    $oldimg = filterRequest('oldimg');
    if ($oldimg !== '') {
        deleteFile($uploadDir, $oldimg);
    }
    $data['category_img'] = $imgname;
}

updateData('categories', $data, "category_id = $id");
