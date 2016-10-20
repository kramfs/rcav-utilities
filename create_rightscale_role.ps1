# PowerCLI script to create the Role RightScaleRole and the minimum required permissions for RCAV to work with vCenter
# ASSUMPTION: The user to be assign to the Role is already available, so create this in advance

# Required Parameters
param(
 [string]$vCenter,
 [string]$Username,
 [string]$Domain
)

clear-host

# USAGE
$usage = "Create_RightScale_Role.ps1 -vCenter vCenterFQDNorIP -Username RS_Accountt -Domain AuthenticationDomain"
$example = 'Create_RightScale_Role.ps1 -vCenter "vcenter.rightscale.local" -Username rightscale_user -Domain vsphere.local' 

Write-Host "Create the RightScaleRole and add the minimum required permissions for RCAV to work with vCenter" -ForeGroundColor Cyan 

if ( !$vCenter -or !$Username -or !$Domain ) {
  write-host `n `n"Missing Required Parameter - vCenter, Username, and Domain are required." `n -ForeGroundColor Red
  write-host "Usage: $usage" `n
  write-host "Example: $example" `n
  exit
}

# vCenter IP or FQDN 
$vCenterFQDN = $vCenter

# The account to tbe used for connecting from RCAV to vCenter to use. 
$RS_User = "$Domain\$Username"

# RightScale Role Name
$RightScale_Role = "RightScaleRole"

# Minimum required privileges to assign to the RightScale role
$RS_Privileges = @(
'System.Anonymous',
'System.View',
'System.Read',
'Global.CancelTask',
'Global.Licenses',
'Folder.Create',
'Folder.Delete',
'Datastore.Rename',
'Datastore.Move',
'Datastore.Delete',
'Datastore.Browse',
'Datastore.DeleteFile',
'Datastore.FileManagement',
'Datastore.AllocateSpace',
'Datastore.Config',
'Datastore.UpdateVirtualMachineFiles',
'Datastore.UpdateVirtualMachineMetadata',
'Network.Assign',
'Host.Local.CreateVM',
'Host.Local.ReconfigVM',
'Host.Local.DeleteVM',
'VirtualMachine.Inventory.Create',
'VirtualMachine.Inventory.CreateFromExisting',
'VirtualMachine.Inventory.Register',
'VirtualMachine.Inventory.Delete',
'VirtualMachine.Inventory.Unregister',
'VirtualMachine.Inventory.Move',
'VirtualMachine.Interact.PowerOn',
'VirtualMachine.Interact.PowerOff',
'VirtualMachine.Interact.Suspend',
'VirtualMachine.Interact.Reset',
'VirtualMachine.Interact.AnswerQuestion',
'VirtualMachine.Interact.ConsoleInteract',
'VirtualMachine.Interact.DeviceConnection',
'VirtualMachine.Interact.SetCDMedia',
'VirtualMachine.Interact.SetFloppyMedia',
'VirtualMachine.Interact.ToolsInstall',
'VirtualMachine.Interact.GuestControl',
'VirtualMachine.Interact.DefragmentAllDisks',
'VirtualMachine.Interact.CreateSecondary',
'VirtualMachine.Interact.TurnOffFaultTolerance',
'VirtualMachine.Interact.MakePrimary',
'VirtualMachine.Interact.TerminateFaultTolerantVM',
'VirtualMachine.Interact.DisableSecondary',
'VirtualMachine.Interact.EnableSecondary',
'VirtualMachine.Interact.Record',
'VirtualMachine.Interact.Replay',
'VirtualMachine.Interact.Backup',
'VirtualMachine.Interact.CreateScreenshot',
'VirtualMachine.Interact.PutUsbScanCodes',
'VirtualMachine.Interact.SESparseMaintenance',
'VirtualMachine.GuestOperations.Query',
'VirtualMachine.GuestOperations.Modify',
'VirtualMachine.GuestOperations.Execute',
'VirtualMachine.Config.Rename',
'VirtualMachine.Config.Annotation',
'VirtualMachine.Config.AddExistingDisk',
'VirtualMachine.Config.AddNewDisk',
'VirtualMachine.Config.RemoveDisk',
'VirtualMachine.Config.RawDevice',
'VirtualMachine.Config.HostUSBDevice',
'VirtualMachine.Config.CPUCount',
'VirtualMachine.Config.Memory',
'VirtualMachine.Config.AddRemoveDevice',
'VirtualMachine.Config.EditDevice',
'VirtualMachine.Config.Settings',
'VirtualMachine.Config.Resource',
'VirtualMachine.Config.UpgradeVirtualHardware',
'VirtualMachine.Config.ResetGuestInfo',
'VirtualMachine.Config.AdvancedConfig',
'VirtualMachine.Config.DiskLease',
'VirtualMachine.Config.SwapPlacement',
'VirtualMachine.Config.DiskExtend',
'VirtualMachine.Config.ChangeTracking',
'VirtualMachine.Config.Unlock',
'VirtualMachine.Config.QueryUnownedFiles',
'VirtualMachine.Config.ReloadFromPath',
'VirtualMachine.Config.QueryFTCompatibility',
'VirtualMachine.Config.MksControl',
'VirtualMachine.Config.ManagedBy',
'VirtualMachine.State.CreateSnapshot',
'VirtualMachine.State.RevertToSnapshot',
'VirtualMachine.State.RemoveSnapshot',
'VirtualMachine.State.RenameSnapshot',
'VirtualMachine.Hbr.ConfigureReplication',
'VirtualMachine.Hbr.ReplicaManagement',
'VirtualMachine.Hbr.MonitorReplication',
'VirtualMachine.Provisioning.Customize',
'VirtualMachine.Provisioning.Clone',
'VirtualMachine.Provisioning.PromoteDisks',
'VirtualMachine.Provisioning.CreateTemplateFromVM',
'VirtualMachine.Provisioning.DeployTemplate',
'VirtualMachine.Provisioning.CloneTemplate',
'VirtualMachine.Provisioning.MarkAsTemplate',
'VirtualMachine.Provisioning.MarkAsVM',
'VirtualMachine.Provisioning.ReadCustSpecs',
'VirtualMachine.Provisioning.ModifyCustSpecs',
'VirtualMachine.Provisioning.DiskRandomAccess',
'VirtualMachine.Provisioning.DiskRandomRead',
'VirtualMachine.Provisioning.GetVmFiles',
'VirtualMachine.Provisioning.PutVmFiles',
'VirtualMachine.Namespace.Management',
'VirtualMachine.Namespace.Query',
'VirtualMachine.Namespace.ModifyContent',
'VirtualMachine.Namespace.ReadContent',
'VirtualMachine.Namespace.Event',
'VirtualMachine.Namespace.EventNotify',
'Resource.AssignVMToPool',
'Resource.ApplyRecommendation',
'Resource.CreatePool',
'Resource.EditPool',
'Resource.MovePool',
'Resource.DeletePool',
'VApp.Import',
'StoragePod.Config',
'StorageProfile.View',
'StorageProfile.Update')

Write-Host "Connecting to vCenter at $vCenterFQDN"`n -ForeGroundColor Cyan
Connect-VIServer $vCenterFQDN | Out-Null
#Connect-VIServer -Protocol https -Server FQDN_or_IP_of_VMhost -User root -Password your_password


Write-Host "Create New $RightScale_Role Role"`n -ForeGroundColor Cyan 
New-VIRole -Name $RightScale_Role  -Privilege (Get-VIPrivilege -id $RS_Privileges) | Out-Null

Write-Host "Set Permissions for $RS_User using the new $RightScale_Role Role"`n -ForeGroundColor Cyan

# Get the Root Folder
$rootFolder = Get-Folder -NoRecursion

# Create the Permission, set it at the vCenter level
New-VIPermission -Entity $rootFolder -Principal $RS_User -Role $RightScale_Role -Propagate:$true | Out-Null

# Disconnect from the vCenter Server
Write-Host "Done....disconnecting from vCenter at $vCenterFQDN"`n -ForeGroundColor Cyan
Disconnect-VIServer $vCenterFQDN -Confirm:$false