<# : chooser.bat
@echo off
setlocal
for /f "delims=" %%I in ('powershell -noprofile "iex (${%~f0} | out-string)"') do (
    %~dp0\JDK64\bin\javac.exe %%~I && %~dp0\JDK64\bin\jar.exe cfe %%~nI.jar %%~nI %%~nI.class *.class
    java -jar %%~nI.jar
)
goto :EOF
: #>
Add-Type -AssemblyName System.Windows.Forms
$f = new-object Windows.Forms.OpenFileDialog
$f.InitialDirectory = pwd
# $f.Filter = "Text Files (*.txt)|*.txt|All Files (*.*)|*.*"
$f.Filter = "Java Source (*.class;*.java)|*.class;*.java|All Files (*.*)|*.*"
$f.ShowHelp = $true
$f.Multiselect = $true
[void]$f.ShowDialog()
if ($f.Multiselect) { $f.FileNames } else { $f.FileName }
