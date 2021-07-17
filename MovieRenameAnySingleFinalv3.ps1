# param(
#     [ValidateScript({
#         $TempPath = $_ -Replace "[","``["
#         $TempPath = $TempPath -Replace "]","``]"
#         Write-Host $TempPath
#         if(-Not ($TempPath | Test-Path) ){
#             throw "File or folder does not exist"
#         }
#         if(-Not ($TempPath | Test-Path -PathType Leaf) ){
#             throw "The Path argument must be a file. Folder paths are not allowed."
#         }
#         if($_ -notmatch "(\.mkv|\.mp4|\.mov|\.flv|\.avi|\.wmv|\.webm)"){
#             throw "The file specified in the path argument must be video type"
#         }
#         return $true
#     })]
#     [System.IO.FileInfo]$Path
# )
param([System.IO.FileInfo]$Path)
$DebugPreference = 'Continue'

Function MovieRename($File) {
    $FilenameParts = $File.Name.Split('.');
    If ($File.Name.Split(' ').GetUpperBound(0) -gt $File.Name.Split('.').GetUpperBound(0))
    {
        $FilenameParts = $File.Name.Split(' ');
    }
    $FilenameFinalParts = @()
    Foreach ($FilenamePart In $FilenameParts) {
        $FilenameFinalParts += $FilenamePart
        If ($FilenamePart -Match '^[2]\d{3}$') { Break }
    }
    $FilenameFinal = ($FilenameFinalParts -Join ' ').ToUpper() + $File.Extension
    $FileFolder = Split-Path $File.FullName
    Set-Location -LiteralPath $FileFolder
    LS | Where {$_.Length -lt 2kb} | Remove-Item -Force
    Return Rename-Item -LiteralPath $File.FullName -NewName $FilenameFinal
}

MovieRename($Path)
[Environment]::Exit(1)
