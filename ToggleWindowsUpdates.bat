@echo off
net file 1>nul 2>nul
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 & popd
    exit /b
)
cd /d %1

::CD /D %LOCALAPPDATA%\Microsoft\OneDrive && OneDrive.exe /SHUTDOWN
::FOR /L %%X IN (1,1,10) DO (
::    TASKKILL /F /IM MsEdge.exe /IM OneDrive.exe /IM MicrosoftPhotos.exe /IM MicrosoftEdge.exe /IM MicrosoftEdgeCP.exe /IM Chrome.exe ^
::    /IM GoogleCrashHandler.exe /IM GoogleCrashHandler64.exe /IM MicrosoftEdgeSH.exe /IM Ccleaner64.exe /IM IDMIntegrator64.exe ^
::    /IM sublime_text.exe /IM Firefox.exe /IM AnyDesk.exe /IM Slack.exe /IM Teams.exe /IM uTorrent.exe /IM PWRISOVM.exe /IM openvpn-gui.exe ^
::    /IM openvpnserv.exe /IM Lightshot.exe /IM GoogleDriveSync.exe /IM RuntimeBroker.exe /IM Update.exe /IM ETDCtrl.exe /IM ETDCtrlHelper.exe ^
::    /IM ETDTouch.exe /IM TrayMenu.exe /IM PAStarter.exe /IM dllhost.exe /IM IEMonitor.exe /IM MaxPayne.exe /IM MsMpEng.exe /IM IDMan.exe ^
::    /IM IEMonitor.exe /IM soffice.exe /IM soffice.bin /IM chrome_proxy.exe /IM RememBear.App.exe /IM BleachBit.exe /IM php.exe /IM SgrmBroker.exe ^
::    /IM conhost.exe /T
::)

for /F "tokens=3 delims=: " %%H in ('sc query wuauserv ^| findstr "        STATE"') do (
	if /I "%%H" NEQ "RUNNING" ( goto :EnableWindowsUpdates ) else ( goto :DisableWindowsUpdates )
)
:EnableWindowsUpdates
sc config wuauserv start= auto && net start wuauserv && goto :eof
:DisableWindowsUpdates
sc config wuauserv start= demand && net stop wuauserv && goto :eof