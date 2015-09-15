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

<how to install a DC>
To install a new forest, you must be logged on as the local Administrator for the computer.
To install a new child domain or new domain tree, you must be logged on as a member of the Enterprise Admins group.
To install an additional domain controller in an existing domain, you must be a member of the Domain Admins group.

Start with adding the role using Windows PowerShell. This command installs the AD DS server role and installs the AD DS and AD LDS server administration tools, including GUI-based tools
 such as Active Directory Users and Computers and command-line tools such as dcdia.exe. Server administration tools are not installed by default when you use Windows PowerShell. You need 
 to specify –IncludeManagementTools to manage the local server or install Remote Server Administration Tools to manage a remote server.

<<Windows PowerShell cmdlet and arguments>> There is no reboot required until after the AD DS installation is complete.
Install-windowsfeature -name AD-Domain-Services –IncludeManagementTools

To override default (True) values, you can specify the argument with a $False value. For example, because -installdns is automatically run for a new forest installation if it is not specified, the only
way to prevent DNS installation when you install a new forest is to use:
-InstallDNS:$false

Similarly, because –installdns has a default value of $False if you install a domain controller in an environment that does not host Windows Server DNS server, you need to specify the following argument
in order to install DNS server:
-InstallDNS:$true

SafeModeAdministratorPassword <securestring>
Supplies the password for the administrator account when the computer is started in Safe Mode or a variant of Safe Mode, such as Directory Services Restore Mode.
The default is an empty password. You must supply a password. The password must be supplied in a System.Security.SecureString format, such as that provided by read-host -assecurestring or
ConvertTo-SecureString.
The SafeModeAdministratorPassword argument's operation is special:If not specified as an argument, the cmdlet prompts you to enter and confirm a masked password. This is the preferred usage when 
running the cmdlet interactively.If specified without a value, and there are no other arguments specified to the cmdlet, the cmdlet prompts you to enter a masked password without confirmation. 
This is not the preferred usage when running the cmdlet interactively.If specified with a value, the value must be a secure string. This is not the preferred usage when running the cmdlet interactively.
For example, you can manually prompt for a password by using the Read-Host cmdlet to prompt the user for a secure string:-safemodeadministratorpassword (read-host -prompt "Password:" -assecurestring)You 
can also provide a secure string as a converted clear-text variable, although this is highly discouraged. -safemodeadministratorpassword (convertto-securestring "Password1" -asplaintext -force)

The command syntax for installing a new forest is as follows. Optional arguments appear within square brackets.
Install-ADDSForest [-SkipPreChecks] –DomainName <string> -SafeModeAdministratorPassword <SecureString> [-CreateDNSDelegation] [-DatabasePath <string>] [-DNSDelegationCredential <PS Credential>] [-NoDNSOnNetwork] [-DomainMode <DomainMode> {Win2003 | Win2008 | Win2008R2 | Win2012}] [-DomainNetBIOSName <string>] [-ForestMode <ForestMode> {Win2003 | Win2008 | Win2008R2 | Win2012}] [-InstallDNS] [-LogPath <string>] [-NoRebootOnCompletion] [-SkipAutoConfigureDNS] [-SYSVOLPath] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]

The command syntax for installing an additional domain controller is as follows. Optional arguments appear within square brackets.
Install-ADDSDomainController -DomainName <string> [-SkipPreChecks] –SafeModeAdministratorPassword <SecureString> [-ADPrepCredential <PS Credential>] [-AllowDomainControllerReinstall] [-ApplicationPartitionsToReplicate <string[]>] [-CreateDNSDelegation] [-Credential <PS Credential>] [-CriticalReplicationOnly] [-DatabasePath <string>] [-DNSDelegationCredential <PS Credential>] [-NoDNSOnNetwork] [-NoGlobalCatalog] [-InstallationMediaPath <string>] [-InstallDNS] [-LogPath <string>] [-MoveInfrastructureOperationMasterRoleIfNecessary] [-NoRebootOnCompletion] [-ReplicationSourceDC <string>] [-SiteName <string>] [-SkipAutoConfigureDNS] [-SystemKey <SecureString>] [-SYSVOLPath <string>] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]

<<eenvoudig stappenplan>>

voorbereiding (kan dit met cloudformation?):
0. optioneel: create nieuwe stack die naar nieuwe VPC/Subnet wijst
1. optioneel: nieuwe VPC?
2. nieuw subnet in nieuwe? VPC
- kies IPrange
 -dhcp uit (ga ervan uit dat je zelf een dhcp inricht)
 -dns (wordt meegeinstalleerd met de AD)
 3. Netwerk en reguliere ACL's aanpassen zodat RDP(myip) en lokaal verkeer(local/any/any) toegestaan zijn, let op routing!.
 4. instances klaarzetten in opsworks in het juiste subnet en VPC.

implementatie vh script
stel statisch adress in op de server (192.168.0.5/24, gateway 192.168.0.1?, dns: ?)
rename server (dc01)
kies domeinnaam (test.local)
optioneel: installeer dhcp 
optioneel: installeer DNS, inclusief forwarders wordt automatisch gedaan door install ADDSDomaincontroller.
pas netwerk aan om lokaal dns te gebruiken
install ad-ds
install ad ds tools
reboot?
'dcpromo'
new forest (test)
new domein (test)
DSRM password  (uitzoeken hoe )
=end


