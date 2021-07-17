$ScriptPathTmp = $PSScriptRoot.Replace('[','`[' ).Replace(']','`]')
$ScriptPath = "`'$ScriptPathTmp`'"
Set-Location $ScriptPathTmp
$VideoNameParts1 = (gci -fi *.mkv -name).Split('.')
$VideoNameParts = $VideoNameParts1.Split(' ')
$VideoNameOnly = @()
foreach ($VNP in $VideoNameParts) {
    if ($VNP -notmatch "^\d{4}$") {
        $VideoNameOnly += $VNP
    } else {
        $VideoNameOnly += $VNP
        Break
    }
}
$VideoNameOnly = ($VideoNameOnly -join " " -replace '(^\s+|\s+$)','' -replace '\s+',' ')
# gci -fi *.mkv | select -f 1 | ren -new ($VideoNameOnly.ToUpper() + "." + $VideoNameParts1[3])
gci -fi *.srt | select -f 1 | ren -new ($VideoNameOnly.ToUpper() + "." + $_.extension)
Read-Host
