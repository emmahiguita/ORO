<?php
include "../connect.php";

$catid = filterRequest("id");
$userid = filterRequest("userid");


$stmt = $con->prepare("SELECT i.*, 
       CASE WHEN f.favourite_itemid IS NOT NULL THEN 1 ELSE 0 END AS favourite,
       (i.item_price - (i.item_price * i.item_discount / 100)) AS item_final_price
FROM itemsview i
LEFT JOIN favourites f ON f.favourite_itemid = i.item_id 
                      AND f.favourite_userid = '$userid'
WHERE i.category_id = '$catid'");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count  = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "success", "data" => $data));
} else {
    echo json_encode(array("status" => "failure"));
}
