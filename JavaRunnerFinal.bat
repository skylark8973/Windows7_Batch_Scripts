<# : chooser.bat
:: launches a File... Open sort of file chooser and outputs choice(s) to the console
:: https://stackoverflow.com/a/15885133/1683264

@echo off
setlocal

for /f "delims=" %%I in ('powershell -noprofile "iex (${%~f0} | out-string)"') do (
    :: %~dp0\JDK64\bin\java.exe -cp ";%~dp0.;"
    :: "%ProgramFiles(x86)%\Common Files"\Oracle\Java\javapath\java.exe -version
    java.exe -Xdiag %%~nI
)
pause>nul
goto :EOF

: end Batch portion / begin PowerShell hybrid chimera #>

Add-Type -AssemblyName System.Windows.Forms
$f = new-object Windows.Forms.OpenFileDialog
$f.InitialDirectory = pwd
# $f.Filter = "Text Files (*.txt)|*.txt|All Files (*.*)|*.*"
$f.Filter = "Java Source (*.class)|*.class|All Files (*.*)|*.*"
$f.ShowHelp = $true
$f.Multiselect = $true
[void]$f.ShowDialog()
if ($f.Multiselect) { $f.FileNames } else { $f.FileName }
