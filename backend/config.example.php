<?php
return [
    'app_env' => 'production',
    'app_secret' => 'REEMPLAZAR_POR_UN_SECRETO_ALEATORIO_DE_32_O_MAS_CARACTERES',
    'db_host' => '127.0.0.1',
    'db_port' => '3306',
    'db_name' => 'ecommerce',
    'db_user' => 'ecommerce_user',
    'db_pass' => 'CAMBIAR',
    'cors_origins' => ['https://tu-dominio.com'],
    'firebase_project_id' => '',
    'firebase_service_account' => '/ruta/privada/fuera-del-webroot/firebase-service-account.json',
    'mail_from' => 'no-reply@tu-dominio.com',
    'smtp_host' => '',
    'smtp_port' => 587,
    'smtp_user' => '',
    'smtp_pass' => '',
    'smtp_encryption' => 'tls',
    'delivery_fee' => 10000, // COP; ajusta según tu negocio
    'currency' => 'COP',
    'auth_token_ttl_seconds' => 604800, // 7 días
];
