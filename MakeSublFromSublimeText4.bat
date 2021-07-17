@echo off
:: Batch-Admin API
    net file>nul 2>&1&&if "%~1"=="64" (goto:GotAdmin) else (if exist "%windir%\Sysnative\" (call start %windir%\Sysnative\cmd /c "%~0" 64&exit) else (goto:GotAdmin))
    echo Requesting administrative privileges...
    (echo Set UAC = CreateObject^("Shell.Application"^)
     echo UAC.ShellExecute "%~s0", "ELEV","", "runas", 0 ) > "%temp%\admin.vbs"
    cscript /Nologo "%temp%\admin.vbs"&exit

:GotAdmin
    :: Place ADMIN tasks below
    del /f /q "%SystemRoot%\System32\subl.exe"
    copy /Y "%ProgramFiles%\Sublime Text\subl.exe" "%SystemRoot%\System32\"
    pause
exit
