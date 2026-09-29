# GOOD: cryptographic RNG output flows into security-sensitive .NET crypto sinks.

# 1) CSPRNG bytes flow into AES .Key and .IV properties
$keyBytes = New-Object byte[] 32
$ivBytes  = New-Object byte[] 16
[System.Security.Cryptography.RandomNumberGenerator]::Fill($keyBytes)
[System.Security.Cryptography.RandomNumberGenerator]::Fill($ivBytes)
$aes = [System.Security.Cryptography.Aes]::Create()
$aes.Key = $keyBytes   # GOOD: cryptographically random key
$aes.IV  = $ivBytes    # GOOD: cryptographically random IV

# 2) CSPRNG bytes flow into HMAC constructor (signing key)
$hmacKeyBytes = New-Object byte[] 64
[System.Security.Cryptography.RandomNumberGenerator]::Fill($hmacKeyBytes)
$hmac = New-Object System.Security.Cryptography.HMACSHA256(,$hmacKeyBytes) # GOOD

# 3) CSPRNG bytes used as salt for password-based key derivation
$saltBytes = New-Object byte[] 16
[System.Security.Cryptography.RandomNumberGenerator]::Fill($saltBytes)
$kdf = New-Object System.Security.Cryptography.Rfc2898DeriveBytes("password", $saltBytes) # GOOD

# 4) CSPRNG bytes flow into ConvertTo-SecureString → PSCredential
$pwdBytes = New-Object byte[] 32
[System.Security.Cryptography.RandomNumberGenerator]::Fill($pwdBytes)
$tempPwd = [Convert]::ToBase64String($pwdBytes)
$securePwd = ConvertTo-SecureString $tempPwd -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("admin", $securePwd) # GOOD

# 5) CSPRNG bytes flow into HTTP Authorization header
$tokenBytes = New-Object byte[] 32
[System.Security.Cryptography.RandomNumberGenerator]::Fill($tokenBytes)
$bearerToken = [Convert]::ToBase64String($tokenBytes)
Invoke-RestMethod -Uri "https://api.example.com/data" `
    -Headers @{ Authorization = "Bearer $bearerToken" } # GOOD

# 6) CSPRNG via RNGCryptoServiceProvider fills key bytes for cipher
$rng = [Security.Cryptography.RNGCryptoServiceProvider]::Create()
$aesKey2 = New-Object byte[] 32
$rng.GetBytes($aesKey2)       # GOOD: filled by CSPRNG
$aes2 = [System.Security.Cryptography.Aes]::Create()
$aes2.Key = $aesKey2          # GOOD: unpredictable key