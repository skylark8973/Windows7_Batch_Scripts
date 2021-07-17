<# :
@echo off & setlocal
Call :FolderChooser
Call :FileChooser
Call :EndScript

:EndScript
pause>nul && exit /b

:FolderChooser
:: launches a folder chooser and outputs choice to the console
:: https://stackoverflow.com/a/15885133/1683264
set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"
setlocal enabledelayedexpansion
echo You chose !folder!
endlocal

:FileChooser
:: launches a File... Open sort of file chooser and outputs choice(s) to the console
:: https://stackoverflow.com/a/15885133/1683264
for /f "delims=" %%I in ('powershell -noprofile "iex (${%~f0} | out-string)"') do (
    echo You chose %%~I
)
goto :EOF
: end Batch portion / begin PowerShell hybrid chimera #>
Add-Type -AssemblyName System.Windows.Forms
$f = new-object Windows.Forms.OpenFileDialog
$f.InitialDirectory = pwd
$f.Filter = "Text Files (*.txt)|*.txt|All Files (*.*)|*.*"
$f.ShowHelp = $true
$f.Multiselect = $true
[void]$f.ShowDialog()
if ($f.Multiselect) { $f.FileNames } else { $f.FileName }
