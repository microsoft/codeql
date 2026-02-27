<?php
// ==========================================================
// Test file for PHP cryptography CodeQL queries
// Tests cover Microsoft SDL requirements:
//   - Banned algorithms: DES, 3DES, RC4, RC2, Blowfish
//   - Banned modes: ECB
//   - Weak hashes: MD5, SHA-1
//   - Deprecated: mcrypt extension
// ==========================================================

// ----------------------------------------------------------
// 1. WEAK/BROKEN ENCRYPTION ALGORITHMS (BrokenCryptoAlgorithm)
// ----------------------------------------------------------

// VULNERABLE: DES (banned by Microsoft SDL)
$encrypted = openssl_encrypt($data, 'des-ecb', $key);
$encrypted = openssl_encrypt($data, 'des-cbc', $key, 0, $iv);
$encrypted = openssl_encrypt($data, 'des-ede3-cbc', $key, 0, $iv);

// VULNERABLE: RC4 (banned by Microsoft SDL)
$encrypted = openssl_encrypt($data, 'rc4', $key);

// VULNERABLE: RC2 (weak, short key)
$encrypted = openssl_encrypt($data, 'rc2-cbc', $key, 0, $iv);

// VULNERABLE: Blowfish (not approved by SDL)
$encrypted = openssl_encrypt($data, 'bf-cbc', $key, 0, $iv);

// VULNERABLE: CAST5 (not approved)
$encrypted = openssl_encrypt($data, 'cast5-cbc', $key, 0, $iv);

// VULNERABLE: SEED (not approved)
$encrypted = openssl_encrypt($data, 'seed-cbc', $key, 0, $iv);

// VULNERABLE: IDEA (not approved)
$encrypted = openssl_encrypt($data, 'idea-cbc', $key, 0, $iv);

// VULNERABLE: DESX
$encrypted = openssl_encrypt($data, 'desx-cbc', $key, 0, $iv);

// VULNERABLE: DES with openssl_decrypt
$decrypted = openssl_decrypt($ciphertext, 'des-cbc', $key, 0, $iv);

// SAFE: AES-256-CBC (approved by Microsoft SDL)
$encrypted = openssl_encrypt($data, 'aes-256-cbc', $key, 0, $iv);

// SAFE: AES-128-GCM (approved, authenticated encryption)
$encrypted = openssl_encrypt($data, 'aes-128-gcm', $key, 0, $iv, $tag);

// SAFE: AES-256-GCM (approved, authenticated encryption)
$encrypted = openssl_encrypt($data, 'aes-256-gcm', $key, 0, $iv, $tag);

// ----------------------------------------------------------
// 2. INSECURE BLOCK MODE - ECB (InsecureBlockMode)
// ----------------------------------------------------------

// VULNERABLE: ECB mode leaks data patterns
$encrypted = openssl_encrypt($data, 'aes-128-ecb', $key);
$encrypted = openssl_encrypt($data, 'aes-256-ecb', $key);

// SAFE: CBC mode
$encrypted = openssl_encrypt($data, 'aes-256-cbc', $key, 0, $iv);

// SAFE: GCM mode (authenticated)
$encrypted = openssl_encrypt($data, 'aes-256-gcm', $key, 0, $iv, $tag);

// ----------------------------------------------------------
// 3. WEAK HASH FUNCTIONS (WeakCryptoHash)
// ----------------------------------------------------------

// VULNERABLE: MD5 (broken, collisions found)
$hash = md5($password);
$hash = md5_file('/path/to/file');

// VULNERABLE: SHA-1 (broken, collisions demonstrated)
$hash = sha1($data);
$hash = sha1_file('/path/to/file');

// VULNERABLE: CRC32 (not cryptographic)
$checksum = crc32($data);

// VULNERABLE: hash() with weak algorithm
$hash = hash('md5', $data);
$hash = hash('sha1', $data);
$hash = hash('md4', $data);
$hash = hash('ripemd160', $data);
$hash = hash('crc32', $data);
$hash = hash('adler32', $data);

// VULNERABLE: hash_init() with weak algorithm
$ctx = hash_init('md5');
$ctx = hash_init('sha1');

// VULNERABLE: hash_hmac() with weak algorithm
$mac = hash_hmac('md5', $data, $key);
$mac = hash_hmac('sha1', $data, $key);

// VULNERABLE: hash_file() with weak algorithm
$hash = hash_file('md5', '/path/to/file');

// SAFE: SHA-256 (approved)
$hash = hash('sha256', $data);
$hash = hash('sha512', $data);
$hash = hash('sha3-256', $data);

// SAFE: hash_hmac with SHA-256
$mac = hash_hmac('sha256', $data, $key);

// SAFE: password_hash (bcrypt/argon2)
$passwordHash = password_hash($password, PASSWORD_BCRYPT);
$passwordHash = password_hash($password, PASSWORD_ARGON2ID);

// ----------------------------------------------------------
// 4. DEPRECATED MCRYPT EXTENSION (DeprecatedMcrypt)
// ----------------------------------------------------------

// VULNERABLE: mcrypt is deprecated since PHP 7.1, removed in 7.2
$encrypted = mcrypt_encrypt(MCRYPT_DES, $key, $data, MCRYPT_MODE_ECB);
$encrypted = mcrypt_encrypt(MCRYPT_3DES, $key, $data, MCRYPT_MODE_CBC, $iv);
$encrypted = mcrypt_encrypt(MCRYPT_RIJNDAEL_256, $key, $data, MCRYPT_MODE_CBC, $iv);
$decrypted = mcrypt_decrypt(MCRYPT_BLOWFISH, $key, $ciphertext, MCRYPT_MODE_CBC, $iv);
$td = mcrypt_module_open(MCRYPT_DES, '', MCRYPT_MODE_ECB, '');
$iv = mcrypt_create_iv(mcrypt_get_iv_size(MCRYPT_DES, MCRYPT_MODE_ECB), MCRYPT_DEV_URANDOM);
mcrypt_generic_init($td, $key, $iv);
$encrypted = mcrypt_generic($td, $data);
mcrypt_generic_deinit($td);
mcrypt_module_close($td);
