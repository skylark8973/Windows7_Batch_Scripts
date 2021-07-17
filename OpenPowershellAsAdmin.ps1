# Executable: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
# Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force;
# Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force;
# Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force;

$invocation = (Get-Variable MyInvocation).Value
$ScptPath = Split-Path $invocation.MyCommand.Path
# Get-Location
Start-Process powershell.exe -verb runAs -ArgumentList '-NoExit', '-Command', "cd $ScptPath"