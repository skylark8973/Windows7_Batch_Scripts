<# ::
@echo off
net file 1>nul 2>nul
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 & popd
    exit /b
)
cd /d %1

:: takeown /F %SystemRoot%\system32\drivers\etc /U %USERNAME% /R /D Y
:: icacls "%SystemRoot%\system32\drivers\etc" /setowner "%USERNAME%" /T /C
:: attrib -r -a -h -s %SystemRoot%\system32\drivers\etc\hosts
ICACLS "%SystemRoot%\system32\drivers\etc" /INHERITANCE:e /GRANT:r %USERNAME%:(F) /T /C
pushd %SystemRoot%\system32\drivers\etc && attrib -r -a -h -s hosts && popd
pause>nul
