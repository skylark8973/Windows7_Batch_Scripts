@echo off
SETLOCAL ENABLEDELAYEDEXPANSION ENABLEEXTENSIONS
net file 1>NUL 2>NUL
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 & popd
    exit /b
)
cd /d %1
::TASKKILL.EXE /F /T /FI "USERNAME EQ %USERNAME%" /FI "IMAGENAME NE Explorer.exe" ^
::/FI "IMAGENAME NE cmd.exe" /FI "IMAGENAME NE conhost.exe"
::TASKKILL.EXE /F /T /FI "USERNAME EQ %USERNAME%" /FI "IMAGENAME NE Explorer.exe" ^
::/FI "IMAGENAME NE AnyDesk.exe" /FI "IMAGENAME NE cmd.exe" /FI "IMAGENAME NE conhost.exe"

:: TASKKILL.EXE /F /T /FI "USERNAME NE SYSTEM" /FI "USERNAME NE NETWORK\ SERVICE" /FI "IMAGENAME NE Explorer.exe" ^
:: /FI "IMAGENAME NE AnyDesk.exe" /FI "IMAGENAME NE cmd.exe" /FI "IMAGENAME NE conhost.exe"
:: TASKKILL.EXE /F /T /FI "USERNAME EQ NT AUTHORITY\LOCAL SERVICE"
TASKKILL.EXE /F /T /FI "USERNAME EQ %USERNAME%" /FI "IMAGENAME NE cmd.exe" /FI "IMAGENAME NE conhost.exe"
