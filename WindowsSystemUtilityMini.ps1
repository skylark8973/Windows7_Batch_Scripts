$ScriptFolder = $PSScriptRoot
$ScriptDir = Split-Path $MyInvocation.MyCommand.Path

if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
        Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
        Exit
    }
}
Set-Location $ScriptDir; Echo 'Current Directory: ' + (Get-Location | Out-String)

function Kill-Process-Tree {
    Param([int]$ppid)
    Get-CimInstance Win32_Process | Where-Object { $_.ParentProcessId -eq $ppid } | ForEach-Object { Kill-Process-Tree $_.ProcessId }
    Stop-Process -Id $ppid -PassThru
}

Function Kill-Cleaner-Apps {
    $processes = Get-WmiObject win32_process
    Foreach ($process in $processes)
    {
        $CleanerApps = @('CCleaner.exe','CCleaner64.exe')
        If ($CleanerApps -Contains $process.Name) { Kill-Process-Tree $process.ProcessId }
    }
}

function Win-Sys-Util-Menu {
    param (
        [string]$Title = 'Windows System Utility'
    )
    Clear-Host
    Write-Host "============ $Title ==========="
    Write-Host "1: Terminate User's Processes."
    Write-Host "2: Cache/Temp Files Cleanup."
    Write-Host "3: Generic Diskspace Cleanup."
    Write-Host "Q: Exit this Application."
}

Do
{
    Win-Sys-Util-Menu
    $selection = Read-Host "Please make a selection"
    switch ($selection)
    {
        '1' {
            $ErrorActionPreference = 'SilentlyContinue'
            $processes = Get-WmiObject win32_process
            foreach ($process in $processes)
            {
                $owner = $process.GetOwner()
                $keepAlive = @('explorer.exe','powershell.exe')
                if ($owner.User -eq $Env:Username) { Kill-Process-Tree $process.ProcessId }
            }
            $ErrorActionPreference = 'Continue'
        } '2' {
            Kill-Cleaner-Apps
            $CclnrApp64 = "$Env:ProgramFiles\CCleaner\CCleaner64.exe"
            Start-Process $CclnrApp64 -ArgumentList '/Auto' -Wait
            Start-Process $CclnrApp64 -ArgumentList '/Auto' -Wait
            $RgstClnr = Start-Process $CclnrApp64 -ArgumentList '/Registry' -PassThru
            $RgstClnr | Wait-Process -Timeout 30 -ErrorAction SilentlyContinue
            Kill-Cleaner-Apps
            Stop-Process -Name Explorer -Force
        } '3' {
            $RootDrive = "$Env:SystemDrive\"
            $DrivePath = "$Env:SystemDrive\*"
            $Removables = '*.log,*.etl,*.tmp,*._mp,*.gid,*.old,*.chk,*.torrent'
            Remove-Item $RootDrive -Recurse -Include $Removables -Force
            Remove-Item $RootDrive -Recurse -Include $Removables -Force
            # Get-ChildItem $RootDrive $Removables -Recurse | Foreach { Remove-Item -LiteralPath $_.FullName -Force }
            Read-Host
        }
    }
}
Until($selection -eq 'q')
