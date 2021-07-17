@ECHO OFF
REM This Script is written by (c) Hackoo 2016 on 19/09/2016
Title Scan a folder and Search a string in multi-files by (c) Hackoo 2016
mode con cols=75 lines=2
Call :init
rem Call :CountingExecution
Call :inputbox "Please enter something to search :" "Search a string in multi-files by (c) Hackoo 2016"
If  "%input%" == ""  Color 0C & (
    echo(
    echo           You must enter a string to continue with this program
    pause>nul & exit
) else (
    Call :Browse4Folder "Choose source folder to scan for %input%" "c:\scripts"
)
::******************************************************************************************
Set "ROOT=%Location%"
::Does string have a trailing back slash ? if yes, so, we remove it !
IF %ROOT:~-1%==\ SET ROOT=%ROOT:~0,-1%
:: txt vbs js json hta php htm html xml csv rtf
SET "EXT=txt vbs js json hta php htm html xml csv rtf"
SET "Count=0"
set "Word2Search=%input%"
Set "NewFolder2Copy=%userprofile%\Desktop\CopyFiles_%Word2Search%"
Set "LogFile=%~dp0%~n0_%Word2Search%.txt"
SETLOCAL enabledelayedexpansion
REM Iterates throw the files on this current folder and its subfolders.
REM And Populate the array with existent files in this folder and its subfolders
For %%a in (%EXT%) Do (
    Call :Scanning "%Word2Search%" "*.%%a"
    Call :PS_Sub 'information' 10 '"Scanning now for """%Word2Search%""" on """*.%%a""" . . . "' "'Please wait. . . Scan is in progress on all """*.%%a""" . . .'" 'info' 5
    FOR /f "delims=" %%f IN ('dir /b /s "%ROOT%\*.%%a"') DO (
        ( find /I "%Word2Search%" "%%f" >nul 2>&1 ) && (
            SET /a "Count+=1"
            set "list[!Count!]=%%~nxf"
            set "listpath[!Count!]=%%~dpFf"
        )
    ) || (
            ( Call :Scanning "%Word2Search%" "%%~nxf" )
    )
)
::*******************************************************************
:Display_Results
cls & color 0B
echo wscript.echo Len("%ROOT%"^) + 20 >"%tmp%\length.vbs"
for /f %%a in ('Cscript /nologo "%tmp%\length.vbs"') do ( set "cols=%%a")
If %cols% LSS 50 set /a cols=%cols% + 24
rem If %cols% LSS 50 set /a cols=%cols% + 15
set /a lines=%Count% + 17
Mode con cols=%cols% lines=%lines%
echo(
Call :color 0A " ------------------------------------------------" 1
ECHO   Folder : "%ROOT%"
Call :color 0A " ------------------------------------------------" 1
rem If Exist "%LogFile%" Del "%LogFile%"
rem Display array elements
for /L %%i in (1,1,%Count%) do (
    set "msg=[%%i] - !list[%%i]!"
    echo !msg!
)
ECHO(
ECHO Total of [%EXT%] files(s) that contains
Echo the string "%Word2Search%" is : %Count% file(s)
echo.
Call :color 0D "Type the number of file that you want to explore" 1
echo(
Call :color 0C "To save results into a LogFile just type 'LOG'" 1
echo(
Call :color 0A "To copy all files found just type 'Copy'" 1
set /p "Input="
For /L %%i in (1,1,%Count%) Do (
    If "%INPUT%" EQU "%%i" (
        Call :Explorer "!listpath[%%i]!"
    )
    IF /I "%INPUT%"=="Log" (
        Call :Save_Results
    )
    IF /I "%INPUT%"=="Copy" (
        Call :CopyFiles
    )
)
Goto:Display_Results
::****************************************************************************
:Save_Results
If Exist "%LogFile%" Del "%LogFile%"
rem Display array elements and save results into the LogFile
(
    Echo   ------------------------------------------------
    ECHO   Folder : "%ROOT%"
    echo   ------------------------------------------------
)>"%LogFile%"

for /L %%i in (1,1,%Count%) do (
    set "msg=[%%i] - !list[%%i]!"
    echo !msg! -- "!listpath[%%i]!" >> "%LogFile%"
)

(
    ECHO.
    ECHO Total of [%EXT%] files(s^) : %Count% file(s^) that contains the string "%Word2Search%"
)>> "%LogFile%"
Start "" "%LogFile%"
Goto:Display_Results
::****************************************************************************
:Scanning <Word> <file>
mode con cols=75 lines=3
Cls & Color 0A
echo(
echo         Scanning for the string "%~1" on "%~2" ...
goto :eof
::****************************************************************************
:Explorer <file>
explorer.exe /e,/select,"%~1"
Goto :EOF
::****************************************************************************
:init
prompt $g
for /F "delims=." %%a in ('"prompt $H. & for %%b in (1) do rem"') do set "BS=%%a"
exit /b
::****************************************************************************
:color
set nL=%3
if not defined nL echo requires third argument & pause > nul & goto :eof
if %3 == 0 (
    <nul set /p ".=%bs%">%2 & findstr /v /a:%1 /r "^$" %2 nul & del %2 2>&1 & goto :eof
) else if %3 == 1 (
    echo %bs%>%2 & findstr /v /a:%1 /r "^$" %2 nul & del %2 2>&1 & goto :eof
)
exit /b
::***************************************************************************
:Browse4Folder
set Location=
set vbs="%temp%\_.vbs"
set cmd="%temp%\_.cmd"
for %%f in (%vbs% %cmd%) do if exist %%f del %%f
for %%g in ("vbs cmd") do if defined %%g set %%g=
(
    echo set shell=WScript.CreateObject("Shell.Application"^)
    echo set f=shell.BrowseForFolder(0,"%~1",0,"%~2"^)
    echo if typename(f^)="Nothing" Then
    echo wscript.echo "set Location=Dialog Cancelled"
    echo WScript.Quit(1^)
    echo end if
    echo set fs=f.Items(^):set fi=fs.Item(^)
    echo p=fi.Path:wscript.echo "set Location=" ^& p
)>%vbs%
cscript //nologo %vbs% > %cmd%
for /f "delims=" %%a in (%cmd%) do %%a
for %%f in (%vbs% %cmd%) do if exist %%f del /f /q %%f
for %%g in ("vbs cmd") do if defined %%g set %%g=
goto :eof
::***************************************************************************
:CountingExecution
Setlocal enabledelayedexpansion
Title Count the number of times my BATCH file is run
Mode Con Cols=60 lines=5 & color 0E
set /a count=1
set "FileCount=%tmp%\%~n0.txt"
If Not exist "%FileCount%" (
    echo !count! > "%FileCount%"
) else (
    For /F "tokens=*" %%a in ('Type "%FileCount%"') Do (
        set /a count=!count! + %%a
        echo !count! > "%FileCount%"
    )
)
echo.
echo        This batch script is running for "!count! time(s)"
echo(
Call :Color 0C "           - - - Hit any key to continue - - -" 1
EndLocal
pause>nul
::***************************************************************************
:InputBox
set "input="
set "heading=%~2"
set "message=%~1"
echo wscript.echo inputbox(WScript.Arguments(0),WScript.Arguments(1)) >"%temp%\input.vbs"
for /f "tokens=* delims=" %%a in ('cscript //nologo "%temp%\input.vbs" "%message%" "%heading%"') do (
    set "input=%%a"
)
exit /b
::***************************************************************************
:PS_Sub $notifyicon $time $title $text $icon $Timeout
PowerShell  ^
  [reflection.assembly]::loadwithpartialname('System.Windows.Forms') ^| Out-Null; ^
 [reflection.assembly]::loadwithpartialname('System.Drawing') ^| Out-Null; ^
 $notify = new-object system.windows.forms.notifyicon; ^
  $notify.icon = [System.Drawing.SystemIcons]::%1; ^
  $notify.visible = $true; ^
  $notify.showballoontip(%2,%3,%4,%5); ^
  Start-Sleep -s %6; ^
  $notify.Dispose()
%End PowerShell%
exit /B
::****************************************************************************
:MakeCopy <Source> <Target>
If Not Exist "%~2\" MD "%~2\"
Copy /Y "%~1" "%~2\"
goto :eof
::****************************************************************************
:CopyFiles
cls
mode con cols=80 lines=20
for /L %%i in (1,1,%Count%) do (
    echo Copying "!list[%%i]!" "%NewFolder2Copy%\"
    Call :MakeCopy  "!listpath[%%i]!" "%NewFolder2Copy%">nul 2>&1
)
Call :Explorer "%NewFolder2Copy%\"
Goto:Display_Results
::*****************************************************************************
