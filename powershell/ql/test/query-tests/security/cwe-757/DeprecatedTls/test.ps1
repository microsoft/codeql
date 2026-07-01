# ===================================================================
# ========== TRUE POSITIVES (should trigger alert) ==================
# ===================================================================

# --- Case 1: SSL 3.0 ---
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Ssl3 # $ Alert

# --- Case 2: TLS 1.0 ---
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls # $ Alert

# --- Case 3: TLS 1.1 ---
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls11 # $ Alert

# --- Case 4: Full namespace TLS 1.0 ---
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls # $ Alert

# --- Case 5: Adding deprecated TLS 1.0 to the current protocol set ---
[Net.ServicePointManager]::SecurityProtocol += [Net.SecurityProtocolType]::Tls # $ Alert

# --- Case 6: Enabling deprecated TLS 1.0 with -bor ---
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls # $ Alert

# --- Case 7: Enabling deprecated TLS 1.1 in a protocol combination ---
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls11 # $ Alert

# --- Case 8: Deprecated SslProtocols value assigned for use ---
$sslProtocols = [System.Security.Authentication.SslProtocols]::Tls # $ Alert

# ===================================================================
# ========== TRUE NEGATIVES (should NOT trigger alert) ==============
# ===================================================================

# --- Safe: TLS 1.2 ---
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 # GOOD

# --- Safe: TLS 1.3 ---
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls13 # GOOD

# --- Safe: removing TLS 1.0 from the current protocol set ---
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -band (-bnot [Net.SecurityProtocolType]::Tls) # GOOD

# --- Safe: removing SSL 3.0, TLS 1.0, and TLS 1.1 from the current protocol set ---
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -band (-bnot ([Net.SecurityProtocolType]::Ssl3 -bor [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11)) # GOOD

# --- Safe: removing TLS 1.1 using the full namespace ---
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -band (-bnot [System.Net.SecurityProtocolType]::Tls11) # GOOD
