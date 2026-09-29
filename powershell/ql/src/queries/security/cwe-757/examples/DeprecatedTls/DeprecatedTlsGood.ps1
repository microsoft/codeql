# GOOD: Using TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# GOOD: Using TLS 1.3
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls13

# GOOD: Removing deprecated protocol flags from the current configuration
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -band (-bnot ([Net.SecurityProtocolType]::Ssl3 -bor [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11))
