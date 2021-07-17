@echo off
net file 1>NUL 2>NUL
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 & popd
    exit /b
)
cd /d %1
net stop wsearch
reg add "HKLM\SOFTWARE\Microsoft\Windows Search" /v SetupCompletedSuccessfully /t REG_DWORD /d 0 /f
del /f /q "%ProgramData%\Microsoft\Search\Data\Applications\Windows\Windows.edb"
rem for /D %%I in ("%SystemRoot%\SystemApps\Microsoft.Windows.Search_*") do (
rem     echo "%%~I"
rem     :: del /q /f /s "%%I\*" && del /q /f /s "%%I\*.*"
rem )
for /f %%i in ('dir /a:d /s /b %SystemRoot%\SystemApps\Microsoft.Windows.Search_*') do set WinSrchCch="%%i"
:: for /f "delims=" %%D in ('dir /a:d /s /b %SystemRoot%\SystemApps\Microsoft.Windows.Search_*') do echo %%~fD
ICACLS %WinSrchCch% /INHERITANCE:e /GRANT:r %USERNAME%:(F) /T /C
del /q /f /s "%WinSrchCch%\cache\*" && del /q /f /s "%WinSrchCch%\cache\*.*"
net start wsearch
pause>nul
