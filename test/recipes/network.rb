# commandline example
#
# netsh interface ip set address Ethernet static 192.168.0.101 255.255.255.0 192.168.0.1
# netsh interface ip add dns Ethernet 208.67.222.222
# netsh interface ip add dns Ethernet 208.67.220.220 index=2
#
# powershell syntax (slecht gedocumenteerd commandlet!)
=begin

https://technet.microsoft.com/en-us/library/hh826151(v=wps.630).aspx

Parameter Set: Query (cdxml)

Set-NetIPAddress [[-IPAddress] <String[]> ] [-AddressFamily <AddressFamily[]> ] [-AddressState <AddressState[]> ] [-AsJob] [-CimSession <CimSession[]> ] [-IncludeAllCompartments] [-InterfaceAlias <String[]> ] [-InterfaceIndex <UInt32[]> ] [-PassThru] [-PolicyStore <String> ] [-PreferredLifetime <TimeSpan> ] [-PrefixLength <Byte> ] [-PrefixOrigin <PrefixOrigin[]> ] [-SkipAsSource <Boolean> ] [-SuffixOrigin <SuffixOrigin[]> ] [-ThrottleLimit <Int32> ] [-Type <Type[]> ] [-ValidLifetime <TimeSpan> ] [-Confirm] [-WhatIf] [ <CommonParameters>]	
New-NetIPAddress –InterfaceAlias “Ethernet” –IPv4Address “192.168.0.1” –PrefixLength 24 -DefaultGateway 192.168.0.254

Set-DnsClientServerAddress -InterfaceAlias "Ethernet” -ServerAddresses 192.168.0.1, 192.168.0.2

om dit te laten werken op EC2 nieuwe VPC aanmaken, nieuwe subnet, RDP and local traffic openzetten, DHCP uit, DNS resolution is ?.

JSON van AWSOpsworks is niet bruikbaar om variabelen door te geven, gebruik dus recipes of een template/variabelen bestand om parameters mee te geven.

eenvoudig stappenplan
voorbereiding (kan dit met cloudformation?):
0. create nieuwe stack die naar nieuwe VPC/Subnet wijst
1. nieuwe VPC?
2. nieuw subnet in nieuwe VPC
- kies IPrange
 -dhcp
 -dns
 3. Netwerk en reguliere ACL's aanpassen zodat RDP(myip) en lokaal verkeer(local/any/any) toegestaan zijn.
 4. instances klaarzetten in opsworks in het juiste subnet en VPC

implementatie vh script
stel statisch adress in op de server (192.168.0.5/24, gateway 192.168.0.1?, dns: ?)

kies domeinnaam (test.local)
installeer dhcp 
installeer DNS, inclusief forwarders
pas netwerk aan om lokaal dns te gebruiken
rename server (dc01)
install ad-ds
install ad ds tools
'dcpromo'
new forest (test)
new domein (test)
DSRM password  (uitzoeken hoe )
=end


