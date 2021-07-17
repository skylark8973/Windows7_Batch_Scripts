@echo off
net file 1>nul 2>nul
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 & popd
    exit /b
)
cd /d %1
set "Paths=%Temp% %SystemRoot%\Logs %SystemRoot%\Temp"
for %%P in (%Paths%) do (
    icacls %%P /remove:d Everyone /grant:r "Everyone:(OI)(CI)F" /T
    del /q /f /s %%P\* && icacls %%P /reset /t /c /l && icacls %%P /SetOwner SYSTEM
)
msiexec /unreg && msiexec /regserver && taskkill /f /im explorer.exe && start explorer.exe
pause>nul
