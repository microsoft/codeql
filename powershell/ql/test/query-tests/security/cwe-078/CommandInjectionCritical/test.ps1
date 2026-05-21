# CmdletBinding param flows to Invoke-Expression
function Invoke-InvokeExpressionInjectionCmdletBinding
{
    [CmdletBinding()]
    param($UserInput) # $ Source
    Invoke-Expression "Get-Process -Name $UserInput" # $ Alert
}

# CmdletBinding param flows directly to dot-source operator
function Invoke-DotSourceDirect
{
    [CmdletBinding()]
    param($ScriptPath) # $ Source
    . $ScriptPath # $ Alert
}

# CmdletBinding param flows through a variable to dot-source operator
function Invoke-DotSourceIndirect
{
    [CmdletBinding()]
    param($ScriptPath) # $ Source
    $path = $ScriptPath
    . $path # $ Alert
}

# CmdletBinding param flows to Invoke-Expression (not dot-source)
function Invoke-InvokeExpressionCmdletBinding
{
    [CmdletBinding()]
    param($UserInput) # $ Source
    Invoke-Expression "Get-Process -Name $UserInput" # $ Alert
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

# FP filtered: CmdletBinding param does NOT flow to the dot-sourced expression.
# The param is in scope but a hardcoded path is dot-sourced instead.
function Invoke-DotSourceNoFlow
{
    [CmdletBinding()]
    param($UserInput) # $ Source
    Invoke-Expression "Get-Process -Name $UserInput" # $ Alert
    . "C:\safe\script.ps1" # GOOD - hardcoded, param doesn't flow here
}
