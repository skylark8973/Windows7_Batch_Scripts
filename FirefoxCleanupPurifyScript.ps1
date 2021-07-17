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

Function Run-FirefoxCleanup {
    Param
    (
        [string] $user = $env:USERNAME,
        [string] $appData = $env:APPDATA,
        [string] $localAppData = $env:LOCALAPPDATA,
        [string] $ffProfilesDir = "$($localAppData)\Mozilla\Firefox\Profiles",
        [string] $ffMainProfileDir = (GCI -Path $ffProfilesDir -Directory | Select -F 1 -Expand FullName)
    )
    if((Test-Path $ffMainProfileDir))
    {
        $maybeCachePaths = @('cache2','thumbnails','startupCache','jumpListCache')
        ForEach($cachePath in $maybeCachePaths)
        {
            Remove-Item "$($ffMainProfileDir)\$($cachePath)\*" -Recurse -Force;
            Remove-Item "$($ffMainProfileDir)\$($cachePath)\*" -Recurse -Force;
        }
    }
}
Run-FirefoxCleanup;Read-Host
