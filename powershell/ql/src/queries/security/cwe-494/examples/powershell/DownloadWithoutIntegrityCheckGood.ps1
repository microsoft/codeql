# GOOD: The artifact is downloaded from GitHub and its SHA-256 hash is compared
# against the expected value (published by the author through a trusted channel,
# such as the signed release notes) before it is used. The artifact is only
# executed once its integrity has been confirmed.
$uri = "https://github.com/example/project/releases/download/v1.2.3/installer.exe"
$outFile = Join-Path $env:TEMP "installer.exe"
$expectedHash = "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df"

Invoke-WebRequest -Uri $uri -OutFile $outFile

$actualHash = (Get-FileHash -Path $outFile -Algorithm SHA256).Hash

if ($actualHash -ne $expectedHash) {
    Remove-Item -Path $outFile -Force
    throw "Integrity check failed: '$outFile' does not match the expected hash."
}

Start-Process -FilePath $outFile -Wait
