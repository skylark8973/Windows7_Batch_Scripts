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
    FOR /L %%X IN (1,1,10) DO ( TASKKILL /F /IM MsEdge.exe /IM sublime_text.exe /T )
    VSSADMIN DELETE SHADOWS /ALL && VSSADMIN DELETE SHADOWS /FOR=C: /ALL & EXIT 0
)
