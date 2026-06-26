# CWE-494 - Download of a GitHub release artifact without an integrity check.
#
# Each function below is one download idiom. It documents, as inline
# expectations, which idioms the query catches and which it still misses:
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
  # BAD - baseline; download from github with no hash check.
  $uri = "https://github.com/example/project/releases/download/v1.2.3/installer.exe"
  Invoke-WebRequest -Uri $uri -OutFile $outFile # $ Alert
}

function Iwr_NamedUri_OutFile_Hashed($outFile) {
  # GOOD - Get-FileHash barrier on the downloaded file (correctly NOT flagged).
  $uri = "https://github.com/example/project/releases/download/v1.2.3/installer.exe"
  $expected = "8c954cd9b6c8f8180a05f1de66ee555f0c44b4c6738120785d827521bb8d54df"
  Invoke-WebRequest -Uri $uri -OutFile $outFile
  $actual = (Get-FileHash -Path $outFile -Algorithm SHA256).Hash
  if ($actual -ne $expected) { Remove-Item $outFile -Force; throw "hash mismatch" }
}

# ---------------------------------------------------------------------------
# MISSING: argument-shape variants of Invoke-WebRequest / Invoke-RestMethod.
# ---------------------------------------------------------------------------

function Iwr_PositionalUri($outFile) {
  # BAD - URL passed positionally, not as -Uri.
  Invoke-WebRequest "https://github.com/example/project/releases/download/v1/app.exe" -OutFile $outFile # $ Alert
}

function Iwr_Alias_Positional($outFile) {
  # BAD - iwr alias + positional URL.
  iwr "https://github.com/example/project/releases/download/v1/app.zip" -OutFile $outFile # $ Alert
}

function Iwr_NoOutFile_PipedToIex() {
  # BAD - no -OutFile; content executed inline.
  $r = Invoke-WebRequest -Uri "https://github.com/example/project/releases/download/v1/bootstrap.ps1" # $ Alert
  Invoke-Expression $r.Content
}

function Irm_NoOutFile() {
  # BAD - Invoke-RestMethod returns content, no -OutFile.
  irm "https://github.com/example/project/releases/download/v1/install.ps1" | Invoke-Expression # $ Alert
}

# ---------------------------------------------------------------------------
# MISSING: download sinks that are not in the cmdlet name list at all.
# ---------------------------------------------------------------------------

function WebClient_DownloadFile($outFile) {
  # BAD - System.Net.WebClient.DownloadFile.
  $wc = New-Object System.Net.WebClient
  $wc.DownloadFile("https://github.com/example/project/releases/download/v1/app.exe", $outFile) # $ Alert
}

function WebClient_Inline($outFile) {
  # BAD - inline (New-Object Net.WebClient).DownloadFile(...).
  (New-Object Net.WebClient).DownloadFile("https://github.com/example/project/releases/download/v1/app.exe", $outFile) # $ Alert
}

function Bits_Transfer($outFile) {
  # BAD - Start-BitsTransfer.
  Start-BitsTransfer -Source "https://github.com/example/project/releases/download/v1/app.exe" -Destination $outFile # $ Alert
}

function Curl_Native($outFile) {
  # BAD - native curl with -o.
  curl -sL "https://github.com/example/project/releases/download/v1/app.tar.gz" -o $outFile # $ Alert
}

function Wget_Native() {
  # BAD - native wget piped to tar (no output file at all).
  wget "https://github.com/example/project/releases/download/v1/app.tar.gz" # $ Alert
}

function AzCopy($outFile) {
  # BAD - azcopy / aria2c.
  azcopy copy "https://github.com/Azure/azure-storage-azcopy/releases/download/v10.31.0/azcopy.zip" $outFile # $ Alert
}

function Wrapper_Function($outFile) {
  # BAD - custom download wrapper; the real Invoke-WebRequest lives in a
  # dot-sourced helper.
  Download-File "https://github.com/example/project/releases/download/v1/app.exe" $outFile # $ MISSING: Alert
}

# ---------------------------------------------------------------------------
# Verified by means other than Get-FileHash - should NOT be flagged.
# ---------------------------------------------------------------------------

function Verified_With_CertUtil($outFile) {
  # GOOD - certutil hash verification (now recognised as an integrity barrier).
  $uri = "https://github.com/example/project/releases/download/v1/app.exe"
  Invoke-WebRequest -Uri $uri -OutFile $outFile
  $h = certutil -hashfile $outFile SHA256
  if ($h -notmatch "ABC123") { throw "hash mismatch" }
}

# ---------------------------------------------------------------------------
# TRUE NEGATIVES: these must NOT be flagged. Either the download is verified,
# or it is not a trusted-host artifact download at all. No inline expectation
# means "no alert expected here".
# ---------------------------------------------------------------------------

function Verified_With_ComputeHash($outFile) {
  # GOOD - hash computed via [SHA256]::Create().ComputeHash over the bytes read
  # from the downloaded file, then compared.
  $uri = "https://github.com/example/project/releases/download/v1/app.exe"
  Invoke-WebRequest -Uri $uri -OutFile $outFile
  $sha = [System.Security.Cryptography.SHA256]::Create()
  $bytes = [System.IO.File]::ReadAllBytes($outFile)
  $hash = [System.BitConverter]::ToString($sha.ComputeHash($bytes)).Replace("-", "")
  if ($hash -ne "ABC123") { throw "hash mismatch" }
}

function Verified_With_Signature($outFile) {
  # GOOD - Authenticode signature check on the downloaded file.
  $uri = "https://github.com/example/project/releases/download/v1/app.exe"
  Invoke-WebRequest -Uri $uri -OutFile $outFile
  $sig = Get-AuthenticodeSignature -FilePath $outFile
  if ($sig.Status -ne "Valid") { throw "bad signature" }
}

function Verified_With_Cosign($outFile) {
  # GOOD - external signature verification via cosign.
  $uri = "https://github.com/example/project/releases/download/v1/app.tar.gz"
  Invoke-WebRequest -Uri $uri -OutFile $outFile
  cosign verify-blob --signature "$outFile.sig" $outFile
}

function NonArtifact_Host($outFile) {
  # GOOD - download from a host that is not a recognised artifact host.
  Invoke-WebRequest -Uri "https://example.com/data/report.json" -OutFile $outFile
}

function GitHub_Api_DataOnly() {
  # GOOD - a GitHub API metadata call, not an artifact download. The response is
  # only inspected, never written to disk or executed.
  $r = Invoke-RestMethod -Uri "https://api.github.com/repos/example/project/releases/latest"
  return $r.tag_name
}

function Local_Copy($outFile) {
  # GOOD - copying a local file; no network download, no trusted-host URL.
  Copy-Item -Path "C:\artifacts\app.exe" -Destination $outFile
}
