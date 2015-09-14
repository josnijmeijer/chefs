# installs a clean fileserver
# 14-9-2015
# v0.1  setting up a basic file server with all features, subfeatures and tools
# Jos Nijmeijer  - OGD

# todo
# split commands in subfiles where appropriate
# figure out what is actually needed and removing all clutter
# domain join
# logfiles/dynamic naming/path


powershell_script 'Install FS' do 
	code 'Add-WindowsFeature FileAndStorage-Services -IncludeAllSubFeature -IncludeManagementTools -LogPath c:\users\administrator\.chef\installFS.log '	
	guard_interpreter :powershell_script
	not_if "(Get-WindowsFeature -Name FileAndStorage-Services).Installed"
end

powershell_script 'Install FileServices Tools' do
	code 'Add-WindowsFeature RSAT-File-Services -IncludeAllSubFeature -IncludeManagementTools -LogPath c:\users\administrator\.chef\installFSTools.log'
	guard_interpreter :powershell_script
	not_if "(Get-WindowsFeature -name RSAT-File-Services).Installed"

end

powershell_script 'Install Windows-Server-Backup' do 
	code 'Add-WindowsFeature Windows-Server-Backup -IncludeAllSubFeature -IncludeManagementTools -LogPath c:\users\administrator\.chef\installbackup.log '	
	guard_interpreter :powershell_script
	not_if "(Get-WindowsFeature -Name Windows-Server-Backup).Installed"
end

#sleep(60)

powershell_script 'Restart' do 
    code 'Restart-Computer'  
    guard_interpreter :powershell_script
end


# service 'w3svc' do
#	action [:enable, :start]
# end

=begin
[X] File And Storage Services                           FileAndStorage-Services        Installed
    [ ] File and iSCSI Services                         File-Services                  Available
        [ ] File Server                                 FS-FileServer                  Available
        [ ] BranchCache for Network Files               FS-BranchCache                 Available
        [ ] Data Deduplication                          FS-Data-Deduplication          Available
        [ ] DFS Namespaces                              FS-DFS-Namespace               Available
        [ ] DFS Replication                             FS-DFS-Replication             Available
        [ ] File Server Resource Manager                FS-Resource-Manager            Available
        [ ] File Server VSS Agent Service               FS-VSS-Agent                   Available
        [ ] iSCSI Target Server                         FS-iSCSITarget-Server          Available
        [ ] iSCSI Target Storage Provider (VDS and V... iSCSITarget-VSS-VDS            Available
        [ ] Server for NFS                              FS-NFS-Service                 Available
    [X] Storage Services                                Storage-Services               Installed

[ ] File Services Tools                         RSAT-File-Services             Available
    [ ] DFS Management Tools                    RSAT-DFS-Mgmt-Con              Available
    [ ] File Server Resource Manager Tools      RSAT-FSRM-Mgmt                 Available
    [ ] Services for Network File System Man... RSAT-NFS-Admin                 Available
    [ ] Share and Storage Management Tool       RSAT-CoreFile-Mgmt             Available

    [ ] Windows Server Backup                               Windows-Server-Backup          Available

    SYNTAX
    Install-WindowsFeature [-Name] <Feature[]> [-ComputerName <String>] [-Credential <PSCredential>]
    [-IncludeAllSubFeature [<SwitchParameter>]] [-IncludeManagementTools [<SwitchParameter>]] [-LogPath <String>]
    [-Restart [<SwitchParameter>]] [-Source <String[]>] [-Confirm [<SwitchParameter>]] [-WhatIf [<SwitchParameter>]]
    [<CommonParameters>]
=end