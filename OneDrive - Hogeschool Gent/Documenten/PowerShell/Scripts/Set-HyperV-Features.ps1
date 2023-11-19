# Set-HyperV-Features.ps1 - Turn Hyper-V, WSL2, Docker, ... on or off
#
# Usage: Set-HyperV-Features.ps1 -Command on|off|status
#

#---------- Parameters --------------------------------------------------------

param(
    [validateset('Status','On','Off','Help')] $Command='Status'
)

#---------- Variables ---------------------------------------------------------

$featureList = @( 
    "Containers",
    "HypervisorPlatform"
    "Microsoft-Hyper-V-All",
    "Microsoft-Windows-Subsystem-Linux",
    "VirtualMachinePlatform"
)

#---------- Functions ---------------------------------------------------------

# check if the script is running as administrator
function Test-Administrator {
    $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

    if (-not $isAdmin) {
        write-host "Please run this script as administrator"
        exit
    }
}

# Get the current status of the virtualization features
function Get-HyperV-Features {
    $features = Get-WindowsOptionalFeature -Online | Where-Object {$_.FeatureName -in $featureList}
    $features | Select-Object -Property FeatureName, State | Format-Table -AutoSize
}

# Enable the virtualization features
function Enable-HyperV-Features {

    Write-Host "Enabling virtualization features..."

    foreach ($feature in $featureList) {
        Enable-WindowsOptionalFeature -Online -FeatureName $feature -NoRestart
    }

    Write-Host "Done. Restart the computer to apply the changes."
}

# Disable the virtualization features
function Disable-HyperV-Features {

    Write-Host "Disabling virtualization features..."

    foreach ($feature in $featureList) {
        Disable-WindowsOptionalFeature -Online -FeatureName $feature -NoRestart
    }

    Write-Host "Done. Restart the computer to apply the changes."
}

#---------- Script proper -----------------------------------------------------

Test-Administrator

# Parse command line arguments
switch ($Command) {
    'On' { Enable-HyperV-Features }
    'Off' { Disable-HyperV-Features }
    'Status' { Get-HyperV-Features }
    Default { Write-Host "Usage: Set-HyperV-Features.ps1 on|off|status|help" }
}
