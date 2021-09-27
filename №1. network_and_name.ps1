Write-Host "Enter IP"
$ipAdress=Read-Host
Write-Host "Enter default gateway"
$deafaultGateway=Read-Host
Write-Host "Enter decimal subnet mask"
$prefixLength=Read-Host
Write-Host "Enter computer name"
$compName=Read-Host

#deleting existing network parameters
Remove-NetIPAddress -InterfaceAlias Ethernet0
Remove-NetRoute  -DestinationPrefix 0.0.0.0/0

#installing the seed card and disabling DHCP
Set-NetIPInterface -InterfaceAlias Ethernet0 -Dhcp Disabled

#setting network parameters
New-NetIPAddress -IPAddress $ipAdress -DefaultGateway $deafaultGateway -PrefixLength $prefixLength -InterfaceAlias Ethernet0
Clear-DnsClientCache

#renaming the computer and restart to perform all the settings
Rename-Computer -NewName $compName -Restart