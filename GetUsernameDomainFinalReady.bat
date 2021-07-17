@ECHO OFF
for /F "skip=1delims=" %%I in ('wmic computersystem get domain') do if not defined DOMAIN set "DOMAIN=%%~I"
ECHO %USERNAME%/%DOMAIN% / %USERNAME%\%DOMAIN%
for /F "tokens=* eol= " %%I in ("%USERNAME%\%DOMAIN%") do ( set FULLNAME=%%I )
call :Trim FULLNAME1 %FULLNAME%
echo | set /p="%FULLNAME1%" | clip && pause>nul

:Trim
SetLocal EnableDelayedExpansion
set Params=%*
for /f "tokens=1*" %%a in ("!Params!") do EndLocal & set %1=%%b
exit /b
