<?php

declare(strict_types=1);

require_once __DIR__ . '/connect.php';

jsonResponse([
    'status' => 'success',
    'service' => 'DevEmm Commerce API',
    'version' => '3.0.0',
    'environment' => $GLOBALS['APP_CONFIG']['app_env'] ?? 'production',
    'timestamp' => time(),
]);
