# Self-elevate the script if required


if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}


#Firewall Disable and set firewall to private as well as turn off power management for NIC

Set-PSDebug -Trace 1

Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
  $adapters = Get-NetAdapter -Physical | Get-NetAdapterPowerManagement
    foreach ($adapter in $adapters) {
        $adapter.AllowComputerToTurnOffDevice = 'Disabled'
        $adapter | Set-NetAdapterPowerManagement
        Get-NetAdapter -Name “*” -Physical 
        }


#Sleep settings disabler

Powercfg /change Standby-TimeOut-dc 0
Powercfg /change Standby-TimeOut-ac 0
Powercfg /change Monitor-TimeOut-dc 0
Powercfg /change Monitor-TimeOut-ac 0


#UAC disabler

Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0


#Below argument will not work, not sure why just auto exits when it should prompt

#if($error.count -eq 0) {
#     "The script has run without errors if you are seeing this message, close to continue"
#     }