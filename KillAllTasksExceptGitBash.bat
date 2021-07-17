@echo off
SETLOCAL ENABLEDELAYEDEXPANSION ENABLEEXTENSIONS
net file 1>NUL 2>NUL
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 & popd
    exit /b
)
cd /d %1
for /l %%x in (1,1,6) do (
    taskkill.exe /f /t /fi "username eq %username%" /fi "imagename ne cmd.exe" /fi "imagename ne conhost.exe" /fi "imagename ne ssh-agent.exe" /fi "imagename ne git-bash.exe" /fi "imagename ne mintty.exe" /fi "imagename ne bash.exe" /fi "imagename ne php.exe" /fi "imagename ne git.exe"
)
