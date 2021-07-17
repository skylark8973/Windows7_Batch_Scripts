if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}
$application = Get-WmiObject -Class Win32_Product -Filter "Name = 'Node.js'"
$application.Uninstall()
Echo "$Env:UserProfile\Downloads\node-v16.4.2-x64.msi"
Start-Process "$Env:UserProfile\Downloads\node-v16.4.2-x64.msi"

# $arguments = "/i `"$webDeployInstallerFilePath`" /quiet"
# Start-Process msiexec.exe -ArgumentList $arguments -Wait

# param([switch]$Elevated)

# function Test-Admin {
#     $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
#     $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
# }

# if ((Test-Admin) -eq $false)  {
#     if ($elevated) {
#         # tried to elevate, did not work, aborting
#     } else {
#         Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
#     }
#     exit
# }

# 'running with full privileges'
