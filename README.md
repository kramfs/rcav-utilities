PowerCLI script to create the Role RightScaleRole and the minimum required permissions for RCAV to work with vCenter. 


Prerequisite
-------------
If running on Windows, set Powershell remote execution policy is enabled. Open a command prompt and type the following commands in sequence:

`powershell <Enter>cc
Set-ExecutionPolicy RemoteSigned <Enter>
Exit <Enter>`

<ol>Download vSphere PowerCLI from the Download page of the VMware Web site and install the vSphere PowerCLI software. This is also available for other platforms</ol>

<t> Powershell - https://github.com/PowerShell/PowerShell </t>
<t> PowerCLI - https://labs.vmware.com/flings/powercli-core </t>

Usage
-------------

`.\Create_RightScale_Role.ps1 -vCenter vCenterFQDNorIP -Username RS_Accountt -Domain AuthenticationDomain`

`.\Create_RightScale_Role.ps1 -vCenter "vcenter.rightscale.local" -Username rightscale_user -Domain vsphere.local`
