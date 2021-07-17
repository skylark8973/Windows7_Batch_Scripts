@echo off
net file 1>NUL 2>NUL
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 & popd
    exit /b
)
cd /d %1
tasklist /fi "ImageName eq CCleaner64.exe" /fo csv 2>NUL | find /I "CCleaner64.exe">NUL
if not "%ERRORLEVEL%"=="0" taskkill /f /t /im CCleaner64.exe