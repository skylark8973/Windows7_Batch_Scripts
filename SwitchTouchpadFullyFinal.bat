@echo off
net file 1>NUL 2>NUL
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 & popd
    exit /b
)
cd /d %1
devcon status "*ELAN0625" | find "running" >nul && set "status=running" || set "status=disabled"
:: @echo on && echo %status% && @echo off
if "%status%" == "running" ( devcon disable "*ELAN0625" ) else ( devcon enable "*ELAN0625" )
pause>nul && exit /b
