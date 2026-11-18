# CWE-494 - Execution of an insecure or attacker-controlled download.
#
# A finding requires both a modeled untrusted origin and code execution/loading.
# Download-only, extraction-only, and fixed HTTPS origins are outside this scope.
#
#   # $ Alert            -> the query reports here (expected true positive)
#   # $ MISSING: Alert   -> the query SHOULD report here but does not yet
#                           (known false negative)
#   # $ SPURIOUS: Alert  -> the query reports here but should not
#                           (known false positive)
#
# When the query is improved to close a gap, flip MISSING -> Alert (or remove
# SPURIOUS) and re-accept the .expected file.

# ---------------------------------------------------------------------------
# COVERED today: a recognised cmdlet with a NAMED -Uri and a NAMED -OutFile.
# ---------------------------------------------------------------------------

function Iwr_NamedUri_OutFile($outFile) {
  # BAD - an on-path attacker can replace the executable.
  $uri = "http://github.com/example/project/releases/download/v1.2.3/installer.exe"
  Invoke-WebRequest -Uri $uri -OutFile $outFile # $ Alert
  & $outFile
}

function Iwr_NamedUri_OutFile_Hashed($outFile) {
  # GOOD - mismatch terminates before the downloaded artifact can be used.
  $uri = "http://github.com/example/project/releases/download/v1.2.3/installer.exe"
  $expected = "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df"
  Invoke-WebRequest -Uri $uri -OutFile $outFile
  $actual = (Get-FileHash -Path $outFile -Algorithm SHA256).Hash
  if ($actual -ne $expected) { Remove-Item $outFile -Force; throw "hash mismatch" }
  & $outFile
}

# ---------------------------------------------------------------------------
# Argument-shape variants of Invoke-WebRequest / Invoke-RestMethod.
# ---------------------------------------------------------------------------

function Iwr_PositionalUri($outFile) {
  # BAD - URL passed positionally, not as -Uri.
  Invoke-WebRequest "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile # $ Alert
  & $outFile
}

function Iwr_Alias_Positional($outFile) {
  # BAD - iwr alias + positional URL.
  iwr "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile # $ Alert
  & $outFile
}

function Iwr_NoOutFile_PipedToIex() {
  # BAD - no -OutFile; content executed inline.
  $r = Invoke-WebRequest -Uri "http://github.com/example/project/releases/download/v1/bootstrap.ps1" # $ Alert
  Invoke-Expression $r.Content
}

function Irm_NoOutFile() {
  # BAD - Invoke-RestMethod returns content, no -OutFile.
  irm "http://github.com/example/project/releases/download/v1/install.ps1" | Invoke-Expression # $ Alert
}

# ---------------------------------------------------------------------------
# Other modeled download APIs.
# ---------------------------------------------------------------------------

function WebClient_DownloadFile($outFile) {
  # BAD - System.Net.WebClient.DownloadFile.
  $wc = New-Object System.Net.WebClient
  $wc.DownloadFile("http://github.com/example/project/releases/download/v1/app.exe", $outFile) # $ Alert
  & $outFile
}

function WebClient_Inline($outFile) {
  # BAD - inline (New-Object Net.WebClient).DownloadFile(...).
  (New-Object Net.WebClient).DownloadFile("http://github.com/example/project/releases/download/v1/app.exe", $outFile) # $ Alert
  & $outFile
}

function Bits_Transfer($outFile) {
  # BAD - Start-BitsTransfer.
  Start-BitsTransfer -Source "http://github.com/example/project/releases/download/v1/app.exe" -Destination $outFile # $ Alert
  & $outFile
}

function Curl_Native($outFile) {
  # BAD - native curl with an explicit destination.
  curl.exe "http://downloads.example.com/app.exe" -o $outFile # $ Alert
  & $outFile
}

function Wget_Native() {
  # No execution: merely retrieving an archive is not enough.
  wget "http://downloads.example.com/app.tar.gz"
}

function AzCopy($outFile) {
  azcopy copy "http://downloads.example.com/app.exe" $outFile # $ Alert
  & $outFile
}

function Wrapper_Function($outFile) {
  # An undefined helper is not evidence that a download takes place.
  Download-File "http://downloads.example.com/app.exe" $outFile
  & $outFile
}

# ---------------------------------------------------------------------------
# Verified by means other than Get-FileHash - should NOT be flagged.
# ---------------------------------------------------------------------------

function Verified_With_CertUtil($outFile) {
  # GOOD - certutil computes a hash and mismatch terminates the script.
  $uri = "http://github.com/example/project/releases/download/v1/app.exe"
  Invoke-WebRequest -Uri $uri -OutFile $outFile
  $h = certutil -hashfile $outFile SHA256
  if ($h -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
  & $outFile
}

# ---------------------------------------------------------------------------
# Verification and excluded origin/use patterns.
# ---------------------------------------------------------------------------

function Verified_With_ComputeHash($outFile) {
  # GOOD - hash computed via [SHA256]::Create().ComputeHash over the bytes read
  # from the downloaded file, then compared.
  $uri = "http://github.com/example/project/releases/download/v1/app.exe"
  Invoke-WebRequest -Uri $uri -OutFile $outFile
  $sha = [System.Security.Cryptography.SHA256]::Create()
  $bytes = [System.IO.File]::ReadAllBytes($outFile)
  $hash = [System.BitConverter]::ToString($sha.ComputeHash($bytes)).Replace("-", "")
  if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
  & $outFile
}

function Verified_With_Signature($outFile) {
  # Status alone does not establish the intended publisher.
  $uri = "http://github.com/example/project/releases/download/v1/app.exe"
  Invoke-WebRequest -Uri $uri -OutFile $outFile # $ Alert
  $sig = Get-AuthenticodeSignature -FilePath $outFile
  if ($sig.Status -ne "Valid") { throw "bad signature" }
  & $outFile
}

function Verified_With_Cosign($outFile) {
  # Merely invoking a verifier does not enforce its result.
  $uri = "http://github.com/example/project/releases/download/v1/app.exe"
  Invoke-WebRequest -Uri $uri -OutFile $outFile # $ Alert
  cosign verify-blob --signature "$outFile.sig" $outFile
  & $outFile
}

function NonArtifact_Host($outFile) {
  # A fixed HTTPS origin with no code execution is outside the strict scope.
  Invoke-WebRequest -Uri "https://example.com/data/report.json" -OutFile $outFile
}

function GitHub_Api_DataOnly() {
  # GOOD - a GitHub API metadata call, not an artifact download. The response is
  # only inspected, never written to disk or executed.
  $r = Invoke-RestMethod -Uri "https://api.github.com/repos/example/project/releases/latest"
  return $r.tag_name
}

function Local_Copy($outFile) {
  # GOOD - copying a local file; no network download.
  Copy-Item -Path "C:\artifacts\app.exe" -Destination $outFile
}

# ---------------------------------------------------------------------------
# Hashing is only verification when a complete expected digest is enforced.
# ---------------------------------------------------------------------------

function Hash_Ignored($outFile) {
  Invoke-WebRequest "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile # $ Alert
  Get-FileHash -Path $outFile -Algorithm SHA256
  & $outFile
}

function Hash_Mismatch_OnlyLogged($outFile) {
  Invoke-WebRequest "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile # $ Alert
  $hash = (Get-FileHash -Path $outFile).Hash
  if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") {
    Write-Error "hash mismatch"
  }
  & $outFile
}

function Hash_Conditional($outFile, $verify) {
  Invoke-WebRequest "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile # $ Alert
  if ($verify) {
    $hash = (Get-FileHash -Path $outFile).Hash
    if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
  }
  & $outFile
}

function Hash_AfterUse($outFile) {
  Invoke-WebRequest "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile # $ Alert
  & $outFile
  $hash = (Get-FileHash -Path $outFile).Hash
  if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
}

function Hash_WrongFile($outFile) {
  Invoke-WebRequest "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile # $ Alert
  $hash = (Get-FileHash -Path "$outFile.sig").Hash
  if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
  & $outFile
}

function Hash_WrongProperty($outFile) {
  Invoke-WebRequest "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile # $ Alert
  $algorithm = (Get-FileHash -Path $outFile).Algorithm
  if ($algorithm -ne "SHA256") { throw "unexpected algorithm" }
  & $outFile
}

function Hash_SelfComparison($outFile) {
  Invoke-WebRequest "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile # $ Alert
  $hash = (Get-FileHash -Path $outFile).Hash
  if ($hash -ne $hash) { throw "hash mismatch" }
  & $outFile
}

function Hash_Mismatch_Caught($outFile) {
  Invoke-WebRequest "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile # $ Alert
  try {
    $hash = (Get-FileHash -Path $outFile).Hash
    if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
  } catch {
    Write-Warning "Continuing despite hash failure"
  }
  & $outFile
}

function Hash_BeforeDownload($outFile) {
  $hash = (Get-FileHash -Path $outFile).Hash
  if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
  Invoke-WebRequest "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile # $ Alert
  & $outFile
}

function CertUtil_NotHashing($outFile) {
  Invoke-WebRequest "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile # $ Alert
  certutil -encode $outFile "$outFile.b64"
  & $outFile
}

function ComputeHash_Ignored($outFile) {
  Invoke-WebRequest "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile # $ Alert
  $sha = [System.Security.Cryptography.SHA256]::Create()
  $sha.ComputeHash([System.IO.File]::ReadAllBytes($outFile))
  & $outFile
}

function Hash_Valid_Alias_ReversedOperands($outFile) {
  iwr "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile
  $hash = (gfh -LiteralPath $outFile).Hash
  if ("8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df" -cne $hash) { throw "hash mismatch" }
  & $outFile
}

function Hash_Valid_EqualityElse($outFile) {
  Invoke-WebRequest "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile
  $hash = (Get-FileHash $outFile).Hash
  if ($hash -eq "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") {
    & $outFile
  } else {
    throw "hash mismatch"
  }
}

function Hash_AfterCallOperatorUse($outFile) {
  Invoke-WebRequest "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile # $ Alert
  & $outFile
  $hash = (Get-FileHash -Path $outFile).Hash
  if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
}

function Hash_PartialDigest($outFile) {
  Invoke-WebRequest "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile # $ Alert
  $hash = (Get-FileHash -Path $outFile).Hash.Substring(0, 6)
  if ($hash -ne "8c954c") { throw "hash mismatch" }
  & $outFile
}

function Hash_UntrustedExpected($outFile, $expected, $usePinnedHash) {
  Invoke-WebRequest "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile # $ Alert
  if ($usePinnedHash) {
    $expected = "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df"
  }
  $hash = (Get-FileHash -Path $outFile).Hash
  if ($hash -ne $expected) { throw "hash mismatch" }
  & $outFile
}

function ComputeHash_StaleBytes($outFile) {
  $bytes = [System.IO.File]::ReadAllBytes($outFile)
  Invoke-WebRequest "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile # $ Alert
  $sha = [System.Security.Cryptography.SHA256]::Create()
  $hash = [System.Convert]::ToHexString($sha.ComputeHash($bytes))
  if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
  & $outFile
}

function Hash_Valid_BeforeUse($outFile) {
  Invoke-WebRequest "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile
  Write-Verbose "Downloaded $outFile"
  $hash = (Get-FileHash -Path $outFile).Hash.ToLowerInvariant()
  if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { exit 1 }
  & $outFile
}

function ComputeHash_Valid_HexString($outFile) {
  Invoke-WebRequest "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile
  $sha = [System.Security.Cryptography.SHA256]::Create()
  $hash = [System.Convert]::ToHexString($sha.ComputeHash([System.IO.File]::ReadAllBytes($outFile)))
  if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
  & $outFile
}

function ComputeHash_PartialBuffer($outFile) {
  Invoke-WebRequest "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile # $ Alert
  $bytes = [System.IO.File]::ReadAllBytes($outFile)
  $sha = [System.Security.Cryptography.SHA256]::Create()
  $hash = [System.Convert]::ToHexString($sha.ComputeHash($bytes, 0, 100))
  if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
  & $outFile
}

function Hash_Mismatch_Trapped($outFile) {
  trap { continue }
  Invoke-WebRequest "http://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile # $ Alert
  $hash = (Get-FileHash -Path $outFile).Hash
  if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
  & $outFile
}

# Strict origin and execution requirements.

function FixedHttps_Executed($outFile) {
  Invoke-WebRequest "https://downloads.example.com/app.exe" -OutFile $outFile
  & $outFile
}

function UnknownUrl_Executed($url, $outFile) {
  Invoke-WebRequest $url -OutFile $outFile
  & $outFile
}

function EnvironmentUrl_Executed($outFile) {
  Invoke-WebRequest $env:INSTALLER_URL -OutFile $outFile
  & $outFile
}

function RequestUrl_Executed([System.Net.HttpListenerRequest]$request, $outFile) {
  $url = $request.QueryString["download"]
  Invoke-WebRequest $url -OutFile $outFile # $ Alert
  & $outFile
}

function RequestUrl_PinnedHttps([System.Net.HttpListenerRequest]$request, $outFile) {
  $url = $request.QueryString["download"]
  if ($url -ne "https://downloads.example.com/app.exe") { throw "unexpected URL" }
  Invoke-WebRequest $url -OutFile $outFile
  & $outFile
}

function RequestUrl_OnlyInQuery([System.Net.HttpListenerRequest]$request, $outFile) {
  $tracking = $request.QueryString["tracking"]
  Invoke-WebRequest "https://downloads.example.com/app.exe?tracking=$tracking" -OutFile $outFile
  & $outFile
}

function Http_InQueryOnly($outFile) {
  Invoke-WebRequest "https://downloads.example.com/app.exe?mirror=http://elsewhere.example.com" -OutFile $outFile
  & $outFile
}

function Http_Interpolated($version, $outFile) {
  Invoke-WebRequest "HTTP://downloads.example.com/$version/app.exe" -OutFile $outFile # $ Alert
  & $outFile
}

function Http_DownloadOnly($outFile) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile
}

function Http_ConfigOnly($outFile) {
  Invoke-RestMethod "http://app.scm.azurewebsites.net/api/vfs/site/wwwroot/Config.js" -OutFile $outFile
  Get-Content $outFile
}

function Https_KuduExecutable($outFile) {
  Invoke-RestMethod "https://app.scm.azurewebsites.net/api/vfs/site/wwwroot/install.ps1" -OutFile $outFile
  & $outFile
}

function Http_KuduExecutable($outFile) {
  Invoke-RestMethod "http://app.scm.azurewebsites.net/api/vfs/site/wwwroot/install.ps1" -OutFile $outFile # $ Alert
  & $outFile
}

function Http_ApiExecutable($outFile) {
  Invoke-WebRequest "http://api.github.com/repos/example/project/releases/assets/123" -OutFile $outFile # $ Alert
  & $outFile
}

function StartProcess_Executable() {
  $file = "downloaded.exe"
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $file # $ Alert
  Start-Process -FilePath $file
}

function StartProcess_ExecutableChildPath() {
  $file = Join-Path $env:TEMP "downloaded.exe"
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $file # $ Alert
  Start-Process -FilePath $file
}

function StartProcess_VerifiedChildPath() {
  $file = Join-Path $env:TEMP "downloaded.exe"
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $file
  $hash = (Get-FileHash $file).Hash
  if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
  Start-Process -FilePath $file
}

function StartProcess_DataAssociation() {
  $file = "report.json"
  Invoke-WebRequest "http://downloads.example.com/report.json" -OutFile $file
  Start-Process -FilePath $file
}

function StartProcess_UnrelatedArgument($outFile) {
  Invoke-WebRequest "http://downloads.example.com/report.json" -OutFile $outFile
  Start-Process "notepad.exe" -ArgumentList $outFile
}

function StartProcess_InstallerPackage($outFile) {
  Invoke-WebRequest "http://downloads.example.com/app.msi" -OutFile $outFile # $ Alert
  Start-Process "msiexec.exe" -ArgumentList "/i", $outFile, "/qn"
}

function StartProcess_InstallerLog($outFile) {
  Invoke-WebRequest "http://downloads.example.com/app.msi" -OutFile $outFile
  Start-Process "msiexec.exe" -ArgumentList "/i", "local.msi", "/log", $outFile
}

function StartProcess_PowerShellFile($outFile) {
  Invoke-WebRequest "http://downloads.example.com/install.ps1" -OutFile $outFile # $ Alert
  Start-Process "pwsh" -ArgumentList "-NoProfile", "-File", $outFile
}

function Installer_ActualPackage($outFile) {
  Invoke-WebRequest "http://downloads.example.com/app.msi" -OutFile $outFile # $ Alert
  msiexec.exe /i $outFile /qn
}

function Installer_LogFileOnly($outFile) {
  Invoke-WebRequest "http://downloads.example.com/app.msi" -OutFile $outFile
  msiexec.exe /i "local.msi" /log $outFile
}

function ReadThenExecute($outFile) {
  Invoke-WebRequest "http://downloads.example.com/install.ps1" -OutFile $outFile # $ Alert
  Get-Content -Raw $outFile | Invoke-Expression
}

function BodyWrittenThenExecuted($outFile) {
  $body = Invoke-RestMethod "http://downloads.example.com/install.ps1" # $ Alert
  $body | Set-Content -Path $outFile
  . $outFile
}

function Assembly_Loaded($outFile) {
  Invoke-WebRequest "http://downloads.example.com/plugin.dll" -OutFile $outFile # $ Alert
  [System.Reflection.Assembly]::LoadFrom($outFile)
}

function WebClient_BytesLoaded() {
  $client = [System.Net.WebClient]::new()
  $bytes = $client.DownloadData("http://downloads.example.com/plugin.dll") # $ Alert
  [System.Reflection.Assembly]::Load($bytes)
}

function MovedThenExecuted($outFile, $moved) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile # $ Alert
  Move-Item $outFile -Destination $moved
  & $moved
}

function MovedOriginal_NotExecuted($outFile, $moved) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile
  Move-Item $outFile -Destination $moved
  & $outFile
}

function RenamedThenExecuted($outFile) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile # $ Alert
  $renamed = Rename-Item $outFile -NewName "renamed.exe" -PassThru
  & $renamed.FullName
}

function CopyNotVerifiedByChangedOriginal($outFile, $copy) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile # $ Alert
  Copy-Item $outFile -Destination $copy
  Set-Content $outFile "trusted replacement"
  $hash = (Get-FileHash $outFile).Hash
  if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
  & $copy
}

function CopyVerifiedByUnchangedOriginal($outFile, $copy) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile
  Copy-Item $outFile -Destination $copy
  $hash = (Get-FileHash $outFile).Hash
  if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
  & $copy
}

function CopyNotVerifiedByOptionallyChangedOriginal($outFile, $copy, $replace) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile # $ Alert
  Copy-Item $outFile -Destination $copy
  if ($replace) { Set-Content $outFile "trusted replacement" }
  $hash = (Get-FileHash $outFile).Hash
  if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
  & $copy
}

function Archive_ExtractionOnly($zip, $directory) {
  Invoke-WebRequest "http://downloads.example.com/app.zip" -OutFile $zip
  Expand-Archive $zip -DestinationPath $directory
}

function Archive_ExtractedCodeExecuted($zip, $directory) {
  Invoke-WebRequest "http://downloads.example.com/app.zip" -OutFile $zip # $ Alert
  Expand-Archive $zip -DestinationPath $directory
  $exe = Join-Path $directory "bin\app.exe"
  & $exe
}

function Archive_VerifiedBeforeExecution($zip, $directory) {
  Invoke-WebRequest "http://downloads.example.com/app.zip" -OutFile $zip
  $hash = (Get-FileHash $zip).Hash
  if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
  Expand-Archive $zip -DestinationPath $directory
  & (Join-Path $directory "app.exe")
}

function Archive_VerifiedMemberWithReconstructedPath($zip, $directory) {
  Invoke-WebRequest "http://downloads.example.com/app.zip" -OutFile $zip
  Expand-Archive $zip -DestinationPath $directory
  $hash = (Get-FileHash (Join-Path $directory "app.exe")).Hash
  if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
  & (Join-Path $directory "app.exe")
}

function Archive_DifferentMemberVerified($zip, $directory) {
  Invoke-WebRequest "http://downloads.example.com/app.zip" -OutFile $zip # $ Alert
  Expand-Archive $zip -DestinationPath $directory
  $hash = (Get-FileHash (Join-Path $directory "other.exe")).Hash
  if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
  & (Join-Path $directory "app.exe")
}

function FilePathSuffixIsNotDownloadedFile($outFile) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile
  & "$outFile.other.exe"
}

function OverwrittenBeforeExecution($outFile) {
  Invoke-WebRequest "http://downloads.example.com/install.ps1" -OutFile $outFile
  Set-Content $outFile "Write-Output 'local code'"
  & $outFile
}

function RedownloadedBeforeExecution($outFile) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile
  Invoke-WebRequest "https://downloads.example.com/app.exe" -OutFile $outFile
  & $outFile
}

function SeparateLiteralFileReferences() {
  Invoke-WebRequest "http://downloads.example.com/install.ps1" -OutFile "install.ps1" # $ Alert
  & "install.ps1"
}

function MutuallyExclusiveDownloadAndUse($condition, $outFile) {
  if ($condition) {
    Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile
  } else {
    & $outFile
  }
}

# Verification is a path property, not the presence of a check somewhere in a function.

function BothBranchesVerified($outFile, $condition) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile
  if ($condition) {
    $hash = (Get-FileHash $outFile).Hash
    if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
  } else {
    $hash = (Get-FileHash $outFile).Hash
    if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
  }
  & $outFile
}

function OnlyOneUseVerified($outFile) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile # $ Alert
  & $outFile
  $hash = (Get-FileHash $outFile).Hash
  if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
  & $outFile
}

function ReadBeforeValidatingSameFile($outFile) {
  Invoke-WebRequest "http://downloads.example.com/install.ps1" -OutFile $outFile
  $script = Get-Content -Raw $outFile
  $hash = (Get-FileHash $outFile).Hash
  if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { throw "hash mismatch" }
  Invoke-Expression $script
}

function Signature_ExpectedPublisher($outFile) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile
  $sig = Get-AuthenticodeSignature -FilePath $outFile
  if ($sig.Status -ne "Valid") { throw "bad signature" }
  if ($sig.SignerCertificate.Thumbprint -ne "0123456789ABCDEF0123456789ABCDEF01234567") { throw "wrong publisher" }
  & $outFile
}

function Signature_ExpectedPublisherCombinedGuard($outFile) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile
  $sig = Get-AuthenticodeSignature -FilePath $outFile
  if ($sig.Status -ne "Valid" -or $sig.SignerCertificate.Thumbprint -ne "0123456789ABCDEF0123456789ABCDEF01234567") {
    throw "invalid or unexpected signer"
  }
  & $outFile
}

function Signature_IgnoredFailure($outFile) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile # $ Alert
  $sig = Get-AuthenticodeSignature -FilePath $outFile
  if ($sig.Status -ne "Valid") { Write-Warning "bad signature" }
  if ($sig.SignerCertificate.Thumbprint -ne "0123456789ABCDEF0123456789ABCDEF01234567") { Write-Warning "wrong publisher" }
  & $outFile
}

function Signature_GpgExpectedSigner($outFile) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile
  gpg --assert-signer "0123456789ABCDEF0123456789ABCDEF01234567" --verify "$outFile.sig" $outFile
  if ($LASTEXITCODE -ne 0) { throw "bad signature" }
  & $outFile
}

function Signature_CosignExpectedIdentity($outFile) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile
  cosign verify-blob $outFile --bundle "$outFile.sigstore.json" --certificate-identity "release@example.com" --certificate-oidc-issuer "https://accounts.google.com"
  if ($LASTEXITCODE -ne 0) { throw "bad signature" }
  & $outFile
}

function Signature_GpgUnexpectedSigner($outFile) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile # $ Alert
  gpg --verify "$outFile.sig" $outFile
  if ($LASTEXITCODE -ne 0) { throw "bad signature" }
  & $outFile
}

function Signature_CosignIgnoredFailure($outFile) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile # $ Alert
  cosign verify-blob $outFile --bundle "$outFile.sigstore.json" --certificate-identity "release@example.com" --certificate-oidc-issuer "https://accounts.google.com"
  if ($LASTEXITCODE -ne 0) { Write-Warning "bad signature" }
  & $outFile
}

function Signature_GpgOtherExitCode($outFile) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile # $ Alert
  gpg --assert-signer "0123456789ABCDEF0123456789ABCDEF01234567" --verify "$outFile.sig" $outFile
  cmd.exe /c "exit 0"
  if ($LASTEXITCODE -ne 0) { throw "bad signature" }
  & $outFile
}

function Signature_GpgOverwrittenExitCode($outFile) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile # $ Alert
  gpg --assert-signer "0123456789ABCDEF0123456789ABCDEF01234567" --verify "$outFile.sig" $outFile
  $LASTEXITCODE = 0
  if ($LASTEXITCODE -ne 0) { throw "bad signature" }
  & $outFile
}

function Signature_GpgWrongFile($outFile, $other) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile # $ Alert
  gpg --assert-signer "0123456789ABCDEF0123456789ABCDEF01234567" --verify "$other.sig" $other
  if ($LASTEXITCODE -ne 0) { throw "bad signature" }
  & $outFile
}

function Signature_GpgAdditionalSigner($outFile) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile # $ Alert
  gpg --assert-signer "0123456789ABCDEF0123456789ABCDEF01234567" "--assert-signer=89ABCDEF0123456789ABCDEF0123456789ABCDEF" --verify "$outFile.sig" $outFile
  if ($LASTEXITCODE -ne 0) { throw "bad signature" }
  & $outFile
}

function HttpClient_ResponseExecuted() {
  $client = [System.Net.Http.HttpClient]::new()
  $script = $client.GetStringAsync("http://downloads.example.com/install.ps1").Result # $ Alert
  & ([ScriptBlock]::Create($script))
}

function ResponseIsNotCallerControl($outFile) {
  $client = [System.Net.WebClient]::new()
  $url = $client.DownloadString("https://downloads.example.com/latest-url")
  Invoke-WebRequest $url -OutFile $outFile
  & $outFile
}

function ReturnedTextIsNotAScriptBlock() {
  $text = Invoke-RestMethod "http://downloads.example.com/script.txt"
  # A string passed to & is a command name, not PowerShell source text.
  & $text
}

function Hash_CombinedFailClosed($outFile, $otherFailure) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile
  $hash = (Get-FileHash $outFile).Hash
  if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df" -or $otherFailure) {
    throw "verification failed"
  }
  & $outFile
}

function Hash_CombinedBypass($outFile, $verify) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile # $ Alert
  $hash = (Get-FileHash $outFile).Hash
  if ($hash -ne "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df" -and $verify) {
    throw "verification failed"
  }
  & $outFile
}

function Hash_ComparisonWithoutEnforcement($outFile) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile # $ Alert
  $hash = (Get-FileHash $outFile).Hash
  if ($hash -eq "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df") { }
  & $outFile
}

function Hash_NegatedEquality($outFile) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile
  $hash = (Get-FileHash $outFile).Hash
  if (-not ($hash -eq "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df")) {
    throw "verification failed"
  }
  & $outFile
}

function Signature_CombinedBypass($outFile) {
  Invoke-WebRequest "http://downloads.example.com/app.exe" -OutFile $outFile # $ Alert
  $sig = Get-AuthenticodeSignature -FilePath $outFile
  if ($sig.Status -ne "Valid" -and $sig.SignerCertificate.Thumbprint -ne "0123456789ABCDEF0123456789ABCDEF01234567") {
    throw "invalid or unexpected signer"
  }
  & $outFile
}
