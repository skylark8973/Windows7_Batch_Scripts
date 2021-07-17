@echo off
net file 1>NUL 2>NUL
if not '%errorlevel%' == '0' (
    pushd %~dp0 & powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1 & popd
    exit /b
)
cd /d %1
set RegKeyName0="HKCR\CLSID\{265b1075-d22b-41eb-bc97-87568f3e6dab}"
set RegKeyName="HKEY_CLASSES_ROOT\CLSID\{265b1075-d22b-41eb-bc97-87568f3e6dab}"
set "TmpIntrntFlsDir=%LocalAppData%\Temporary Internet Files"
takeown /R /F "%TmpIntrntFlsDir%" && del /f /s /q "%TmpIntrntFlsDir%\*"
forfiles /P "%TmpIntrntFlsDir%\*" /C "if @isdir==TRUE rmdir /S /Q @file"
set TmpIntrntFlsDir1=%LocalAppData%\Temp
takeown /R /F "%TmpIntrntFlsDir1%" && del /f /s /q "%TmpIntrntFlsDir1%\*"
forfiles /P "%TmpIntrntFlsDir1%\*" /C "if @isdir==TRUE rmdir /S /Q @file"
set "TmpIntrntFlsDir2=%LocalAppData%\Microsoft\Windows\INetCache"
takeown /R /F "%TmpIntrntFlsDir2%" && del /f /s /q "%TmpIntrntFlsDir2%\*"
forfiles /P "%TmpIntrntFlsDir2%\*" /C "if @isdir==TRUE rmdir /S /Q @file"
reg query %RegKeyName% >nul 2>&1
if %errorlevel% equ 0 ( reg delete %RegKeyName% )
pause>nul
