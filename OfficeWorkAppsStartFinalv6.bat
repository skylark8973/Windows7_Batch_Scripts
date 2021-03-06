@echo off
net file 1>nul 2>nul
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 & popd
    exit /b
)
cd /d %1

SETLOCAL ENABLEDELAYEDEXPANSION ENABLEEXTENSIONS

SET CCleanerExc="%ProgramFiles%\CCleaner\CCleaner64.exe"
CD /D %LOCALAPPDATA%\Microsoft\OneDrive && OneDrive.exe /SHUTDOWN
FOR /L %%X IN (1,1,10) DO ( TASKKILL /F /IM Chrome.exe /IM chrome_proxy.exe /IM GoogleCrashHandler.exe /IM GoogleCrashHandler64.exe /T )
!CCleanerExc! /Auto && !CCleanerExc! /Auto && !CCleanerExc! /Registry && TIMEOUT /T -1 && TASKKILL /F /IM Ccleaner64.exe /T
TAKEOWN /F %SystemRoot%\System32\WaaSMedicSvc.dll
NET STOP WaaSMedicSvc & NET STOP wuauserv & SC STOP WaaSMedicSvc & SC STOP wuauserv
TAKEOWN /F %WinDir%\Logs /A /R && ICACLS %WinDir%\Logs /GRANT:R %UserName%:F /T && DEL /F /S /Q %WinDir%\*.etl
SET deletables=*.tmp *._mp *.log *.gid *.chk *.old *.tor* mpcache-*
FOR %%a in (!deletables!) DO ( DEL /S /F /Q %SystemDrive%\%%a )

vssadmin delete shadows /all && vssadmin delete shadows /for=C: /all
VSSADMIN DELETE SHADOWS /ALL && VSSADMIN DELETE SHADOWS /FOR=C: /ALL

SET ChromeStartDir="%ProgramFiles%\Google\Chrome\Application"
SET ChromeAppProxyDir="%ProgramFiles%\Google\Chrome\Application"
PUSHD %ChromeStartDir% && START chrome.exe
START chrome_proxy.exe --profile-directory=Default --app-id=pkooggnaalmfkidjmlhoelhdllpphaga && POPD
TASKKILL /F /IM conhost.exe cmd.exe bash.exe /T
EXIT 0
