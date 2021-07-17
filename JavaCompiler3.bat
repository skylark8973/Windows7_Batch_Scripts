<#: batch portion (begins with PowerShell multi-line comment block)
@echo off & setlocal
Set "InitialDir=%CD%"
Echo InitialDir=%InitialDir%
For /f "delims=" %%A in (
 'powershell -noprofile -NoLogo "iex (${%~f0} | out-string)"'
) Do Set "File=%%A

Echo You selected file %file%
Pause

Exit /b

: ---------------- end batch / begin PowerShell hybrid  --------------------#>

[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$OpenFileDialog.initialDirectory = $Env:initialDir
$OpenFileDialog.filter = "Text (*.txt) | *.txt | All Files| *.*"
# $OpenFileDialog.filter = "Java File (*.java) | *.java | All Files| *.*"
$OpenFileDialog.ShowDialog() | Out-Null
$OpenFileDialog.filename
