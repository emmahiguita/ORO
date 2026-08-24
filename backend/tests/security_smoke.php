<?php

declare(strict_types=1);
if (PHP_SAPI !== 'cli') { http_response_code(404); exit; }

function jsonResponse(array $payload, int $status = 200): never
{
    throw new RuntimeException('jsonResponse inesperado: ' . json_encode($payload) . " ($status)");
}

final class FakeStatement {
    public function execute(array $params = []): bool { return true; }
    public function fetchColumn(): int { return 3; }
}
final class FakeConnection {
    public function prepare(string $sql): FakeStatement { return new FakeStatement(); }
}

$GLOBALS['APP_CONFIG'] = [
    'app_secret' => '0123456789abcdef0123456789abcdef0123456789abcdef',
    'auth_token_ttl_seconds' => 3600,
];
$con = new FakeConnection();
require dirname(__DIR__) . '/security.php';

$token = issueAuthToken(123, 2);
$claims = validateAuthToken($token);
if (!$claims || $claims['id'] !== 123 || $claims['role'] !== 2 || $claims['ver'] !== 3) {
    fwrite(STDERR, "FAIL: token válido no pudo verificarse.\n");
    exit(1);
}

$parts = explode('.', $token);
$parts[1] = base64UrlEncode(json_encode(['iss'=>'devemm-commerce','sub'=>999,'role'=>2,'ver'=>3,'iat'=>time(),'exp'=>time()+3600]));
if (validateAuthToken(implode('.', $parts)) !== null) {
    fwrite(STDERR, "FAIL: token manipulado fue aceptado.\n");
    exit(1);
}

if (validateAuthToken('invalid.token.value') !== null) {
    fwrite(STDERR, "FAIL: token inválido fue aceptado.\n");
    exit(1);
}

echo "Security token smoke tests: OK\n";
