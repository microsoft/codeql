# BAD: An artifact is downloaded from GitHub and then executed without
# verifying that its contents match a known-good hash. If the release asset is
# replaced (for example, through a compromised account, a tampered mirror, or a
# man-in-the-middle attack), arbitrary code runs on the machine.
$uri = "https://github.com/example/project/releases/download/v1.2.3/installer.exe"
$outFile = Join-Path $env:TEMP "installer.exe"

Invoke-WebRequest -Uri $uri -OutFile $outFile

Start-Process -FilePath $outFile -Wait
