Write-Host "enter network ip address, example: 1.1.1.0/24"
$networkId=Read-Host
Write-Host "enter dns-server ip address"
$dnsIP=Read-Host
Write-Host "enter gateway ip address"
$routerIP=Read-Host
Write-Host "enter domain name"
$domainName=Read-Host
Write-Host "enter network mask decimal"
$mask=Read-Host
$recordPtr=".in-addr.arpa"
Write-Host "enter dns reverse lookup zone (if network ip is 192.168.1.0 then enter 1.168.192)"
$backIP=Read-Host 

#setup dns reverse lookup zone
Add-DnsServerPrimaryZone -DynamicUpdate NonsecureAndSecure -NetworkId $networkId -ReplicationScope Domain
Add-DnsServerResourceRecordPtr -Name "1" -ZoneName $backIP$recordPtr -AgeRecord -PtrDomainName $domainName

Write-Host "enter name for accept ip addresses zone for DHCP-server"
$scope=Read-Host
Write-Host "enter start and end ip addresses for allowed ip addresses zone for DHCP-server"
$startIP=Read-Host
$endtIP=Read-Host
Write-Host "enter name for exclusion ip addresses zone for DHCP-server"
$exScope=Read-Host
Write-Host "enter start and end ip addresses for exclusion ip addresses zone for DHCP-server"
$starExtIP=Read-Host
$endExtIP=Read-Host

#installing the DHCP-server manager module for convenient operation in the graphical interface after installation
Import-Module ServerManager
Add-WindowsFeature -Name DHCP -IncludeManagementTools

#setup zones of allowed ip addresses
Add-DhcpServerv4Scope -Name $scope -StartRange $startIP -EndRange $endtIP -SubnetMask $mask -State Active

#setup zones of reserved ip addresses
Add-DhcpServerv4ExclusionRange -Name $exScope -StartRange $starExtIP -EndRange $endExtIP

#setup default DNS-server and gateway
Set-DhcpServerv4OptionValue -DnsServer $dnsIP -DnsDomain $domainName -Router $routerIP

#restart
Restart-Computer -Force
