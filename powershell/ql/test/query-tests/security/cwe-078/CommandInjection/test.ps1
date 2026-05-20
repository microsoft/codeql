function Invoke-InvokeExpressionInjection1
{
    param($UserInput)
    Invoke-Expression "Get-Process -Name $UserInput" # $ Alert
}

function Invoke-InvokeExpressionInjection2
{
    param($UserInput)
    iex "Get-Process -Name $UserInput" # $ Alert
}

function Invoke-InvokeExpressionInjection3
{
    param($UserInput)
    $executionContext.InvokeCommand.InvokeScript("Get-Process -Name $UserInput") # $ Alert
}

function Invoke-InvokeExpressionInjection4
{
    param($UserInput)
    $host.Runspace.CreateNestedPipeline("Get-Process -Name $UserInput", $false).Invoke() # $ Alert
}

function Invoke-InvokeExpressionInjection5
{
    param($UserInput)
    [PowerShell]::Create().AddScript("Get-Process -Name $UserInput").Invoke() # $ Alert
}

function Invoke-InvokeExpressionInjection6
{
    param($UserInput)
    Add-Type "public class Foo { $UserInput }" # $ Alert
}

function Invoke-InvokeExpressionInjection7
{
    param($UserInput)
    Add-Type -TypeDefinition "public class Foo { $UserInput }" # $ Alert
}

function Invoke-InvokeExpressionInjection8
{
    param($UserInput)

    $code = "public class Foo { $UserInput }"
    Add-Type -TypeDefinition $code # $ Alert
}

function Invoke-InvokeExpressionInjectionFP
{
    param($UserInput)

    $code = @"
    public class BasicTest
    {
      public static int Add(int a, int b)
        {
            return (a + b);
        }
      public int Multiply(int a, int b)
        {
        return (a * b);
        }
    }
"@
    Add-Type -TypeDefinition $code
}

function Invoke-ExploitableCommandInjection1
{
    param($UserInput)

    powershell -command "Get-Process -Name $UserInput" # $ Alert
}

function Invoke-ExploitableCommandInjection2
{
    param($UserInput)

    powershell "Get-Process -Name $UserInput" # $ Alert
}

function Invoke-ExploitableCommandInjection3
{
    param($UserInput)

    cmd /c "ping $UserInput" # $ Alert
}

function Invoke-ScriptBlockInjection1
{
    param($UserInput)

    ## Often used when making remote connections

    $sb = [ScriptBlock]::Create("Get-Process -Name $UserInput") # $ Alert
    Invoke-Command RemoteServer $sb
}

function Invoke-ScriptBlockInjection2
{
    param($UserInput)

    ## Often used when making remote connections

    $sb = $executionContext.InvokeCommand.NewScriptBlock("Get-Process -Name $UserInput") # $ Alert
    Invoke-Command RemoteServer $sb
}

function Invoke-MethodInjection1
{
    param($UserInput)

    Get-Process | Foreach-Object $UserInput # $ Alert
}

function Invoke-MethodInjection2
{
    param($UserInput)

    (Get-Process -Id $pid).$UserInput() # $ Alert
}


function Invoke-MethodInjection3
{
    param($UserInput)

    (Get-Process -Id $pid).$UserInput.Invoke() # $ Alert
}

function Invoke-ExpandStringInjection1
{
    param($UserInput)

    ## Used to attempt a variable resolution
    $executionContext.InvokeCommand.ExpandString($UserInput) # $ Alert
}

function Invoke-ExpandStringInjection2
{
    param($UserInput)

    ## Used to attempt a variable resolution
    $executionContext.SessionState.InvokeCommand.ExpandString($UserInput) # $ Alert
}

function Invoke-InvokeExpressionInjectionCmdletBinding
{
    [CmdletBinding()]
    param($UserInput)
    Invoke-Expression "Get-Process -Name $UserInput" # $ Alert
}

function Invoke-StartProcessInjection
{
    param($UserInput)
    Start-Process -FilePath $UserInput # $ Alert
}


$input = Read-Host "enter input" # $ Source

Invoke-InvokeExpressionInjection1 -UserInput $input  
Invoke-InvokeExpressionInjection2 -UserInput $input  
Invoke-InvokeExpressionInjection3 -UserInput $input  
Invoke-InvokeExpressionInjection4 -UserInput $input  
Invoke-InvokeExpressionInjection5 -UserInput $input  
Invoke-InvokeExpressionInjection6 -UserInput $input  
Invoke-InvokeExpressionInjection7 -UserInput $input  
Invoke-InvokeExpressionInjection8 -UserInput $input  
Invoke-InvokeExpressionInjectionFP -UserInput $input  
Invoke-ExploitableCommandInjection1 -UserInput $input  
Invoke-ExploitableCommandInjection2 -UserInput $input  
Invoke-ExploitableCommandInjection3 -UserInput $input   
Invoke-ScriptBlockInjection1 -UserInput $input  
Invoke-ScriptBlockInjection2 -UserInput $input  
Invoke-MethodInjection1 -UserInput $input  
Invoke-MethodInjection2 -UserInput $input  
Invoke-MethodInjection3 -UserInput $input  
Invoke-PropertyInjection -UserInput $input  
Invoke-ExpandStringInjection1 -UserInput $input  
Invoke-ExpandStringInjection2 -UserInput $input
Invoke-InvokeExpressionInjectionCmdletBinding -userInput $input
Invoke-StartProcessInjection -UserInput $input

function Get-NugetHardcoded
{
    Invoke-WebRequest "https://somehardcodedwebsite.org/somefile.exe" -OutFile $webRequestResultSafe
    return $webRequestResultSafe
}

$nugetPathSafe = Get-NugetHardcoded
. $nugetPathSafe

#typed input
function Invoke-InvokeExpressionInjectionSafe1
{
    param([int] $UserInput)
    Invoke-Expression "Get-Process -Name $UserInput"
}

#single quotes to treat them as string literal
function Invoke-InvokeExpressionInjectionSafe2
{
    param($UserInput)
    Invoke-Expression "Get-Process -Name '$UserInput'"
}
#EscapeSingleQuotedStringContent API
function Invoke-InvokeExpressionInjectionSafe3
{
    param([int] $UserInput)

    $UserInputClean = [System.Management.Automation.Language.CodeGeneration]::
        EscapeSingleQuotedStringContent("$UserInput")
    Invoke-Expression "Get-Process -Name $UserInputClean"
}

#EscapeSingleQuotedStringContent API 2
function Invoke-InvokeExpressionInjectionSafe4
{
    param([int] $UserInput)

    $UserInputClean = [System.Management.Automation.Language.CodeGeneration]::EscapeSingleQuotedStringContent("$UserInput")
    Invoke-Expression "Get-Process -Name $UserInputClean"
}

#ValidatePattern Attribute
function Invoke-InvokeExpressionInjectionSafe5
{
    param(
        [ValidateScript({
            if ($_ -eq "GoodValue") {
                $true
            } else {
                throw "$_ is invalid."
            }
        })]
        $UserInput
    )
    Invoke-Expression "Get-Process -Name $UserInput"
}

Invoke-InvokeExpressionInjectionSafe1 -UserInput $input 
Invoke-InvokeExpressionInjectionSafe2 -UserInput $input 
Invoke-InvokeExpressionInjectionSafe3 -UserInput $input 
Invoke-InvokeExpressionInjectionSafe4 -UserInput $input 
Invoke-InvokeExpressionInjectionSafe5 -UserInput $input 

function false-positive-in-call-operator($d)
{
    $o = Read-Host "enter input" # $ Source
    & unzip -o "$o" -d $d # GOOD

    . "$o" # $ Alert
}

function flow-through-env-var() {
    $x = $env:foo

    . "$x" # GOOD # we don't consider environment vars flow sources

    $input = Read-Host "enter input" # $ Source
    $env:bar = $input

    $y = $env:bar
    . "$y" # $ Alert # but we have flow through them
}

# isDotSourceSink test cases for CommandInjectionCritical

# isDotSourceSink test cases for CommandInjectionCritical
# (These use CmdletBinding params as sources, not Read-Host, so they only
# apply to the CommandInjectionCritical query, not the general CommandInjection query.)

# TP: CmdletBinding param flows directly to dot-source operator
function Invoke-DotSourceDirect
{
    [CmdletBinding()]
    param($ScriptPath)
    . $ScriptPath # CriticalAlert
}

# TP: CmdletBinding param flows through a variable to dot-source operator
function Invoke-DotSourceIndirect
{
    [CmdletBinding()]
    param($ScriptPath)
    $path = $ScriptPath
    . $path # CriticalAlert
}

# FP filtered: CmdletBinding param does NOT flow to the dot-sourced expression.
# The param is in scope but a hardcoded path is dot-sourced instead.
function Invoke-DotSourceNoFlow
{
    [CmdletBinding()]
    param($UserInput)
    Invoke-Expression "Get-Process -Name $UserInput" # CriticalAlert (Invoke-Expression, not dot-source)
    . "C:\safe\script.ps1" # GOOD - hardcoded, param doesn't flow here
}

# FP filtered: CmdletBinding param used elsewhere, unrelated dot-source of different variable
function Invoke-DotSourceUnrelatedParam
{
    [CmdletBinding()]
    param($UserInput)
    Write-Host $UserInput
    $safePath = "C:\scripts\helper.ps1"
    . $safePath # GOOD - param doesn't flow to dot-source
}