function Test1($outFile) {
  $uri = "https://github.com/example/project/releases/download/v1.2.3/installer.exe"
  Invoke-WebRequest -Uri $uri -OutFile $outFile # $ Alert
}

function Test2($outFile) {
  $uri = "https://github.com/example/project/releases/download/v1.2.3/installer.exe"
  $expectedHash = "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df"

  Invoke-WebRequest -Uri $uri -OutFile $outFile # GOOD

  $actualHash = (Get-FileHash -Path $outFile -Algorithm SHA256).Hash

  if ($actualHash -ne $expectedHash) {
      Remove-Item -Path $outFile -Force
      throw "Integrity check failed: '$outFile' does not match the expected hash."
  }
}