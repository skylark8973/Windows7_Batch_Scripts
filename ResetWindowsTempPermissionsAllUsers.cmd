@echo off
net file 1>nul 2>nul
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 & popd
    exit /b
)
cd /d %1
set "Paths=%Temp% %SystemRoot%\Logs %SystemRoot%\Temp"
for %%P in (%Paths%) do (
    rem icacls %%P /remove:d Everyone /grant:r "Everyone:(OI)(CI)F" /T
    rem del /q /f /s %%P\* && icacls %%P /reset /t /c /l
    rem icacls %%P /setowner "NT SERVICE\TrustedInstaller"
    TAKEOWN /F %%P /R /D Y && ICACLS %%P /reset /T
)
:: msiexec /unreg && msiexec /regserver && taskkill /f /im explorer.exe && start explorer.exe
pause>nul

:: ICACLS <filename> /grant administrators:F
:: Example 2: To assign Full Control permissions for the currently logged on user, use this command:

:: ICACLS <filename> /grant %username%:F
:: %username% represents the account name of the currently logged-on user. ICacls accepts this variable directly.

:: Example 3: To assign Full Control permissions for the user named John, use this command:

:: ICACLS <filename> /grant John:F
