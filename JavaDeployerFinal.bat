<# : chooser.bat
:: launches a File... Open sort of file chooser and outputs choice(s) to the console
:: https://stackoverflow.com/a/15885133/1683264

@echo off
setlocal

for /f "delims=" %%I in ('powershell -noprofile "iex (${%~f0} | out-string)"') do (
    :: %~dp0\JDK64\bin\javac.exe %%~I
    :: (
    ::     echo Manifest-Version: 1.0
    ::     echo Main-Class: %%~nI
    :: )>"%%~nI.mf"
    :: %~dp0\JDK64\bin\jar.exe cmf %%~nI.mf %%~nI.jar %%~nI.class %%~nI.java
    :: %~dp0\JDK64\bin\jar.exe cvfe %%~nI.jar %%~nI.class %%~nI.java
    %~dp0\JDK64\bin\javac.exe %%~I && %~dp0\JDK64\bin\jar.exe cfe %%~nI.jar %%~nI %%~nI.class *.class
    :: %~dp0\JDK64\bin\jar.exe cfe %%~nI.jar %%~I %%~nI.class %%~nI.java
    java -jar %%~nI.jar
)
pause>nul
goto :EOF

: end Batch portion / begin PowerShell hybrid chimera #>

Add-Type -AssemblyName System.Windows.Forms
$f = new-object Windows.Forms.OpenFileDialog
$f.InitialDirectory = pwd
# $f.Filter = "Text Files (*.txt)|*.txt|All Files (*.*)|*.*"
$f.Filter = "Java Source (*.class;*.java)|*.class;*.java|All Files (*.*)|*.*"
$f.ShowHelp = $true
$f.Multiselect = $true
[void]$f.ShowDialog()
if ($f.Multiselect) { $f.FileNames } else { $f.FileName }
