<?php
include __DIR__ . '/../connect.php';
requireRole($authUser, [0, 2]);

$addressId = (int)filterRequest('addressid');
$latRaw = filterRequest('lat');
$longRaw = filterRequest('long');
if ($addressId <= 0 || !is_numeric($latRaw) || !is_numeric($longRaw)) {
    jsonResponse(['status' => 'failure', 'message' => 'Dirección o coordenadas inválidas.'], 422);
}
$lat = (float)$latRaw;
$long = (float)$longRaw;
if ($lat < -90 || $lat > 90 || $long < -180 || $long > 180) {
    jsonResponse(['status' => 'failure', 'message' => 'Coordenadas fuera de rango.'], 422);
}

$data = [
    'address_name' => filterRequest('addressname'),
    'address_building' => filterRequest('buildingname'),
    'address_apt' => filterRequest('aptnumber'),
    'address_floor' => filterRequest('floor'),
    'address_street' => filterRequest('street'),
    'address_block' => filterRequest('block'),
    'address_way' => filterRequest('way'),
    'address_additional' => filterRequest('additional'),
    'address_bymap' => filterRequest('bymap'),
    'address_deliverytime' => filterRequest('deliverytime'),
    'address_marker' => filterRequest('marker'),
    'address_lat' => $lat,
    'address_long' => $long,
];
$sets = [];
$values = [];
foreach ($data as $key => $value) {
    $sets[] = "`$key` = ?";
    $values[] = $value;
}
$sql = 'UPDATE address SET ' . implode(', ', $sets) . ' WHERE address_id = ?';
$values[] = $addressId;
if ((int)$authUser['role'] !== 2) {
    $sql .= ' AND address_userid = ?';
    $values[] = (int)$authUser['id'];
}
$stmt = $con->prepare($sql);
$stmt->execute($values);
if ($stmt->rowCount() === 0) {
    $exists = $con->prepare('SELECT 1 FROM address WHERE address_id = ?' . ((int)$authUser['role'] === 2 ? '' : ' AND address_userid = ?'));
    $exists->execute((int)$authUser['role'] === 2 ? [$addressId] : [$addressId, (int)$authUser['id']]);
    if (!$exists->fetchColumn()) jsonResponse(['status' => 'not_found'], 404);
}
jsonResponse(['status' => 'success']);
