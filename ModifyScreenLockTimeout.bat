@echo off
net file 1>NUL 2>NUL
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 & popd
    exit /b
)
cd /d %1
:: powercfg.exe /SETDCVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK 1800
:: powercfg.exe /SETACTIVE SCHEME_CURRENT
powercfg.exe /SETDCVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK 1800 && powercfg.exe /SETACTIVE SCHEME_CURRENT