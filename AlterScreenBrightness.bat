@echo off

cls
echo 1.8
echo 2.9
echo 3.10
echo 4.11
echo 5.12
echo 6.Quit

echo.
choice /C 123456 /M "Enter your brightness choice: "
set /a "brightness=%errorlevel%+7"
powershell "(Get-WmiObject -Namespace root/WMI -Class WmiMonitorBrightnessMethods).WmiSetBrightness(1,%brightness%)"
if "%errorlevel%"=="6" exit /b 0
exit /b 0
