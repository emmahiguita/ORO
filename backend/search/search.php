<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
$term=trim(filterRequest('searchitem'));
if($term==='') jsonResponse(['status'=>'failure','data'=>[]]);
$like='%'.$term.'%';
$stmt=$con->prepare('SELECT * FROM itemsview WHERE item_active=1 AND (item_name LIKE ? OR item_name_es LIKE ? OR item_name_ar LIKE ?) ORDER BY item_name LIMIT 100');
$stmt->execute([$like,$like,$like]);
$data=$stmt->fetchAll(PDO::FETCH_ASSOC);
jsonResponse($data?['status'=>'success','data'=>$data]:['status'=>'failure','data'=>[]]);
