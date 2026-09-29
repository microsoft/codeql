# BAD: weak RNG output flows into security-sensitive .NET crypto sinks.

# 1) Weak bytes flow into AES .Key and .IV properties
$weak = New-Object System.Random
$keyBytes = New-Object byte[] 32
$ivBytes  = New-Object byte[] 16
$weak.NextBytes($keyBytes)
$weak.NextBytes($ivBytes)
$aes = [System.Security.Cryptography.Aes]::Create()
$aes.Key = $keyBytes   # BAD: predictable key
$aes.IV  = $ivBytes    # BAD: predictable IV

# 2) Weak bytes flow into HMAC constructor (signing key)
$hmacKeyBytes = New-Object byte[] 64
$weak.NextBytes($hmacKeyBytes)
$hmac = New-Object System.Security.Cryptography.HMACSHA256(,$hmacKeyBytes) # BAD: predictable HMAC key

# 3) Weak bytes used as salt for password-based key derivation
$saltBytes = New-Object byte[] 8
$weak.NextBytes($saltBytes)
$kdf = New-Object System.Security.Cryptography.Rfc2898DeriveBytes("password", $saltBytes) # BAD: predictable salt

# 4) Get-Random result flows into ConvertTo-SecureString → PSCredential
$tempPwd = (Get-Random -Maximum 999999999).ToString()
$securePwd = ConvertTo-SecureString $tempPwd -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("admin", $securePwd) # BAD: predictable credential

# 5) Weak random flows into HTTP Authorization header
$tokenValue = Get-Random -Maximum 999999999
Invoke-RestMethod -Uri "https://api.example.com/data" `
    -Headers @{ Authorization = "Bearer $tokenValue" } # BAD: predictable bearer token

# 6) Weak random used as RNGCryptoServiceProvider substitute for key bytes
$rng2 = [System.Random]::new()
$aesKey2 = New-Object byte[] 32
$rng2.NextBytes($aesKey2)
[Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($aesKey2) | Out-Null
# The above line re-fills the buffer, but the initial weak fill might persist
# if code logic is wrong.  True BAD pattern: relying solely on System.Random:
$aes2 = [System.Security.Cryptography.Aes]::Create()
$rng2.NextBytes($aesKey2)     # BAD: final value comes from weak RNG
$aes2.Key = $aesKey2          # BAD: predictable key assigned to cipher