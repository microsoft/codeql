# ===================================================================
# ========== TRUE POSITIVES (should trigger alert) ==================
# ===================================================================

# --- Case 1: Get-Random cmdlet ---
$token = Get-Random -Minimum 100000 -Maximum 999999 # BAD

# --- Case 2: Get-Random without parameters ---
$randomValue = Get-Random # BAD

# --- Case 3: New-Object System.Random ---
$rng = New-Object System.Random # BAD

# --- Case 4: System.Random with method call ---
$rng2 = New-Object System.Random
$value = $rng2.Next(1, 100) # (The New-Object is the BAD part)

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
