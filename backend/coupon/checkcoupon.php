<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
$code=trim(filterRequest('coupon'));
if($code==='') jsonResponse(['status'=>'failure'],422);
$stmt=$con->prepare('SELECT coupon_id,coupon_code,coupon_count,coupon_discount,coupon_expirydate FROM coupon WHERE coupon_code=? AND coupon_expirydate>=NOW() AND coupon_count>0 LIMIT 1');
$stmt->execute([$code]);
$data=$stmt->fetch(PDO::FETCH_ASSOC);
jsonResponse($data?['status'=>'success','data'=>[$data]]:['status'=>'failure'], $data?200:404);
