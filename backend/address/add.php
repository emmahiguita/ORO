<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
requireRole($authUser,[0]);
$lat=filterRequest('lat'); $long=filterRequest('long');
if(!is_numeric($lat)||!is_numeric($long)||(float)$lat < -90||(float)$lat > 90||(float)$long < -180||(float)$long > 180){
    jsonResponse(['status'=>'invalid_coordinates'],422);
}
$data=[
 'address_userid'=>(int)$authUser['id'],
 'address_name'=>filterRequest('addressname'),
 'address_building'=>filterRequest('buildingname'),
 'address_apt'=>filterRequest('aptnumber'),
 'address_floor'=>filterRequest('floor'),
 'address_street'=>filterRequest('street'),
 'address_block'=>filterRequest('block'),
 'address_way'=>filterRequest('way'),
 'address_additional'=>filterRequest('additional'),
 'address_bymap'=>filterRequest('bymap'),
 'address_deliverytime'=>filterRequest('deliverytime'),
 'address_marker'=>filterRequest('marker'),
 'address_lat'=>(float)$lat,
 'address_long'=>(float)$long,
];
if($data['address_name']==='' || $data['address_bymap']==='') jsonResponse(['status'=>'invalid'],422);
$fields=array_keys($data); $stmt=$con->prepare('INSERT INTO address (`'.implode('`,`',$fields).'`) VALUES (:'.implode(',:',$fields).')');
foreach($data as $k=>$v)$stmt->bindValue(':'.$k,$v); $stmt->execute();
jsonResponse(['status'=>'success','data'=>['address_id'=>(int)$con->lastInsertId()]+$data],201);
