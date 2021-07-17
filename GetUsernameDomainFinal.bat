@ECHO OFF
rem SET TNAME="net user %USERNAME% /domain| FIND /I "Full Name""
rem FOR /F "tokens=3,4 delims=, " %%A IN ('%TNAME%') DO SET DNAME=%%B %%A
rem ECHO %DNAME% - %TNAME%
rem for /f "usebackq tokens=2,* delims= " %%a in (`net user "%USERNAME%" /domain ^| find /i "Full Name"`) do set FULLNAME=%%b
for /F "skip=1 delims=" %%I in ('wmic computersystem get domain') do if not defined DOMAIN set "DOMAIN=%%~I"
ECHO %USERNAME%/%DOMAIN% / %USERNAME%\%DOMAIN%
for /F "tokens=* eol= " %%I in ("%USERNAME%\%DOMAIN%") do ( set FULLNAME=%%I )
call :Trim FULLNAME1 %FULLNAME%
echo | set /p="%FULLNAME1%" | clip && pause>nul

:Trim
SetLocal EnableDelayedExpansion
set Params=%*
for /f "tokens=1*" %%a in ("!Params!") do EndLocal & set %1=%%b
exit /b
