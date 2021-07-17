@echo off
SETLOCAL ENABLEDELAYEDEXPANSION ENABLEEXTENSIONS
net file 1>NUL 2>NUL
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 & popd
    exit /b
)
cd /d %1

SET /P KillTaskTimes=Kill Tasks How many times ?
FOR /L %%X IN (1,1,!KillTaskTimes!) DO (
    TASKKILL /F /T /IM Browser_Broker.exe /IM MicrosoftEdge.exe /IM MicrosoftEdgeCP.exe /IM MicrosoftEdgeSH.exe /IM RuntimeBroker.exe /IM dllhost.exe /IM Rundll32.exe
    TASKKILL.EXE /F /T /FI "USERNAME EQ %USERNAME%" /FI "IMAGENAME NE cmd.exe" /FI "IMAGENAME NE conhost.exe"
)
