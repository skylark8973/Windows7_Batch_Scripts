@echo off
SETLOCAL ENABLEDELAYEDEXPANSION ENABLEEXTENSIONS
net file 1>NUL 2>NUL
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 & popd
    exit /b
)
cd /d %1 && set SrvNm=ClickToRunSvc && set SvcNm=ClickToRunSvc && set SrvcNm=ClickToRunSvc
sc config %SrvNm% start= disabled && net stop %SrvNm% && sc stop %SrvNm%
taskkill /f /t /im OfficeClickToRun.exe /im TextInputHost.exe
sc config %SrvNm% start= auto && net start %SrvNm% && sc start %SrvNm%
exit /b 0
