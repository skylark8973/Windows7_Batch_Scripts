@echo off
net file 1>nul 2>nul
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 & popd
    exit /b
)
cd /d %1

SETLOCAL ENABLEDELAYEDEXPANSION ENABLEEXTENSIONS

SET /P TaskTodo="You only want to kill apps ? "
IF /I "%TaskTodo%" == "Y" (
    CD /D %LOCALAPPDATA%\Microsoft\OneDrive && OneDrive.exe /SHUTDOWN
    FOR /L %%X IN (1,1,10) DO (
        TASKKILL /F /IM MsEdge.exe /IM OneDrive.exe /IM MicrosoftPhotos.exe /IM MicrosoftEdge.exe /IM MicrosoftEdgeCP.exe /IM Chrome.exe ^
        /IM GoogleCrashHandler.exe /IM GoogleCrashHandler64.exe /IM MicrosoftEdgeSH.exe /IM Ccleaner64.exe /IM IDMIntegrator64.exe ^
        /IM sublime_text.exe /IM Firefox.exe /IM AnyDesk.exe /IM Slack.exe /IM Teams.exe /IM uTorrent.exe /IM PWRISOVM.exe /IM openvpn-gui.exe ^
        /IM openvpnserv.exe /IM Lightshot.exe /IM GoogleDriveSync.exe /IM RuntimeBroker.exe /IM Update.exe /IM ETDCtrl.exe /IM ETDCtrlHelper.exe ^
        /IM ETDTouch.exe /IM TrayMenu.exe /IM PAStarter.exe /IM dllhost.exe /IM IEMonitor.exe /IM MaxPayne.exe /IM MsMpEng.exe /IM IDMan.exe ^
        /IM IEMonitor.exe /IM soffice.exe /IM soffice.bin /IM chrome_proxy.exe /IM RememBear.App.exe /T
    )
    VSSADMIN DELETE SHADOWS /ALL && VSSADMIN DELETE SHADOWS /FOR=C: /ALL & EXIT 0
)

SET CCleanerExc="%ProgramFiles%\CCleaner\CCleaner64.exe"
CD /D %LOCALAPPDATA%\Microsoft\OneDrive && OneDrive.exe /SHUTDOWN
FOR /L %%X IN (1,1,10) DO (
    TASKKILL /F /IM MsEdge.exe /IM OneDrive.exe /IM MicrosoftPhotos.exe /IM MicrosoftEdge.exe /IM MicrosoftEdgeCP.exe /IM Chrome.exe ^
        /IM GoogleCrashHandler.exe /IM GoogleCrashHandler64.exe /IM MicrosoftEdgeSH.exe /IM Ccleaner64.exe /IM IDMIntegrator64.exe ^
        /IM sublime_text.exe /IM Firefox.exe /IM AnyDesk.exe /IM Slack.exe /IM Teams.exe /IM uTorrent.exe /IM PWRISOVM.exe /IM openvpn-gui.exe ^
        /IM openvpnserv.exe /IM Lightshot.exe /IM GoogleDriveSync.exe /IM RuntimeBroker.exe /IM Update.exe /IM ETDCtrl.exe /IM ETDCtrlHelper.exe ^
        /IM ETDTouch.exe /IM TrayMenu.exe /IM PAStarter.exe /IM dllhost.exe /IM IEMonitor.exe /IM MaxPayne.exe /IM MsMpEng.exe /IM IDMan.exe ^
        /IM IEMonitor.exe /IM soffice.exe /IM soffice.bin /IM chrome_proxy.exe /IM RememBear.App.exe /T
)
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
SET TeamsStartDir=%LocalAppData%\Microsoft\Teams
START %TeamsStartDir%\Update.exe --processStart "Teams.exe"
SET SlackStartDir=%LocalAppData%\slack
START %SlackStartDir%\slack.exe
SET AnydeskStartDir="%ProgramFiles(x86)%\AnyDesk"
PUSHD %AnydeskStartDir% && START AnyDesk.exe 665042110 && POPD
TASKKILL /F /IM conhost.exe cmd.exe bash.exe /T
EXIT 0
