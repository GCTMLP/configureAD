Write-Host "Enter  domain name"
$domainName=Read-Host
Write-Host "Enter NetBIOS name"
$domainNetName=Read-Host
Write-Host "Enter admin password"
$securityPswd=Read-Host
Write-Host "Enter IP addres for DNS-server"
$dnsIp=Read-Host

#installing the dispatcher of Active Directory 
Import-Module ServerManager
Add-WindowsFeature AD-Domain-Services -IncludeAllSubFeature -IncludeManagementTools
Import-Module ADDSDeployment

#creating a new forest for our domain. 
Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath 'C:\Windows\NTDS' -DomainMode Win2012R2 -DomainName $domainName -DomainNetbiosName $domainNetName -ForestMode Win2012R2 -InstallDns:$true -LogPath 'C:\Windows\NTDS' -NoRebootOnCompletion:$false -SysvolPath 'C:\Windows\SYSVOL' -Force:$true -SafeModeAdministratorPassword(convertto-securestring $securityPswd -asplain -force)

#installing IP-address for DNS-server
Set-DnsClientServerAddress -InterfaceAlias Ethernet0 -ServerAddresses $dnsIp

#restarting
Restart-Computer