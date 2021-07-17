<# :
@echo off & setlocal
set "POWERSHELL_BAT_ARGS=%*"
net file 1>nul 2>nul
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 & popd
    exit /b
)
cd /d %1
set DSTNFLDR="%ProgramData%\Microsoft\Windows Defender\Scans"
ICACLS %DSTNFLDR% /INHERITANCE:e /GRANT:r %USERNAME%:(F) /T /C && DEL /S /F /Q %DSTNFLDR%\mpcache*
ICACLS %DSTNFLDR%\History /INHERITANCE:e /GRANT:r %USERNAME%:(F) /T /C && DEL /S /F /Q %DSTNFLDR%\History\*
net stop wsearch
reg add "HKLM\SOFTWARE\Microsoft\Windows Search" /v SetupCompletedSuccessfully /t REG_DWORD /d 0 /f
del /f /q "%ProgramData%\Microsoft\Search\Data\Applications\Windows\Windows.edb"
for /f %%i in ('dir /a:d /s /b %SystemRoot%\SystemApps\Microsoft.Windows.Search*') do set MscWndsSrch="%%i"
ICACLS %MscWndsSrch% /INHERITANCE:e /GRANT:r %USERNAME%:(F) /T /C
del /q /f /s "%MscWndsSrch%\cache\*" && del /q /f /s "%MscWndsSrch%\cache\*.*"
powershell -NoProfile -NoLogo "iex (${%~f0} | out-string)"
pause>nul && net start wsearch
#>

$POWERSHELL_BAT_ARGS=$env:POWERSHELL_BAT_ARGS
Write-Host $POWERSHELL_BAT_ARGS
$ACL = Get-ACL $Env:SystemRoot\SystemApps\Microsoft.Windows.Search*
$Group = New-Object System.Security.Principal.NTAccount("Builtin", "Administrators")
$ACL.SetOwner($Group)
$AR = New-Object System.Security.AccessControl.FileSystemAccessRule("$(whoami)", "FullControl", "Allow")
$ACL.SetAccessRule($AR)
Set-Acl -Path $Env:SystemRoot\SystemApps\Microsoft.Windows.Search* -AclObject $ACL
Remove-Item -Recurse -Force $Env:SystemRoot\SystemApps\Microsoft.Windows.Search*\cache\*
# $user = whoami; Get-WMIObject Win32_UserAccount | where caption -eq $user | select FullName
