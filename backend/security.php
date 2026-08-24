<?php

declare(strict_types=1);

function base64UrlEncode(string $data): string
{
    return rtrim(strtr(base64_encode($data), '+/', '-_'), '=');
}

function base64UrlDecode(string $data): string|false
{
    $padding = strlen($data) % 4;
    if ($padding) $data .= str_repeat('=', 4 - $padding);
    return base64_decode(strtr($data, '-_', '+/'), true);
}

function authSecret(): string
{
    $config = $GLOBALS['APP_CONFIG'] ?? [];
    $secret = (string)($config['app_secret'] ?? '');
    if (strlen($secret) < 32) {
        jsonResponse([
            'status' => 'configuration_error',
            'message' => 'APP_SECRET debe tener al menos 32 caracteres.',
        ], 500);
    }
    return $secret;
}

function issueAuthToken(int $userId, int $role, ?int $ttlSeconds = null): string
{
    global $con;
    $config = $GLOBALS['APP_CONFIG'] ?? [];
    $ttlSeconds ??= max(900, (int)($config['auth_token_ttl_seconds'] ?? 604800));
    $stmt = $con->prepare('SELECT user_token_version FROM user WHERE user_id = ? LIMIT 1');
    $stmt->execute([$userId]);
    $version = $stmt->fetchColumn();
    if ($version === false) jsonResponse(['status' => 'unauthorized'], 401);

    $now = time();
    $header = base64UrlEncode(json_encode(['alg' => 'HS256', 'typ' => 'JWT'], JSON_UNESCAPED_SLASHES));
    $payload = base64UrlEncode(json_encode([
        'iss' => 'devemm-commerce',
        'sub' => $userId,
        'role' => $role,
        'ver' => (int)$version,
        'iat' => $now,
        'exp' => $now + $ttlSeconds,
    ], JSON_UNESCAPED_SLASHES));
    $signature = base64UrlEncode(hash_hmac('sha256', "$header.$payload", authSecret(), true));
    return "$header.$payload.$signature";
}

function bearerToken(): ?string
{
    $header = $_SERVER['HTTP_AUTHORIZATION'] ?? $_SERVER['REDIRECT_HTTP_AUTHORIZATION'] ?? '';
    if ($header === '' && function_exists('getallheaders')) {
        $headers = getallheaders();
        $header = $headers['Authorization'] ?? $headers['authorization'] ?? '';
    }
    return preg_match('/^Bearer\s+(.+)$/i', trim((string)$header), $m) ? trim($m[1]) : null;
}

function validateAuthToken(?string $token): ?array
{
    if (!$token) return null;
    $parts = explode('.', $token);
    if (count($parts) !== 3) return null;
    [$headerPart, $payloadPart, $signature] = $parts;

    $decodedHeader = base64UrlDecode($headerPart);
    if ($decodedHeader === false) return null;
    $header = json_decode($decodedHeader, true);
    if (!is_array($header) || ($header['alg'] ?? null) !== 'HS256' || ($header['typ'] ?? null) !== 'JWT') return null;

    $expected = base64UrlEncode(hash_hmac('sha256', "$headerPart.$payloadPart", authSecret(), true));
    if (!hash_equals($expected, $signature)) return null;

    $decodedPayload = base64UrlDecode($payloadPart);
    if ($decodedPayload === false) return null;
    $claims = json_decode($decodedPayload, true);
    if (!is_array($claims) || !isset($claims['sub'], $claims['role'], $claims['ver'], $claims['iat'], $claims['exp'])) return null;
    if (($claims['iss'] ?? null) !== 'devemm-commerce') return null;
    if ((int)$claims['iat'] > time() + 60 || (int)$claims['exp'] <= time()) return null;

    return ['id' => (int)$claims['sub'], 'role' => (int)$claims['role'], 'ver' => (int)$claims['ver']];
}

function requireAuth(): array
{
    global $con;
    $auth = validateAuthToken(bearerToken());
    if (!$auth) jsonResponse(['status' => 'unauthorized'], 401);

    // Revalida la cuenta en servidor para que cambios de rol/bloqueos tengan efecto
    // aunque el token aún no haya expirado.
    $stmt = $con->prepare('SELECT user_id,user_keyaccess,user_approve,user_token_version FROM user WHERE user_id=? LIMIT 1');
    $stmt->execute([(int)$auth['id']]);
    $account = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$account || (int)$account['user_keyaccess'] !== (int)$auth['role'] || (int)$account['user_token_version'] !== (int)$auth['ver']) {
        jsonResponse(['status' => 'unauthorized'], 401);
    }
    if ((int)$account['user_keyaccess'] === 0 && (int)$account['user_approve'] !== 1) {
        jsonResponse(['status' => 'account_unverified'], 403);
    }
    return $auth;
}

function requireRole(array $auth, array $roles): void
{
    if (!in_array((int)$auth['role'], $roles, true)) jsonResponse(['status' => 'forbidden'], 403);
}

function currentRequestPath(): string
{
    return str_replace('\\', '/', (string)($_SERVER['SCRIPT_NAME'] ?? $_SERVER['PHP_SELF'] ?? ''));
}

function isPublicEndpoint(string $path): bool
{
    $public = [
        '/auth/login.php',
        '/auth/signup.php',
        '/auth/verifycode.php',
        '/auth/resendcode.php',
        '/forgotpassword/checkemail.php',
        '/forgotpassword/verifycodepass.php',
        '/forgotpassword/resetpassword.php',
        '/config/public.php',
        '/test.php',
    ];
    foreach ($public as $suffix) if (str_ends_with($path, $suffix)) return true;
    return false;
}

function enforceRouteRole(string $path, array $auth): void
{
    if (str_contains($path, '/admin/')) {
        requireRole($auth, [2]);
    } elseif (str_contains($path, '/delivery/')) {
        requireRole($auth, [1, 2]);
    }
}

function enforcePostedOwnership(array $auth): void
{
    if ((int)$auth['role'] === 2) return;
    foreach (['userid', 'user_id', 'userId', 'userID'] as $key) {
        if (isset($_POST[$key]) && (string)$_POST[$key] !== (string)$auth['id']) {
            jsonResponse(['status' => 'forbidden'], 403);
        }
    }
}

function requireOwnerOrAdmin(array $auth, int|string $userId): void
{
    if ((int)$auth['role'] !== 2 && (string)$auth['id'] !== (string)$userId) {
        jsonResponse(['status' => 'forbidden'], 403);
    }
}

function clientIp(): string
{
    return substr((string)($_SERVER['REMOTE_ADDR'] ?? 'unknown'), 0, 64);
}

function enforceRateLimit(string $bucket, int $maxAttempts, int $windowSeconds): void
{
    $dir = sys_get_temp_dir() . DIRECTORY_SEPARATOR . 'devemm-commerce-rate-limit';
    if (!is_dir($dir) && !@mkdir($dir, 0700, true) && !is_dir($dir)) {
        error_log('No se pudo crear directorio de rate limit.');
        return; // fail-open: no tumbar la tienda por un problema del filesystem temporal.
    }
    $key = hash('sha256', $bucket . '|' . clientIp());
    $file = $dir . DIRECTORY_SEPARATOR . $key . '.json';
    $fp = @fopen($file, 'c+');
    if (!$fp) return;
    try {
        if (!flock($fp, LOCK_EX)) return;
        $raw = stream_get_contents($fp);
        $state = $raw ? json_decode($raw, true) : null;
        $now = time();
        if (!is_array($state) || (int)($state['reset'] ?? 0) <= $now) {
            $state = ['count' => 0, 'reset' => $now + $windowSeconds];
        }
        $state['count'] = (int)$state['count'] + 1;
        ftruncate($fp, 0);
        rewind($fp);
        fwrite($fp, json_encode($state));
        fflush($fp);
        if ((int)$state['count'] > $maxAttempts) {
            $retry = max(1, (int)$state['reset'] - $now);
            header('Retry-After: ' . $retry);
            jsonResponse(['status' => 'rate_limited', 'retry_after' => $retry], 429);
        }
    } finally {
        @flock($fp, LOCK_UN);
        @fclose($fp);
    }
}

function enforcePublicRateLimit(string $path): void
{
    $rules = [
        '/auth/login.php' => ['login', 12, 60],
        '/auth/signup.php' => ['signup', 5, 600],
        '/auth/verifycode.php' => ['verify', 10, 300],
        '/auth/resendcode.php' => ['resend', 5, 600],
        '/forgotpassword/checkemail.php' => ['password_request', 5, 600],
        '/forgotpassword/verifycodepass.php' => ['password_verify', 10, 300],
        '/forgotpassword/resetpassword.php' => ['password_reset', 5, 600],
    ];
    foreach ($rules as $suffix => [$bucket, $max, $window]) {
        if (str_ends_with($path, $suffix)) {
            enforceRateLimit($bucket, $max, $window);
            return;
        }
    }
}
