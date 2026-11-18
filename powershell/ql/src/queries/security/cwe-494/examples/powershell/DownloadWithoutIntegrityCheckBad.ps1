# BAD: An HTTP download is executed without verification. An on-path attacker
# can replace the downloaded executable.
$uri = "http://downloads.example.com/installer.exe"
$outFile = Join-Path $env:TEMP "installer.exe"

Invoke-WebRequest -Uri $uri -OutFile $outFile

Start-Process -FilePath $outFile -Wait
