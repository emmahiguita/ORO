<?php

declare(strict_types=1);
include __DIR__ . '/../connect.php';
$itemId=(int)filterRequest('itemid');
if($itemId<=0) jsonResponse(['status'=>'failure'],422);
$stmt=$con->prepare('SELECT rating.rating_id,rating.rating_stars,rating.rating_comment,rating.rating_datetime,user.user_id,user.user_name,user.user_pfp FROM rating JOIN user ON user.user_id=rating.rating_userid WHERE rating.rating_itemid=? ORDER BY rating.rating_datetime DESC');
$stmt->execute([$itemId]);
$data=$stmt->fetchAll(PDO::FETCH_ASSOC);
jsonResponse($data?['status'=>'success','data'=>$data]:['status'=>'failure','data'=>[]]);
