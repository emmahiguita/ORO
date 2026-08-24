<?php

declare(strict_types=1);

define('MB', 1048576);

function filterRequest(string $requestname): string
{
    $value = $_POST[$requestname] ?? '';
    if (is_array($value)) return '';
    $clean = trim(strip_tags((string)$value));
    if (preg_match('/(^id$|id$|userid|user_id)/i', $requestname) && $clean !== '' && !preg_match('/^-?[0-9]+$/', $clean)) {
        return '';
    }
    return $clean;
}

function getAllData($table, $where = null, $values = null, $json = true)
{
    global $con;
    $sql = $where === null ? "SELECT * FROM $table" : "SELECT * FROM $table WHERE $where";
    $stmt = $con->prepare($sql);
    $stmt->execute($values ?? []);
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $count = count($data);
    if ($json) echo json_encode($count ? ['status'=>'success','data'=>$data] : ['status'=>'failure'], JSON_UNESCAPED_UNICODE);
    return $json ? $count : ($count ? $data : json_encode(['status'=>'failure']));
}

function getData($table, $where = null, $values = null)
{
    global $con;
    $stmt = $con->prepare("SELECT * FROM $table WHERE $where");
    $stmt->execute($values ?? []);
    $data = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($data) {
        unset($data['user_password'], $data['user_verifycode']);
        echo json_encode(['status'=>'success','data'=>$data], JSON_UNESCAPED_UNICODE);
        return 1;
    }
    echo json_encode(['status'=>'failure'], JSON_UNESCAPED_UNICODE);
    return 0;
}

function insertData($table, $data, $json = true)
{
    global $con;
    if (!$data) return 0;
    $fields = array_keys($data);
    $sql = "INSERT INTO $table (`" . implode('`,`', $fields) . "`) VALUES (:" . implode(',:', $fields) . ")";
    $stmt = $con->prepare($sql);
    foreach ($data as $f => $v) $stmt->bindValue(':'.$f, $v);
    $stmt->execute();
    $count = $stmt->rowCount();
    if ($json) echo json_encode($count ? ['status'=>'success','data'=>$data] : ['status'=>'failure'], JSON_UNESCAPED_UNICODE);
    return $count;
}

function updateData($table, $data, $where, $json = true)
{
    global $con;
    if (!$data) return 0;
    $cols = [];
    $vals = [];
    foreach ($data as $key => $val) {
        $cols[] = "`$key` = ?";
        $vals[] = $val;
    }
    $stmt = $con->prepare("UPDATE $table SET " . implode(', ', $cols) . " WHERE $where");
    $stmt->execute($vals);
    $count = $stmt->rowCount();
    if ($json) echo json_encode(['status' => $count >= 0 ? 'success' : 'failure'], JSON_UNESCAPED_UNICODE);
    return $count;
}

function deleteData($table, $where, $json = true)
{
    global $con;
    $stmt = $con->prepare("DELETE FROM $table WHERE $where");
    $stmt->execute();
    $count = $stmt->rowCount();
    if ($json) echo json_encode(['status' => $count > 0 ? 'success' : 'failure'], JSON_UNESCAPED_UNICODE);
    return $count;
}

function imageUpload($dir, $imageRequest)
{
    if (!isset($_FILES[$imageRequest]) || $_FILES[$imageRequest]['error'] === UPLOAD_ERR_NO_FILE) return 'empty';
    $file = $_FILES[$imageRequest];
    if ($file['error'] !== UPLOAD_ERR_OK || (int)$file['size'] > 5 * MB) return 'fail';
    if (!is_dir($dir) && !mkdir($dir, 0755, true)) return 'fail';

    $finfo = new finfo(FILEINFO_MIME_TYPE);
    $mime = $finfo->file($file['tmp_name']);
    $allowed = [
        'image/jpeg' => 'jpg',
        'image/png' => 'png',
        'image/webp' => 'webp',
    ];
    if (!isset($allowed[$mime])) return 'fail';
    $name = bin2hex(random_bytes(16)) . '.' . $allowed[$mime];
    return move_uploaded_file($file['tmp_name'], rtrim($dir, '/\\') . DIRECTORY_SEPARATOR . $name) ? $name : 'fail';
}

function deleteFile($dir, $imagename)
{
    $base = realpath($dir);
    if (!$base) return;
    $candidate = $base . DIRECTORY_SEPARATOR . basename((string)$imagename);
    if (is_file($candidate)) @unlink($candidate);
}

function printFail($message = 'null') { echo json_encode(['status'=>'failure','message'=>$message], JSON_UNESCAPED_UNICODE); }
function printSuccess($message = 'null') { echo json_encode(['status'=>'success','message'=>$message], JSON_UNESCAPED_UNICODE); }
function results($count, $Failmessage = 'null', $Sucmessage = 'null') { $count > 0 ? printSuccess($Sucmessage) : printFail($Failmessage); }

function sendEmail($to, $title, $body)
{
    $config = $GLOBALS['APP_CONFIG'] ?? [];
    $from = (string)($config['mail_from'] ?? 'no-reply@example.com');
    $autoload = __DIR__ . '/vendor/autoload.php';
    if (is_file($autoload) && !empty($config['smtp_host'])) {
        require_once $autoload;
        try {
            $mail = new PHPMailer\PHPMailer\PHPMailer(true);
            $mail->isSMTP();
            $mail->Host = (string)$config['smtp_host'];
            $mail->Port = (int)($config['smtp_port'] ?? 587);
            $mail->SMTPAuth = !empty($config['smtp_user']);
            $mail->Username = (string)($config['smtp_user'] ?? '');
            $mail->Password = (string)($config['smtp_pass'] ?? '');
            if (!empty($config['smtp_encryption'])) {
                $mail->SMTPSecure = (string)$config['smtp_encryption'];
            }
            $mail->CharSet = 'UTF-8';
            $mail->setFrom($from, 'DevEmm Commerce');
            $mail->addAddress((string)$to);
            $mail->Subject = (string)$title;
            $mail->Body = (string)$body;
            return $mail->send();
        } catch (Throwable $e) {
            error_log('SMTP error: ' . $e->getMessage());
            return false;
        }
    }
    $safeFrom = preg_replace('/[^A-Za-z0-9@._+-]/', '', $from);
    $headers = "From: {$safeFrom}\r\nContent-Type: text/plain; charset=UTF-8\r\n";
    return @mail((string)$to, (string)$title, (string)$body, $headers);
}

function getCount($count, $table, $where = null, $values = null)
{
    global $con;
    $sql = $where ? "SELECT COUNT($count) FROM $table WHERE $where" : "SELECT COUNT($count) FROM $table";
    $stmt = $con->prepare($sql);
    $stmt->execute($values ?? []);
    echo json_encode(['status'=>'success','data'=>(string)$stmt->fetchColumn()], JSON_UNESCAPED_UNICODE);
}

function getOnly($table, $select, $where = null, $values = null)
{
    global $con;
    $sql = $where ? "SELECT $select FROM $table WHERE $where" : "SELECT $select FROM $table";
    $stmt = $con->prepare($sql);
    $stmt->execute($values ?? []);
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($data ? ['status'=>'success','data'=>$data] : ['status'=>'failure'], JSON_UNESCAPED_UNICODE);
    return count($data);
}

function returnData($table, $where = null, $values = null, $json = false)
{
    global $con;
    $stmt = $con->prepare("SELECT * FROM $table WHERE $where");
    $stmt->execute($values ?? []);
    $data = $stmt->fetch(PDO::FETCH_ASSOC);
    $result = $data ? ['status'=>'success','data'=>$data] : ['status'=>'failure'];
    if ($json) echo json_encode($result, JSON_UNESCAPED_UNICODE);
    return $result;
}

function getOne($table, $where = null, $values = null, $json = true)
{
    global $con;
    $stmt = $con->prepare("SELECT * FROM $table WHERE $where LIMIT 1");
    $stmt->execute($values ?? []);
    $data = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($json) echo json_encode($data ? ['status'=>'success','data'=>$data] : ['status'=>'failure'], JSON_UNESCAPED_UNICODE);
    return $json ? ($data ? 1 : 0) : ($data ?: json_encode(['status'=>'failure']));
}

function fcmAccessToken(): ?array
{
    static $cached = null;
    if (is_array($cached)) return $cached;
    $config = $GLOBALS['APP_CONFIG'] ?? [];
    $projectId = (string)($config['firebase_project_id'] ?? '');
    $serviceAccount = (string)($config['firebase_service_account'] ?? '');
    $autoload = __DIR__ . '/vendor/autoload.php';
    if ($projectId === '' || !is_file($serviceAccount) || !is_file($autoload)) return null;
    require_once $autoload;
    try {
        $client = new Google_Client();
        $client->setAuthConfig($serviceAccount);
        $client->addScope('https://www.googleapis.com/auth/firebase.messaging');
        $tokenData = $client->fetchAccessTokenWithAssertion();
        $token = $tokenData['access_token'] ?? null;
        if (!$token) return null;
        $cached = ['project_id' => $projectId, 'access_token' => $token];
        return $cached;
    } catch (Throwable $e) {
        error_log('FCM auth error: ' . $e->getMessage());
        return null;
    }
}

function sendFCMToDevice($title, $message, string $deviceToken, $pageid, $pagename, $imageUrl = null, $icon = null, $sound = 'default', $color = '#111111', $route = '/home', $badge = 0, $priority = 'high')
{
    $auth = fcmAccessToken();
    if (!$auth || $deviceToken === '') return false;
    $payload = ['message'=>[
        'token'=>$deviceToken,
        'notification'=>['title'=>(string)$title,'body'=>(string)$message],
        'data'=>['pageid'=>(string)$pageid,'pagename'=>(string)$pagename,'route'=>(string)$route,'image'=>(string)($imageUrl ?? '')],
        'android'=>['priority'=>$priority,'notification'=>array_filter([
            'sound'=>$sound,
            'color'=>$color,
            'image'=>$imageUrl,
        ], static fn($v) => $v !== null && $v !== '')],
        'apns'=>['payload'=>['aps'=>['sound'=>$sound === 'default' ? 'default' : "$sound.caf",'badge'=>(int)$badge]]],
    ]];
    $ch = curl_init('https://fcm.googleapis.com/v1/projects/' . rawurlencode($auth['project_id']) . '/messages:send');
    curl_setopt_array($ch, [
        CURLOPT_POST=>true,
        CURLOPT_HTTPHEADER=>['Authorization: Bearer ' . $auth['access_token'], 'Content-Type: application/json'],
        CURLOPT_RETURNTRANSFER=>true,
        CURLOPT_TIMEOUT=>15,
        CURLOPT_POSTFIELDS=>json_encode($payload, JSON_UNESCAPED_SLASHES),
    ]);
    $result = curl_exec($ch);
    $code = (int)curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
    if ($code >= 200 && $code < 300) return $result ?: true;
    error_log("FCM delivery failed HTTP $code");
    return false;
}

function sendToNotification($title, $body, $userID, $pageid, $pagename, $imageUrl = null, $icon = null, $sound = 'default', $color = '#111111', $route = '/home', $badge = 0, $priority = 'high')
{
    global $con;
    $userID = (int)$userID;
    try {
        $data = [
            'notification_title'=>$title,
            'notification_body'=>$body,
            'notification_userid'=>$userID,
            'notification_image'=>$imageUrl,
        ];
        if ($icon !== null) $data['notification_icon'] = basename((string)$icon) . '.svg';
        insertData('notification', $data, false);
    } catch (Throwable $e) {
        error_log('Notification persistence error: ' . $e->getMessage());
        // Persistencia de notificación no debe romper una operación comercial ya confirmada.
    }

    try {
        $stmt = $con->prepare('SELECT token FROM device_tokens WHERE user_id = ? ORDER BY updated_at DESC');
        $stmt->execute([$userID]);
        $delivered = false;
        foreach ($stmt->fetchAll(PDO::FETCH_COLUMN) as $deviceToken) {
            if (sendFCMToDevice($title, $body, (string)$deviceToken, $pageid, $pagename, $imageUrl, $icon, $sound, $color, $route, $badge, $priority)) {
                $delivered = true;
            }
        }
        return $delivered;
    } catch (Throwable $e) {
        error_log('Push notification error: ' . $e->getMessage());
        return false;
    }
}

function sendNotifications($keyaccess, $title, $body, $pageid, $pagename, $imageUrl = null, $icon = null, $sound = 'default', $color = '#111111', $route = '/home', $badge = 0, $priority = 'high', $json = false)
{
    global $con;
    $success = false;
    try {
        $stmt = $con->prepare('SELECT user_id FROM user WHERE user_keyaccess = ?');
        $stmt->execute([(int)$keyaccess]);
        foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $row) {
            if (sendToNotification($title, $body, (int)$row['user_id'], $pageid, $pagename, $imageUrl, $icon, $sound, $color, $route, $badge, $priority)) $success = true;
        }
    } catch (Throwable $e) {
        error_log('Role notification error: ' . $e->getMessage());
    }
    if ($json) jsonResponse(['status'=>$success?'success':'failure']);
    return $success;
}

function generateUniqueUserId()
{
    global $con;
    do {
        $id = random_int(1, 2147483647);
        $stmt = $con->prepare('SELECT COUNT(*) FROM user WHERE user_id = ?');
        $stmt->execute([$id]);
    } while ((int)$stmt->fetchColumn() > 0);
    return $id;
}
