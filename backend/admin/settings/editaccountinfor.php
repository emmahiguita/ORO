<?php
include "../../connect.php";

$id = filterRequest("id");
$username = filterRequest("username");
$email = filterRequest("email");
$phoneNumber = filterRequest("phonenumber");
$password = filterRequest("password");
$oldpfp = filterRequest("oldpfp");
$oldbanner = filterRequest("oldbanner");

$data = array();
$errors = array();

// Prepare data for update
if (isset($username) && !empty($username)) {
    $data["user_name"] = $username;
}

if (isset($email) && !empty($email)) {
    $data["user_email"] = $email;
}

if (isset($phoneNumber) && !empty($phoneNumber)) {
    $data["user_phone"] = $phoneNumber;
}

if (isset($password) && !empty($password)) {
    $data["user_password"] = password_hash($password, PASSWORD_DEFAULT);
}

// Handle file uploads
$pfp = imageUpload("../../upload/pfp", "pfp");
if ($pfp != 'empty' && $pfp != "fail") {
    deleteFile("../../upload/pfp", $oldpfp);
    $data["user_pfp"] = $pfp;
} elseif ($pfp == "fail") {
    $errors[] = "Profile picture upload failed";
}

$banner = imageUpload("../../upload/banner", "banner");
if ($banner != 'empty' && $banner != "fail") {
    deleteFile("../../upload/banner", $oldbanner);
    $data["user_banner"] = $banner;
} elseif ($banner == "fail") {
    $errors[] = "Banner upload failed";
}

// Check for duplicates only if fields are being updated
if (isset($data["user_email"])) {
    $stmt = $con->prepare("SELECT user_id FROM user WHERE user_email = ? AND user_id != ?");
    $stmt->execute(array($email, $id));
    if ($stmt->rowCount() > 0) {
        $errors[] = "emailfail";
    }
}

if (isset($data["user_name"])) {
    $stmt = $con->prepare("SELECT user_id FROM user WHERE user_name = ? AND user_id != ?");
    $stmt->execute(array($username, $id));
    if ($stmt->rowCount() > 0) {
        $errors[] = "userfail";
    }
}

if (isset($data["user_phone"])) {
    $stmt = $con->prepare("SELECT user_id FROM user WHERE user_phone = ? AND user_id != ?");
    $stmt->execute(array($phoneNumber, $id));
    if ($stmt->rowCount() > 0) {
        $errors[] = "phonefail";
    }
}

// Process the update if no errors
if (empty($errors)) {
    if (!empty($data)) {
        $setClause = implode(' = ?, ', array_keys($data)) . ' = ?';
        $values = array_values($data);
        $values[] = $id;

        $stmt = $con->prepare("UPDATE user SET $setClause WHERE user_id = ?");
        if ($stmt->execute($values)) {
            echo json_encode(array("status" => "success", "data" => $data));
        } else {
            echo json_encode(array("status" => "dberror"));
        }
    } else {
        echo json_encode(array("status" => "nochanges"));
    }
} else {
    echo json_encode(array("status" => "error", "errors" => $errors));
}
