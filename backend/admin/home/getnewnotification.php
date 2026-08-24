<?php

include "../../connect.php";

$id = filterRequest("id");

$stmt = $con->prepare("SELECT COUNT(*) as unread_count FROM notification WHERE notification_userid = '$id' AND is_read = FALSE");
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count  = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "success", "data" => $data));
} else {
    echo json_encode(array("status" => "failure"));
}
