@echo off
net file 1>nul 2>nul
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 & popd
    exit /b
)
cd /d %1
for /F "tokens=3 delims=: " %%H in ('sc query wuauserv ^| findstr "        STATE"') do (
	if /I "%%H" NEQ "RUNNING" ( goto :EnableWindowsUpdates ) else ( goto :DisableWindowsUpdates )
)
:EnableWindowsUpdates
sc config wuauserv start= auto && net start wuauserv && goto :eof
:DisableWindowsUpdates
sc config wuauserv start= demand && net stop wuauserv && goto :eof
