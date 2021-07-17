if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
Set-Location -LiteralPath $PSScriptRoot
(Get-Location).Path
$RenRsydSubs = Read-Host "Rename only resyncd subtitles ?"
If ($RenRsydSubs -match "[yY]") {
    Get-ChildItem -Filter *.srt | Where{$_.Name -NotMatch '(S\d{2}\s?E\d{2}-resync.srt)'} | Remove-Item
    ls *.srt | %{ ren -LiteralPath $_.Fullname ($_.name -replace '-resync','') }
    Read-Host
} Else {
    ls *.mkv | %{ ren -LiteralPath $_.Fullname $($_.name -replace '.*(S\d{2}\s?E\d{2}).*','$1.mkv') }
    ls *.srt | %{ ren -LiteralPath $_.Fullname ($_.name -replace '.*(S\d{2}\s?E\d{2}).*','$1.srt') }
}
