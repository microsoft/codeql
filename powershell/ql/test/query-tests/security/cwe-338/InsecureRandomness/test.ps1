# ===================================================================
# ========== TRUE POSITIVES (should trigger alert) ==================
# ===================================================================

# --- Case 1: Weak RNG bytes flow into AES .Key and .IV ---
$weak = New-Object System.Random # BAD
$keyBytes = New-Object byte[] 32
$ivBytes  = New-Object byte[] 16
$weak.NextBytes($keyBytes)
$weak.NextBytes($ivBytes)
$aes = [System.Security.Cryptography.Aes]::Create()
$aes.Key = $keyBytes
$aes.IV  = $ivBytes

# --- Case 2: Weak RNG bytes flow into HMAC constructor ---
$weak2 = New-Object System.Random # BAD
$hmacKeyBytes = New-Object byte[] 64
$weak2.NextBytes($hmacKeyBytes)
$hmac = New-Object System.Security.Cryptography.HMACSHA256(,$hmacKeyBytes)

# --- Case 3: Weak RNG bytes used as KDF salt ---
$weak3 = New-Object System.Random # BAD
$saltBytes = New-Object byte[] 8
$weak3.NextBytes($saltBytes)
$kdf = New-Object System.Security.Cryptography.Rfc2898DeriveBytes("password", $saltBytes)

# --- Case 4: Get-Random flows into ConvertTo-SecureString → PSCredential ---
$tempPwd = (Get-Random -Maximum 999999999).ToString() # BAD
$securePwd = ConvertTo-SecureString $tempPwd -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("admin", $securePwd)

# --- Case 5: Get-Random flows into HTTP Authorization header ---
$tokenValue = Get-Random -Maximum 999999999 # BAD
Invoke-RestMethod -Uri "https://api.example.com/data" `
    -Headers @{ Authorization = "Bearer $tokenValue" }

# --- Case 6: [System.Random]::new() bytes flow into AES .Key ---
$rng3 = [System.Random]::new()
$aesKey2 = New-Object byte[] 32
$rng3.NextBytes($aesKey2)
$aes2 = [System.Security.Cryptography.Aes]::Create()
$aes2.Key = $aesKey2

# ===================================================================
# ========== TRUE NEGATIVES (should NOT trigger alert) ==============
# ===================================================================

# --- Safe: Using RandomNumberGenerator ---
$secureRng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
$bytes = New-Object byte[] 32
$secureRng.GetBytes($bytes) # GOOD

# --- Safe: Using RNGCryptoServiceProvider ---
$cspRng = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
$secureBytes = New-Object byte[] 16
$cspRng.GetBytes($secureBytes) # GOOD

# --- Safe: Using RandomNumberGenerator static method ---
$randomBytes = [System.Security.Cryptography.RandomNumberGenerator]::GetBytes(32) # GOOD

# --- Safe: CSPRNG bytes flow into AES .Key and .IV ---
$goodKeyBytes = New-Object byte[] 32
$goodIvBytes  = New-Object byte[] 16
[System.Security.Cryptography.RandomNumberGenerator]::Fill($goodKeyBytes)
[System.Security.Cryptography.RandomNumberGenerator]::Fill($goodIvBytes)
$goodAes = [System.Security.Cryptography.Aes]::Create()
$goodAes.Key = $goodKeyBytes # GOOD
$goodAes.IV  = $goodIvBytes  # GOOD

# --- Safe: CSPRNG bytes flow into HMAC constructor ---
$goodHmacKey = New-Object byte[] 64
[System.Security.Cryptography.RandomNumberGenerator]::Fill($goodHmacKey)
$goodHmac = New-Object System.Security.Cryptography.HMACSHA256(,$goodHmacKey) # GOOD

# --- Safe: CSPRNG bytes used as KDF salt ---
$goodSalt = New-Object byte[] 16
[System.Security.Cryptography.RandomNumberGenerator]::Fill($goodSalt)
$goodKdf = New-Object System.Security.Cryptography.Rfc2898DeriveBytes("password", $goodSalt) # GOOD

# --- Safe: CSPRNG bytes flow into ConvertTo-SecureString → PSCredential ---
$goodPwdBytes = New-Object byte[] 32
[System.Security.Cryptography.RandomNumberGenerator]::Fill($goodPwdBytes)
$goodPwd = [Convert]::ToBase64String($goodPwdBytes)
$goodSecurePwd = ConvertTo-SecureString $goodPwd -AsPlainText -Force
$goodCred = New-Object System.Management.Automation.PSCredential("admin", $goodSecurePwd) # GOOD

# --- Safe: CSPRNG bytes flow into HTTP Authorization header ---
$goodTokenBytes = New-Object byte[] 32
[System.Security.Cryptography.RandomNumberGenerator]::Fill($goodTokenBytes)
$goodBearer = [Convert]::ToBase64String($goodTokenBytes)
Invoke-RestMethod -Uri "https://api.example.com/data" `
    -Headers @{ Authorization = "Bearer $goodBearer" } # GOOD

# --- Safe: RNGCryptoServiceProvider fills key bytes for cipher ---
$goodRng = [Security.Cryptography.RNGCryptoServiceProvider]::Create()
$goodAesKey2 = New-Object byte[] 32
$goodRng.GetBytes($goodAesKey2)
$goodAes2 = [System.Security.Cryptography.Aes]::Create()
$goodAes2.Key = $goodAesKey2 # GOOD
