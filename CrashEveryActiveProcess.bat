@echo off
SETLOCAL ENABLEDELAYEDEXPANSION ENABLEEXTENSIONS
net file 1>NUL 2>NUL
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 & popd
    exit /b
)
cd /d %1
for /F "tokens=*" %%1 in ('wevtutil.exe el') DO wevtutil.exe cl "%%1"
SET CCleanerExc="C:\Program Files\CCleaner\CCleaner64.exe"
CD /D %LOCALAPPDATA%\Microsoft\OneDrive && OneDrive.exe /SHUTDOWN
FOR /L %%X IN (1,1,20) DO (
    TASKKILL /F /IM MsEdge.exe /IM OneDrive.exe /IM MicrosoftPhotos.exe /IM MicrosoftEdge.exe /IM MicrosoftEdgeCP.exe /IM Chrome.exe ^
    /IM GoogleCrashHandler.exe /IM GoogleCrashHandler64.exe /IM MicrosoftEdgeSH.exe /IM Ccleaner64.exe /IM IDMIntegrator64.exe ^
    /IM sublime_text.exe /IM Firefox.exe /IM AnyDesk.exe /IM Slack.exe /IM Teams.exe /IM uTorrent.exe /IM PWRISOVM.exe /IM openvpn-gui.exe ^
    /IM openvpnserv.exe /IM Lightshot.exe /IM GoogleDriveSync.exe /IM RuntimeBroker.exe /IM Update.exe /IM ETDCtrl.exe /IM ETDCtrlHelper.exe ^
    /IM ETDTouch.exe /IM TrayMenu.exe /IM PAStarter.exe /IM dllhost.exe /IM IEMonitor.exe /IM MaxPayne.exe /IM MsMpEng.exe /IM IDMan.exe ^
    /IM IEMonitor.exe /IM soffice.exe /IM soffice.bin /IM chrome_proxy.exe /IM RememBear.App.exe /IM BleachBit.exe /T
)

SET PathsToClean=%Temp% "%ProgramFiles(x86)%"\Microsoft\Temp %WinDir%\Logs %SystemRoot%\Temp ^
%WinDir%\TempInst %SystemDrive%\OneDriveTemp %UserProfile%\Videos\AnyDesk %WinDir%\WinSXS\Temp ^
%ProgramData%\Microsoft\"Windows Defender"\Scans\History\ReportLatency\Latency
(FOR %%P IN (!PathsToClean!) DO ( ECHO %%P && RD /S /Q %%P )) 2>NUL
SET FilesToPurge=%ProgramData%\Microsoft\"Windows Defender"\Scans\mpcache-*
(FOR %%P IN (!FilesToPurge!) DO ( ECHO %%P && DEL /S /Q %%P )) 2>NUL

DEL /S /Q /F %LocalAppData%\Google\Drive\user_default\*.log && RD /S /Q %LocalAppData%\Google\Drive\user_default\TempData\

for /f "delims=" %%i in ('dir /a:d /s /b %SystemRoot%\Logs') do rd /s /q %%i
for /f "delims=" %%i in ('dir /a:d /s /b %SystemRoot%\Cache*') do rd /s /q %%i
for /f "delims=" %%i in ('dir /a:d /s /b "%ProgramFiles%"\Logs') do rd /s /q "%%i"
for /f "delims=" %%i in ('dir /a:d /s /b "%ProgramFiles%"\Cache*') do rd /s /q "%%i"
for /f "delims=" %%i in ('dir /a:d /s /b "%ProgramFiles%"\Sys*?Logs') do rd /s /q "%%i"
for /f "delims=" %%i in ('dir /a:d /s /b %windir%\softwaredistribution\Down*') do rd /s /q %%i

del /s /f /q %systemdrive%\mpcache* & set deletables=tmp _mp log gid chk old torrent
for %%a in (!deletables!) do ( del /s /q /f %systemdrive%\*.%%a )

del /f /s /q %systemdrive%\*.tmp
del /f /s /q %systemdrive%\*._mp
del /f /s /q %systemdrive%\*.log
del /f /s /q %systemdrive%\*.gid
del /f /s /q %systemdrive%\*.chk
del /f /s /q %systemdrive%\*.old
del /f /s /q %SystemDrive%\*.etl
del /f /s /q %systemdrive%\mpcache*
del /f /s /q %systemdrive%\*.torrent
del /f /s /q %systemdrive%\recycled\*.*
del /f /s /q %windir%\*.bak
del /f /s /q %windir%\prefetch\*.*
rd /s /q %windir%\temp & md %windir%\temp
del /f /q %userprofile%\cookies\*.*
del /f /q %userprofile%\recent\*.*
del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*"
del /f /s /q "%userprofile%\Local Settings\Temp\*.*"
del /f /s /q "%userprofile%\recent\*.*"
del /s /f /q %userprofile%\Recent\*.*
del /s /f /q %SystemRoot%\Prefetch\*.*
del /s /f /q %SystemRoot%\Temp\*.*
del /s /f /q %USERPROFILE%\appdata\local\temp\*.*
del /s /f /q %windir%\system32\dllcache\*.*
rd /s /q %windir%\system32\dllcache
md %windir%\system32\dllcache
del /s /f /q "%SysteDrive%\Temp"\*.*
rd /s /q "%SysteDrive%\Temp"
md "%SysteDrive%\Temp"
del /s /f /q "%USERPROFILE%\Local Settings\History"\*.*
rd /s /q "%USERPROFILE%\Local Settings\History"
md "%USERPROFILE%\Local Settings\History"
del /s /f /q "%USERPROFILE%\Local Settings\Temporary Internet Files"\*.*
rd /s /q "%USERPROFILE%\Local Settings\Temporary Internet Files"
md "%USERPROFILE%\Local Settings\Temporary Internet Files"
del /s /f /q "%USERPROFILE%\Local Settings\Temp"\*.*
rd /s /q "%USERPROFILE%\Local Settings\Temp"
md "%USERPROFILE%\Local Settings\Temp"
del /s /f /q "%USERPROFILE%\Recent"\*.*
rd /s /q "%USERPROFILE%\Recent"
md "%USERPROFILE%\Recent"
del /s /f /q "%USERPROFILE%\Cookies"\*.*
rd /s /q "%USERPROFILE%\Cookies"
md "%USERPROFILE%\Cookies"

Dism.exe /online /Cleanup-Image /SPSuperseded
Dism.exe /online /Cleanup-Image /StartComponentCleanup
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase

taskkill /F /IM explorer.exe /IM chrome.exe /T
start explorer
