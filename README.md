# configureAD
Для автоматизированной настройки Active Directory необходимо по очереди запускать скрипты 
1) network_and_name.ps1
2) AD_and_dns.ps1
3) DNS_zone_DHCP_server.ps1

По окончании работы каждого скрипта происходит перезагрузка системы, так как она требуется для завершения некоторых настроек

Параметры настройки будет предложено ввести вручную в консоль при запуске каждого скритпта
