<!-- : Begin batch script
@echo off
SETLOCAL ENABLEDELAYEDEXPANSION ENABLEEXTENSIONS
net file 1>NUL 2>NUL
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 & popd
    exit /b
)
cd /d %1

:WinSpclTskMgr
cls
echo 1: Cleanup HDD Space^

2: NTFS Compress WinSXS^

3: Kill Rebootable Processes^

4: Restart Windows Explorer^

5: Stop+Clean Windows Updates^

6: Cleanup WinSXS Directory^

7: Scan the health of HDD^

8: Update ^& Open Windows Defender^

9: Reset Network ^& Exit Utility^

a: GDriveSync ^& Browser Cleanup^

b: Force Off Windows Updates ^& Cleanup^

c: Reset Nightlight ^& Purge Shadow Copies^

d: Add to Context Menu thro' Registry^

e: Generate secure passwords for usage^

f: Toggle Windows Updates feature^

g: Start running Office Work Apps^

h: Copy Full PC Name to Clipboard^

i: Reset Main System Folder Access^

0: Do nothing ^& Exit Utility && echo.

choice /n /c 1234567890abcdefghi /m "Select any of given tasks: "
if %errorlevel% == 1 (
    TAKEOWN /F %SystemRoot%\System32\WaaSMedicSvc.dll /A
    TAKEOWN /F %SystemRoot%\Logs /A /R /D Y && ICACLS %SystemRoot%\Logs /grant Administrators:F /T
    sc config bits start= disabled && net stop bits
    sc config UsoSvc start= disabled & sc stop UsoSvc
    sc config dosvc start= delayed-auto && net stop dosvc
    sc config wuauserv start= disabled && net stop wuauserv
    sc config WaasMedicSvc start= disabled & sc stop WaasMedicSvc
    reg add HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc /v Start /f /t REG_DWORD /d 4
    reg add HKLM\SYSTEM\CurrentControlSet\Services\wuauserv /v Start /f /t REG_DWORD /d 4
    reg add HKLM\SYSTEM\CurrentControlSet\Services\WaasMedicSvc /v Start /f /t REG_DWORD /d 4
    Net Stop bits & Net Stop wuauserv & Net Stop appidsvc & Net Stop cryptsvc & Net Stop msiserver
    SET PathsToClean=%Temp% "%ProgramFiles(x86)%"\Microsoft\Temp %WinDir%\Logs %SystemRoot%\Temp ^
    %WinDir%\TempInst %SystemDrive%\OneDriveTemp %UserProfile%\Videos\AnyDesk %WinDir%\WinSXS\Temp ^
    %ProgramData%\Microsoft\"Windows Defender"\Scans\History\ReportLatency\Latency
    (FOR %%P IN (!PathsToClean!) DO ( ECHO %%P && RD /S /Q %%P )) 2>NUL
    SET FilesToPurge=%ProgramData%\Microsoft\"Windows Defender"\Scans\mpcache-*
    (FOR %%P IN (!FilesToPurge!) DO ( ECHO %%P && DEL /S /Q %%P )) 2>NUL

    DEL /S /Q /F %LocalAppData%\Google\Drive\user_default\*.log && RD /S /Q %LocalAppData%\Google\Drive\user_default\TempData\

    for /f "delims=" %%i in ('dir /a:d /s /b %SystemRoot%\Logs') do rd /s /q %%i
    for /f "delims=" %%i in ('dir /a:d /s /b %SystemRoot%\Cache*') do rd /s /q %%i
    for /f "delims=" %%i in ('dir /a:d /s /b "%ProgramFiles%"\Logs') do rd /s /q "%%i"
    for /f "delims=" %%i in ('dir /a:d /s /b "%ProgramFiles%"\Cache*') do rd /s /q "%%i"
    for /f "delims=" %%i in ('dir /a:d /s /b "%ProgramFiles%"\Sys*?Logs') do rd /s /q "%%i"
    for /f "delims=" %%i in ('dir /a:d /s /b %windir%\softwaredistribution\Down*') do rd /s /q %%i

    del /s /f /q %systemdrive%\mpcache* & set deletables=tmp _mp log gid chk old torrent
    for %%a in (!deletables!) do ( del /s /q /f %systemdrive%\*.%%a )

    del /f /s /q %systemdrive%\*.tmp
    del /f /s /q %systemdrive%\*._mp
    del /f /s /q %systemdrive%\*.log
    del /f /s /q %systemdrive%\*.gid
    del /f /s /q %systemdrive%\*.chk
    del /f /s /q %systemdrive%\*.old
    del /f /s /q %SystemDrive%\*.etl
    del /f /s /q %systemdrive%\mpcache*
    del /f /s /q %systemdrive%\*.torrent
    del /f /s /q %systemdrive%\recycled\*.*
    del /f /s /q %windir%\*.bak
    del /f /s /q %windir%\prefetch\*.*
    rd /s /q %windir%\temp & md %windir%\temp
    del /f /q %userprofile%\cookies\*.*
    del /f /q %userprofile%\recent\*.*
    del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*"
    del /f /s /q "%userprofile%\Local Settings\Temp\*.*"
    del /f /s /q "%userprofile%\recent\*.*"
    del /s /f /q %userprofile%\Recent\*.*
    del /s /f /q %SystemRoot%\Prefetch\*.*
    del /s /f /q %SystemRoot%\Temp\*.*
    del /s /f /q %USERPROFILE%\appdata\local\temp\*.*
    del /s /f /q %windir%\system32\dllcache\*.*
    rd /s /q %windir%\system32\dllcache
    md %windir%\system32\dllcache
    del /s /f /q "%SysteDrive%\Temp"\*.*
    rd /s /q "%SysteDrive%\Temp"
    md "%SysteDrive%\Temp"
    del /s /f /q "%USERPROFILE%\Local Settings\History"\*.*
    rd /s /q "%USERPROFILE%\Local Settings\History"
    md "%USERPROFILE%\Local Settings\History"
    del /s /f /q "%USERPROFILE%\Local Settings\Temporary Internet Files"\*.*
    rd /s /q "%USERPROFILE%\Local Settings\Temporary Internet Files"
    md "%USERPROFILE%\Local Settings\Temporary Internet Files"
    del /s /f /q "%USERPROFILE%\Local Settings\Temp"\*.*
    rd /s /q "%USERPROFILE%\Local Settings\Temp"
    md "%USERPROFILE%\Local Settings\Temp"
    del /s /f /q "%USERPROFILE%\Recent"\*.*
    rd /s /q "%USERPROFILE%\Recent"
    md "%USERPROFILE%\Recent"
    del /s /f /q "%USERPROFILE%\Cookies"\*.*
    rd /s /q "%USERPROFILE%\Cookies"
    md "%USERPROFILE%\Cookies"

    Dism.exe /online /Cleanup-Image /SPSuperseded
    Dism.exe /online /Cleanup-Image /StartComponentCleanup
    Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
    CleanMgr.exe /VeryLowDisk && CleanMgr.exe /AutoClean && CleanMgr.exe /LowDisk
    CleanMgr.exe /Sageset:249 && CleanMgr.exe /Sagerun:249 && CleanMgr.exe /Sagerun:249

    goto DltTmpIntrntFlsFully
) else if %errorlevel% == 2 (
    goto CmprsWinSXSFldr
) else if %errorlevel% == 3 (
    powercfg.exe /hibernate off
    devcon status "*ELAN0625" | find "running" >nul && set "status=running" || set "status=disabled"
    if "%status%" == "running" ( devcon disable "*ELAN0625" )
    del /s /f /q %temp%\* && rd /s /q %temp% & md %temp%
    del /s /f /q %WinDir%\Temp\* && rd /s /q %WinDir%\Temp & md %WinDir%\Temp
    del /s /f /q %SystemDrive%\Windows.old\* && rd /s /q %SystemDrive%\Windows.old
    del /s /f /q "%ProgramFiles%\Rempl"\* && rd /s /q "%ProgramFiles%\Rempl" & md "%ProgramFiles%\Rempl"
    del /s /f /q %WinDir%\LiveKernelReports\* && rd /s /q %WinDir%\LiveKernelReports & md %WinDir%\LiveKernelReports
    del /s /f /q "%WinDir%\Downloaded Program Files"\* && rd /s /q "%WinDir%\Downloaded Program Files" & md "%WinDir%\Downloaded Program Files"
    SET CCleanerExc="C:\Program Files\CCleaner\CCleaner64.exe"
    cd /d %LOCALAPPDATA%\Microsoft\OneDrive && OneDrive.exe /shutdown
    SET /P KillTaskTimes=Kill Tasks How many times ?
    FOR /L %%X IN (1,1,!KillTaskTimes!) DO (
        TASKKILL /F /T /IM Browser_Broker.exe /IM MicrosoftEdge.exe /IM MicrosoftEdgeCP.exe /IM MicrosoftEdgeSH.exe /IM RuntimeBroker.exe /IM dllhost.exe /IM Rundll32.exe /IM AnyDesk.exe
        TASKKILL.EXE /F /T /FI "USERNAME EQ %USERNAME%" /FI "IMAGENAME NE cmd.exe" /FI "IMAGENAME NE conhost.exe"
    )
    set /p opt="Run CCleaner app ? "
    if /i '!opt!'=='Y' (
        !CCleanerExc! /Auto && !CCleanerExc! /Auto && !CCleanerExc! /Registry && TIMEOUT /T -1 && TASKKILL /F /IM Ccleaner64.exe /T
    )
    set deletables=*.tmp *._mp *.log *.gid *.chk *.old *.torrent mpcache-*.bin.*
    for %%a in (!deletables!) do ( del /s /f /q %SystemDrive%\%%a )
    goto DltTmpIntrntFlsFully
) else if %errorlevel% == 4 (
    taskkill /f /im explorer.exe && start /wait explorer.exe
    taskkill /f /t /im conhost.exe /im cmd.exe /im bash.exe
) else if %errorlevel% == 5 (
    goto DsblWindowsUpdts
) else if %errorlevel% == 6 (
    goto ClnpPrgWinSXSFldr
) else if %errorlevel% == 7 (
    rd /s /q %temp% && rd /s /q %WinDir%\Temp && md %WinDir%\Temp && sfc /Scannow
) else if %errorlevel% == 8 (
    goto UpdtOpnWndwsDfndr
) else if %errorlevel% == 9 (
    cmdkey.exe /list > "%TEMP%\List.txt"
    findstr.exe Target "%TEMP%\List.txt" > "%TEMP%\tokensonly.txt"
    FOR /F "tokens=1,2 delims= " %%G IN (%TEMP%\tokensonly.txt) DO cmdkey.exe /delete:%%H
    del "%TEMP%\List.txt" /s /f /q
    del "%TEMP%\tokensonly.txt" /s /f /q
    echo All tokens purged... && pause>nul
    netsh interface set interface name="Local area connection" admin="disabled"
    netsh interface set interface name="Wireless Network Connection" admin="disabled"
    netsh interface set interface name="Local area connection" admin="enabled"
    netsh interface set interface name="Wireless Network Connection" admin="enabled"
    ipconfig /release && ipconfig /flushdns && ipconfig /renew
    exit /b 0
) else if %errorlevel% == 10 (
    ::echo choice:0... & pause>nul
    del /s /f /q %temp%\* && rd /s /q %temp% & md %temp% & exit /b 0
) else if %errorlevel% == 11 (
    FOR /L %%X IN (1,1,10) DO (
        TASKKILL /F /T /IM MicrosoftEdge.exe /IM Firefox.exe /IM Iexplore.exe /IM Chrome.exe /IM GoogleUpdate.exe ^
        /IM Chromedriver.exe /IM MSEdge.exe /IM GoogleCrashHandler.exe /IM GoogleCrashHandler64.exe ^
        /IM googledrivesync.exe && WMIC Process Where "Name Like 'CCleaner%%'" Call Terminate && IPCONFIG /FlushDNS
    )
    del /s /f /q %systemdrive%\mpcache* & set deletables=tmp _mp log gid chk old torrent
    for %%a in (!deletables!) do ( del /s /q /f %systemdrive%\*.%%a )
    del /s /f /q %temp%\* && rd /s /q %temp% && SET CCleanerExc="%ProgramFiles%\CCleaner\CCleaner64.exe"
    !CCleanerExc! /Auto && !CCleanerExc! /Auto && WMIC Process Where "Name Like 'CCleaner%%'" Call Terminate
) else if %errorlevel% == 12 (
    TAKEOWN /F %SystemRoot%\System32\WaaSMedicSvc.dll /A
    NET STOP WaaSMedicSvc & NET STOP wuauserv & SC STOP WaaSMedicSvc & SC STOP wuauserv
    TAKEOWN /F %SystemRoot%\Logs /A /R /D Y && DEL /F /S /Q %SystemDrive%\*.etl
    ICACLS %SystemRoot%\Logs /SETOWNER "Administrators" /T /C
    DEL /F /S /Q %SystemDrive%\*.etl & DEL /F /S /Q %SystemDrive%\*.etl
    DEL /F /S /Q %SystemDrive%\*.tmp & DEL /F /S /Q %SystemDrive%\*.tmp
    DEL /F /S /Q %SystemDrive%\*._mp & DEL /F /S /Q %SystemDrive%\*._mp
    DEL /F /S /Q %SystemDrive%\*.log & DEL /F /S /Q %SystemDrive%\*.log
    DEL /F /S /Q %SystemDrive%\*.gid & DEL /F /S /Q %SystemDrive%\*.gid
    DEL /F /S /Q %SystemDrive%\*.chk & DEL /F /S /Q %SystemDrive%\*.chk
    DEL /F /S /Q %SystemDrive%\*.old & DEL /F /S /Q %SystemDrive%\*.old
    DEL /F /S /Q %SystemDrive%\*.tor* & DEL /F /S /Q %SystemDrive%\*.tor*
) else if %errorlevel% == 13 (
    vssadmin delete shadows /all && vssadmin delete shadows /for=C: /all
    VSSADMIN DELETE SHADOWS /ALL && VSSADMIN DELETE SHADOWS /FOR=C: /ALL
    REG DELETE HKCU\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\DefaultAccount\Cloud\$$windows.data.bluelightreduction.settings /F
    REG DELETE HKCU\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\DefaultAccount\Cloud\$$windows.data.bluelightreduction.bluelightreductionstate /F
    SHUTDOWN /R /T 00
) else if %errorlevel% == 14 (
    REG DELETE "HKCR\Directory\Background\shell\AIOSysUtil" /F
    REG ADD "HKCR\Directory\Background\shell\AIOSysUtil" /VE /D "AIO System Utility"
    REG ADD "HKCR\Directory\Background\shell\AIOSysUtil" /V "Not Working Directory" /D ""
    REG ADD "HKCR\Directory\Background\shell\AIOSysUtil\command" /VE /D "CMD /V:ON /E:ON /C ""%0"""
) else if %errorlevel% == 15 (
    Powershell -ExecutionPolicy RemoteSigned -File "%~dp0SecurePasswordGenerator01072021.ps1"
) else if %errorlevel% == 16 (
    for /F "tokens=3 delims=: " %%H in ('sc query wuauserv ^| findstr "        STATE"') do (
        if /I "%%H" NEQ "RUNNING" ( goto :EnableWindowsUpdates ) else ( goto :DisableWindowsUpdates )
    )
    :EnableWindowsUpdates
    sc config wuauserv start= auto && net start wuauserv && goto :eof
    :DisableWindowsUpdates
    sc config wuauserv start= demand && net stop wuauserv && goto :eof
) else if %errorlevel% == 17 (
    set SlackAppPath=%LocalAppData%\slack\slack.exe
    set SlackRunPath=%LocalAppData%\slack\app-4.17.1
    :: Teams run command: %LocalAppData%\Microsoft\Teams\Update.exe --processStart "Teams.exe"
    set TeamsAppPath=%LocalAppData%\Microsoft\Teams\Update.exe
    set TeamsRunPath=%LocalAppData%\Microsoft\Teams
    taskkill /f /t /im ssh-agent.exe /im git-bash.exe /im sh.exe /im slack.exe /im Teams.exe
    pushd !SlackRunPath! && start "" /B slack.exe && popd
    pushd !TeamsRunPath! && start "" /B Update.exe --processStart "Teams.exe" && popd
    start C:\WMRR_Projects\jobs-client-ui & set PrjPth="/c/WMRR_Projects"
    set PrjFldr=%SystemDrive%\WMRR_Projects & start %SystemDrive%\WMRR_Projects
    pushd !PrjFldr!\jobs-platform && start "" "%ProgramFiles%\Git\git-bash.exe" && popd
    pushd !PrjFldr!\jobs-client-ui && start "" "%ProgramFiles%\Git\git-bash.exe" && popd
    set PrjFldr=!PrjFldr: =!
    subl !PrjFldr!\.pswd & "%ProgramFiles%\Sublime Text\sublime_text.exe" !PrjFldr!\.pswd
) else if %errorlevel% == 18 (
    for /F "skip=1delims=" %%I in ('wmic computersystem get domain') do (
        if not defined DOMAIN set "DOMAIN=%%~I"
    )
    for /F "tokens=* eol= " %%I in ("%USERNAME%\!DOMAIN!") do ( set FULLNAME=%%I )
    call :Trim FULLNAME1 !FULLNAME!
    echo | set /p="!FULLNAME1!" | clip && pause>nul

    :Trim
    SetLocal EnableDelayedExpansion
    set Params=%*
    for /f "tokens=1*" %%a in ("!Params!") do EndLocal & set %1=%%b
    exit /b
) else if %errorlevel% == 19 (
    set "Paths=%Temp% %SystemRoot%\Logs %SystemRoot%\Temp"
    for %%P in (!Paths!) do (
        icacls %%P /remove:d Everyone /grant:r "Everyone:(OI)(CI)F" /T
        del /q /f /s %%P\* && TAKEOWN /F %%P /R /D Y && ICACLS %%P /reset /T
    )
    msiexec /unreg && msiexec /regserver
    taskkill /f /im explorer.exe && start explorer.exe
)
echo. && pause && goto WinSpclTskMgr

:CmprsWinSXSFldr
sc stop msiserver
sc stop TrustedInstaller
sc config msiserver start= disabled
sc config TrustedInstaller start= disabled
icacls "%WINDIR%\WinSxS" /save "%WINDIR%\WinSxS_NTFS.acl" /t
takeown /f "%WINDIR%\WinSxS" /r
icacls "%WINDIR%\WinSxS" /grant "%USERDOMAIN%\%USERNAME%":(F) /t
compact /s:"%WINDIR%\WinSxS" /c /a /i *
icacls "%WINDIR%\WinSxS" /setowner "NT SERVICE\TrustedInstaller" /t
icacls "%WINDIR%" /restore "%WINDIR%\WinSxS_NTFS.acl"
del /f /s /q %WINDIR%\WinSxS_NTFS.acl
sc config msiserver start= demand
sc config TrustedInstaller start= demand
echo. && pause && goto WinSpclTskMgr

:ClnpPrgWinSXSFldr
sc stop msiserver
sc stop TrustedInstaller
sc config msiserver start= disabled
sc config TrustedInstaller start= disabled
icacls "%WINDIR%\WinSxS" /save "%WINDIR%\WinSxS_NTFS.acl" /t
takeown /f "%WINDIR%\WinSxS" /r
icacls "%WINDIR%\WinSxS" /grant "%USERDOMAIN%\%USERNAME%":(F) /t
rd /s /q "%WINDIR%\WinSxS\Temp" && rd /s /q "%WINDIR%\WinSxS\Backup"
icacls "%WINDIR%\WinSxS" /setowner "NT SERVICE\TrustedInstaller" /t
icacls "%WINDIR%" /restore "%WINDIR%\WinSxS_NTFS.acl"
del /f /s /q %WINDIR%\WinSxS_NTFS.acl
sc config msiserver start= demand
sc config TrustedInstaller start= demand
echo. && pause && goto WinSpclTskMgr

:DsblWindowsUpdts
TAKEOWN /F %SystemRoot%\System32\WaaSMedicSvc.dll /A
sc config bits start= disabled && net stop bits
sc config UsoSvc start= disabled & sc stop UsoSvc
sc config dosvc start= delayed-auto && net stop dosvc
sc config wuauserv start= disabled && net stop wuauserv
sc config WaasMedicSvc start= disabled & sc stop WaasMedicSvc
reg add HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc /v Start /f /t REG_DWORD /d 4
reg add HKLM\SYSTEM\CurrentControlSet\Services\wuauserv /v Start /f /t REG_DWORD /d 4
reg add HKLM\SYSTEM\CurrentControlSet\Services\WaasMedicSvc /v Start /f /t REG_DWORD /d 4
Net Stop bits & Net Stop wuauserv & Net Stop appidsvc & Net Stop cryptsvc & Net Stop msiserver
del /f /s /q %SystemDrive%\*._mp & del /f /s /q %SystemDrive%\*.tmp & del /f /s /q %SystemDrive%\*.gid
del /f /s /q %SystemDrive%\*.etl & del /f /s /q %SystemDrive%\*.log & del /f /s /q %SystemDrive%\*.old
Set "Dir1="%WinDir%\Downloaded Program Files"" && Call Del /f /s /q %%Dir1%%\* 2>nul && Call RmDir /s /q %%Dir1%%
Set "Dir2=%WinDir%\SoftwareDistribution\Download" && Call Del /f /s /q %%Dir2%%\* 2>nul && Call RmDir /s /q %%Dir2%%
Set "Dir3=%WinDir%\SoftwareDistribution\DataStore" && Call Del /f /s /q %%Dir3%%\* 2>nul && Call RmDir /s /q %%Dir3%%
echo. && pause && goto WinSpclTskMgr

:UpdtOpnWndwsDfndr
"%ProgramFiles%"\"Windows Defender"\MpCmdRun.exe -RemoveDefinitions -DynamicSignatures
"%ProgramFiles%"\"Windows Defender"\MpCmdRun.exe -SignatureUpdate
del /f /s /q %temp%\* & rd /s /q %temp%
cscript //nologo "%~f0?.wsf" && del /f /s /q %systemdrive%\mpcache-*.bin.*
echo. && pause && goto WinSpclTskMgr
----- Begin wsf script --->
<job><script language="VBScript">
    Sub WinDefendOff
        On Error Resume Next
        Set WshShell = WScript.CreateObject("WScript.shell")
        WshShell.Visible = False
        WshShell.Run "windowsdefender:",0
        WScript.Sleep 600 : WshShell.AppActivate "Windows Security"
        WScript.Sleep 600 : WshShell.sendKeys " "
        WScript.Sleep 600 : WshShell.sendKeys "{TAB}"
        WScript.Sleep 600 : WshShell.sendKeys "{TAB}"
        WScript.Sleep 600 : WshShell.sendKeys "{TAB}"
        WScript.Sleep 600 : WshShell.sendKeys "{TAB}"
        WScript.Sleep 600 : WshShell.sendKeys " "
        WScript.Sleep 600 : WshShell.sendKeys " "
        WScript.Sleep 5000 : WshShell.sendKeys "%{F4}"
    End Sub
    WinDefendOff
    WScript.Quit 0
</script></job>

:DltTmpIntrntFlsFully
set "TmpIntrntFlsDir=%LocalAppData%\Temporary Internet Files"
takeown /R /F "!TmpIntrntFlsDir!" && del /f /s /q "!TmpIntrntFlsDir!\*"
forfiles /P "!TmpIntrntFlsDir!\*" /C "if @isdir==TRUE rmdir /S /Q @file"
set TmpIntrntFlsDir1=%LocalAppData%\Temp
takeown /R /F "!TmpIntrntFlsDir1!" && del /f /s /q "!TmpIntrntFlsDir1!\*"
forfiles /P "!TmpIntrntFlsDir1!\*" /C "if @isdir==TRUE rmdir /S /Q @file"
set "TmpIntrntFlsDir2=%LocalAppData%\Microsoft\Windows\INetCache"
takeown /R /F "!TmpIntrntFlsDir2!" && del /f /s /q "!TmpIntrntFlsDir2!\*"
forfiles /P "!TmpIntrntFlsDir2!\*" /C "if @isdir==TRUE rmdir /S /Q @file"
echo. && pause && goto WinSpclTskMgr
