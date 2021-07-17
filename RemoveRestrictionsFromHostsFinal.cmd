@echo off
net file 1>nul 2>nul
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 & popd
    exit /b
)
cd /d %1
ICACLS "%SystemRoot%\system32\drivers\etc" /INHERITANCE:e /GRANT:r %USERNAME%:(F) /T /C
PUSHD %SystemRoot%\system32\drivers\etc && ATTRIB -R -A -H -S hosts && POPD
EXIT /B 0
