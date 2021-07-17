$ScriptFolder = $PSScriptRoot
$ScriptDir = Split-Path $MyInvocation.MyCommand.Path

if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
        Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
        Exit
    }
}
Set-Location $ScriptDir; Echo 'Current Directory: ' + (Get-Location | Out-String)
Function Stop-UserProcesses{
    Param([string]$Computer = "localhost")
    $Cred = Get-Credential
    Invoke-Command -ComputerName $Computer -Credential $Cred -ScriptBlock {
        Get-Process -IncludeUserName | Where{!($_.UserName -match "NT AUTHORITY\\(?:SYSTEM|(?:LOCAL|NETWORK) SERVICE)") -and !($_.ProcessName -eq "explorer")}|Stop-Process -WhatIf
    }
}
Stop-UserProcesses
