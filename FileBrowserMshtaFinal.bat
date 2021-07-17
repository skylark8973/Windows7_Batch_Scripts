@if (@a==@b) @end /*
@echo off
setlocal
for /f "delims=" %%I in ('cscript /nologo /e:jscript "%~f0"') do (
    echo You chose %%I
)
:: goto :EOF
:: JScript portion */
var shl = new ActiveXObject("Shell.Application");
var folder = shl.BrowseForFolder(0, "Please choose a folder.", 0, 0x00);
WSH.Echo(folder ? folder.self.path : '');

@if (@a==@b) @end /*
@echo off
set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
set dialog=%dialog%close();resizeTo(0,0);</script>"
for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "file=%%p"
echo selected  file is : "%file%"
pause
:: */
