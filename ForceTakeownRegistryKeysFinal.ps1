Import-Module ActiveDirectory
$myFQDN = (Get-WmiObject win32_computersystem).DNSHostName + "." + (Get-WmiObject win32_computersystem).Domain
Write-Host $myFQDN
Write-Host $Env:ComputerName
# Write-Host [System.Net.Dns]::GetHostByName($env:computerName)
Write-Host [System.Net.Dns]::GetHostByName('DESKTOP-GHII7HV').HostName
Write-Host [System.Net.Dns]::GetHostByName((hostname)).HostName
Write-Host (Get-ADComputer $(hostname)).DNSHostName
Echo [System.Net.Dns]::Resolve($null).HostName
Read-Host
