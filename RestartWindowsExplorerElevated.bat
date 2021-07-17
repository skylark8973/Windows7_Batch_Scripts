@echo off
net file 1>nul 2>nul
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 & popd
    exit /b
)
cd /d %1
FOR /F "TOKENS=*" %%1 IN ('wevtutil.exe el') DO wevtutil.exe cl "%%1"
taskkill /F /IM explorer.exe & start explorer
