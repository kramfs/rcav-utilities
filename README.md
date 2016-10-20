PowerCLI script to create the Role RightScaleRole and the minimum permissions for RCAV to work with vCenter per the requirements in http://docs.rightscale.com/rcav/v2.0/rcav_prepare_vsphere_environment.html#vcenter-access-requirements-create-a-rightscale-role


Prerequisite
-------------
If running on Windows, set Powershell remote execution policy is enabled. Open a command prompt and type the following commands in sequence:

`powershell <Enter>

Set-ExecutionPolicy RemoteSigned <Enter>

Exit <Enter>`

Download vSphere PowerCLI from the Download page of the VMware Web site and install the vSphere PowerCLI software. This is also available for other platforms

<t> Powershell - https://github.com/PowerShell/PowerShell </t>

<t> PowerCLI - https://labs.vmware.com/flings/powercli-core </t>

Usage
-------------

`.\create_rightscale_role.ps1 -vCenter vCenterFQDNorIP -Username RS_Account -Domain AuthenticationDomain`

`.\create_rightscale_role.ps1 -vCenter "vcenter.rightscale.local" -Username rightscale_user -Domain vsphere.local`
