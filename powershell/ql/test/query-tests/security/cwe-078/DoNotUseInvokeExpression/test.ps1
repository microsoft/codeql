$command = "Get-Process"
Invoke-Expression $Command # $ Alert

Invoke-Expression "Get-Date" # $ Alert - constant command text still triggers best-practice query
