param (
    [Parameter(Mandatory=$true)][string]$cliFolder
)

# Mirrors the PowerShell extractor's build scripts: publish the extractor into the CLI's
# language folder, then copy the extractor configuration, dbscheme and tool scripts alongside.
#
# The X++ compiler package is proprietary and is not bundled. The extractor resolves it at run
# time from XPP_COMPILER_PACKAGE, which must be set wherever extraction happens.

$toolsFolder = Join-Path (Join-Path (Join-Path $cliFolder "xpp") "tools") "linux64"
# Only the extractor is shipped. Xpp.SchemaGenerator is a build-time tool and comes in
# through the solution, so the project is published rather than the solution.
dotnet publish (Join-Path "$PSScriptRoot/extractor" "Xpp.Extractor" | Resolve-Path) -o $toolsFolder -r linux-x64 -c Release --self-contained
if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed"
    exit 1
}

$xppFolder = Join-Path -Path $cliFolder -ChildPath "xpp"
Copy-Item -Path "$PSScriptRoot/codeql-extractor.yml" -Destination $xppFolder -Force
$qlLibFolder = Join-Path -Path "$PSScriptRoot/ql" -ChildPath "lib"
Copy-Item -Path (Join-Path $qlLibFolder "xpp.dbscheme") -Destination $xppFolder -Force
Copy-Item -Path (Join-Path $qlLibFolder "xpp.dbscheme.stats") -Destination $xppFolder -Force
Copy-Item -Path "$PSScriptRoot/tools" -Destination $xppFolder -Recurse -Force
