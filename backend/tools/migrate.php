<?php

declare(strict_types=1);
if (PHP_SAPI !== 'cli') { http_response_code(404); exit; }

$base = dirname(__DIR__);
$config = [
    'db_host'=>'127.0.0.1',
    'db_port'=>'3306',
    'db_name'=>'ecommerce',
    'db_user'=>'root',
    'db_pass'=>'',
];
if (is_file($base.'/config.local.php')) {
    $local=require $base.'/config.local.php';
    if(is_array($local))$config=array_replace($config,$local);
}
foreach (['DB_HOST'=>'db_host','DB_PORT'=>'db_port','DB_NAME'=>'db_name','DB_USER'=>'db_user','DB_PASS'=>'db_pass'] as $env=>$key) {
    $value=getenv($env);
    if($value!==false && $value!=='')$config[$key]=$value;
}
$dsn=sprintf('mysql:host=%s;port=%s;dbname=%s;charset=utf8mb4',$config['db_host'],$config['db_port'],$config['db_name']);
$con=new PDO($dsn,$config['db_user'],$config['db_pass'],[PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION,PDO::ATTR_DEFAULT_FETCH_MODE=>PDO::FETCH_ASSOC,PDO::ATTR_EMULATE_PREPARES=>false]);
$db=(string)$config['db_name'];

function columnExists(PDO $con,string $db,string $table,string $column):bool{
    $s=$con->prepare('SELECT 1 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=? AND TABLE_NAME=? AND COLUMN_NAME=? LIMIT 1');$s->execute([$db,$table,$column]);return (bool)$s->fetchColumn();
}
function indexExists(PDO $con,string $db,string $table,string $index):bool{
    $s=$con->prepare('SELECT 1 FROM information_schema.STATISTICS WHERE TABLE_SCHEMA=? AND TABLE_NAME=? AND INDEX_NAME=? LIMIT 1');$s->execute([$db,$table,$index]);return (bool)$s->fetchColumn();
}
function run(string $label, callable $fn):void{echo '[MIGRATE] '.$label.'... ';$fn();echo "OK\n";}

if(!columnExists($con,$db,'address','address_marker')) run('address.address_marker',fn()=> $con->exec("ALTER TABLE address ADD COLUMN address_marker varchar(255) DEFAULT NULL AFTER address_deliverytime"));
run('user_password VARCHAR(255)',fn()=> $con->exec("ALTER TABLE user MODIFY user_password varchar(255) NOT NULL"));
if(!columnExists($con,$db,'user','user_verify_expires_at')) run('user_verify_expires_at',fn()=> $con->exec("ALTER TABLE user ADD COLUMN user_verify_expires_at datetime DEFAULT NULL AFTER user_verifycode"));
if(!columnExists($con,$db,'user','user_verify_attempts')) run('user_verify_attempts',fn()=> $con->exec("ALTER TABLE user ADD COLUMN user_verify_attempts smallint unsigned NOT NULL DEFAULT 0 AFTER user_verify_expires_at"));
if(!columnExists($con,$db,'user','user_token_version')) run('user_token_version',fn()=> $con->exec("ALTER TABLE user ADD COLUMN user_token_version int unsigned NOT NULL DEFAULT 0 AFTER user_verify_attempts"));

run('device_tokens', fn()=> $con->exec("CREATE TABLE IF NOT EXISTS device_tokens (
 device_token_id bigint unsigned NOT NULL AUTO_INCREMENT,
 user_id int NOT NULL,
 token_hash char(64) NOT NULL,
 token text NOT NULL,
 platform varchar(32) NOT NULL,
 created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (device_token_id),
 UNIQUE KEY uq_device_token_hash (token_hash),
 KEY idx_device_user (user_id),
 CONSTRAINT device_tokens_user_fk FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci"));

$indexes=[
 ['favourites','uq_favourites_user_item','UNIQUE','favourite_userid,favourite_itemid'],
 ['rating','uq_rating_user_item','UNIQUE','rating_userid,rating_itemid'],
 ['delivery','uq_delivery_order','UNIQUE','delivery_orderid'],
 ['cart','idx_cart_open_lookup','','cart_userid,cart_orderid,cart_itemid'],
 ['orders','idx_orders_user_status','','order_userid,order_status,order_datetime'],
 ['notification','idx_notification_user_read','','notification_userid,is_read,notification_datetime'],
];
foreach($indexes as [$table,$name,$kind,$cols]){
    if(indexExists($con,$db,$table,$name))continue;
    try{run("índice $name",fn()=> $con->exec("CREATE $kind INDEX $name ON $table ($cols)"));}
    catch(Throwable $e){echo "WARN: no se creó $name: {$e->getMessage()}\n";}
}

$views=file_get_contents($base.'/views.sql');
foreach(array_filter(array_map('trim',preg_split('/;\s*(?:\r?\n|$)/',$views))) as $sql){
    if($sql!=='')$con->exec($sql);
}
echo "[MIGRATE] vistas recreadas... OK\n";
echo "Migración DevEmm Commerce completada.\n";
