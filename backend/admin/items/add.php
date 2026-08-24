<?php

declare(strict_types=1);

require_once __DIR__ . '/../../connect.php';

$name = filterRequest('name');
$name_ar = filterRequest('namear');
$name_es = filterRequest('namees');
$description = filterRequest('desc');
$description_ar = filterRequest('descar');
$description_es = filterRequest('desces');
$count = (int)filterRequest('count');
$active = (int)filterRequest('active');
$price = (float)filterRequest('price');
$discount = (float)filterRequest('discount');
$catgoryid = (int)filterRequest('catid');

if ($name === '' && $name_es === '') {
    jsonResponse(['status' => 'failure', 'message' => 'Nombre de producto requerido.'], 422);
}
if ($name === '') $name = $name_es;
if ($name_es === '') $name_es = $name;
if ($name_ar === '') $name_ar = $name;

if ($description === '' && $description_es === '') {
    $description = $name;
    $description_es = $name_es;
}
if ($description === '') $description = $description_es;
if ($description_es === '') $description_es = $description;
if ($description_ar === '') $description_ar = $description;

if ($price < 0 || $discount < 0 || $discount > 100 || $catgoryid <= 0) {
    jsonResponse(['status' => 'failure', 'message' => 'Valores de producto inválidos.'], 422);
}

$uploadDir = dirname(__DIR__, 2) . '/upload/items';
$imgname = imageUpload($uploadDir, 'files');

$data = [
    'item_name' => $name,
    'item_name_ar' => $name_ar,
    'item_name_es' => $name_es,
    'item_desc' => $description,
    'item_desc_ar' => $description_ar,
    'item_desc_es' => $description_es,
    'item_img' => $imgname !== 'fail' ? $imgname : 'empty',
    'item_count' => max(0, $count),
    'item_active' => $active === 0 ? 0 : 1,
    'item_price' => $price,
    'item_discount' => $discount,
    'item_cat' => $catgoryid,
];

insertData('items', $data);
