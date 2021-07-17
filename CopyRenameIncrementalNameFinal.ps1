function Get-File($initialDirectory) {
    [void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    if ($initialDirectory) { $OpenFileDialog.initialDirectory = $initialDirectory }
    $OpenFileDialog.filter = 'All files (*.*)|*.*'
    [void] $OpenFileDialog.ShowDialog()
    return $OpenFileDialog.FileName
}

$OrigFilePath = Get-File
$OrigFileName = (Get-ChildItem $OrigFilePath).Name
$OrigFileBname = (Get-ChildItem $OrigFilePath).Basename
$OrigFileExtns = (Get-ChildItem $OrigFilePath).Extension
$DestFolder = $PSScriptRoot
if (Test-Path $OrigFileName)
{ 
    if ($OrigFileName -match '^\D+?(\d{4})\.\w{2,4}$') {
        $filenameYear = $OrigFileName -replace '^\D+?(\d{4})\.\w{2,4}$','$1'
        for($i=1; $i -le 3; $i++){
            $NewFileName = $OrigFileName -replace $filenameYear, ([int]$filenameYear + $i).ToString()
            Copy-Item -path $OrigFilePath -destination $DestFolder"\"$NewFileName
        }
    } else {
        for($j=1; $j -le 3; $j++){
            $NewFileName1 = $OrigFileName + '-' + $j
            $NewFileName2 = $OrigFileBname + '-' + $j + $OrigFileExtns
            Copy-Item -path $OrigFilePath -destination $DestFolder"\"$NewFileName1
            Copy-Item -path $OrigFilePath -destination $DestFolder"\"$NewFileName2
        }
    }
}