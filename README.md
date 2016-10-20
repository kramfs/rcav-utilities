PowerCLI script to create the Role RightScaleRole and the minimum required permissions for RCAV to work with vCenter


Prerequisite
-------------
1. Powershell remote execution policy is enabled. Open a command prompt and type the following commands in sequence:

powershell <Enter>
Set-ExecutionPolicy RemoteSigned <Enter>
Exit <Enter>

2. Download vSphere PowerCLI from the Download page of the VMware Web site and install the vSphere PowerCLI software. 


Usage
-------------

`.\Create_RightScale_Role.ps1 -vCenter vCenterFQDNorIP -Username RS_Accountt -Domain AuthenticationDomain`

`.\Create_RightScale_Role.ps1 -vCenter "vcenter.rightscale.local" -Username rightscale_user -Domain vsphere.local`
