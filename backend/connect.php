<?php

declare(strict_types=1);

function jsonResponse(array $payload, int $status = 200): never
{
    http_response_code($status);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($payload, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

$defaults = [
    'app_env' => 'development',
    'app_secret' => '',
    'db_host' => '127.0.0.1',
    'db_port' => '3306',
    'db_name' => 'ecommerce',
    'db_user' => 'root',
    'db_pass' => '',
    'cors_origins' => [],
    'firebase_project_id' => '',
    'firebase_service_account' => '',
    'mail_from' => 'no-reply@example.com',
    'smtp_host' => '',
    'smtp_port' => 587,
    'smtp_user' => '',
    'smtp_pass' => '',
    'smtp_encryption' => 'tls',
    'delivery_fee' => 10000,
    'currency' => 'COP',
    'auth_token_ttl_seconds' => 604800,
];
$localConfig = __DIR__ . '/config.local.php';
if (is_file($localConfig)) {
    $loaded = require $localConfig;
    if (is_array($loaded)) $defaults = array_replace($defaults, $loaded);
}

// Variables de entorno tienen precedencia final: necesario para Docker/CI/hosting.
$envMap = [
    'APP_ENV'=>'app_env','APP_SECRET'=>'app_secret','DB_HOST'=>'db_host','DB_PORT'=>'db_port',
    'DB_NAME'=>'db_name','DB_USER'=>'db_user','DB_PASS'=>'db_pass',
    'FIREBASE_PROJECT_ID'=>'firebase_project_id','FIREBASE_SERVICE_ACCOUNT'=>'firebase_service_account',
    'MAIL_FROM'=>'mail_from','SMTP_HOST'=>'smtp_host','SMTP_PORT'=>'smtp_port','SMTP_USER'=>'smtp_user',
    'SMTP_PASS'=>'smtp_pass','SMTP_ENCRYPTION'=>'smtp_encryption','DELIVERY_FEE'=>'delivery_fee',
    'CURRENCY'=>'currency','AUTH_TOKEN_TTL_SECONDS'=>'auth_token_ttl_seconds',
];
foreach ($envMap as $envName => $key) {
    $value = getenv($envName);
    if ($value !== false && $value !== '') $defaults[$key] = $value;
}
$corsEnv = getenv('CORS_ORIGINS');
if ($corsEnv !== false && trim($corsEnv) !== '') {
    $defaults['cors_origins'] = array_values(array_filter(array_map('trim', explode(',', $corsEnv))));
}
$defaults['smtp_port'] = (int)$defaults['smtp_port'];
$defaults['delivery_fee'] = (float)$defaults['delivery_fee'];
$defaults['auth_token_ttl_seconds'] = (int)$defaults['auth_token_ttl_seconds'];
$GLOBALS['APP_CONFIG'] = $defaults;

header('Content-Type: application/json; charset=utf-8');
header('X-Content-Type-Options: nosniff');
header('X-Frame-Options: DENY');
header('Referrer-Policy: no-referrer');
header('Cache-Control: no-store');
if (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') {
    header('Strict-Transport-Security: max-age=31536000; includeSubDomains');
}

$origin = $_SERVER['HTTP_ORIGIN'] ?? '';
$allowed = $defaults['cors_origins'] ?? [];
if ($origin !== '' && in_array($origin, $allowed, true)) {
    header("Access-Control-Allow-Origin: $origin");
    header('Vary: Origin');
}
header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');
header('Access-Control-Allow-Methods: POST, OPTIONS, GET');
if (($_SERVER['REQUEST_METHOD'] ?? '') === 'OPTIONS') {
    http_response_code(204);
    exit;
}

$dsn = sprintf(
    'mysql:host=%s;port=%s;dbname=%s;charset=utf8mb4',
    $defaults['db_host'],
    $defaults['db_port'],
    $defaults['db_name']
);
try {
    $con = new PDO($dsn, $defaults['db_user'], $defaults['db_pass'], [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ]);
} catch (PDOException $e) {
    error_log('Database connection failed: ' . $e->getMessage());
    jsonResponse(['status' => 'database_unavailable'], 503);
}

$countrowinpage = 9;
require_once __DIR__ . '/functions.php';
require_once __DIR__ . '/security.php';

$requestPath = currentRequestPath();
$authUser = null;
if (isPublicEndpoint($requestPath)) {
    enforcePublicRateLimit($requestPath);
} else {
    $authUser = requireAuth();
    enforceRouteRole($requestPath, $authUser);
    enforcePostedOwnership($authUser);
}
