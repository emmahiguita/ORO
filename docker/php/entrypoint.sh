#!/usr/bin/env bash
set -euo pipefail
cd /var/www/html/ecommerce

echo "[DevEmm] Esperando base de datos..."
until php -r '$dsn="mysql:host=".getenv("DB_HOST").";port=".getenv("DB_PORT").";dbname=".getenv("DB_NAME").";charset=utf8mb4"; try { new PDO($dsn,getenv("DB_USER"),getenv("DB_PASS"),[PDO::ATTR_TIMEOUT=>2]); exit(0); } catch(Throwable $e) { exit(1); }'; do
  sleep 2
done

echo "[DevEmm] Instalando dependencias PHP..."
composer install --no-interaction --prefer-dist

echo "[DevEmm] Aplicando migraciones V3..."
php tools/migrate.php

exec apache2-foreground
