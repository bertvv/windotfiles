# PowerShell $PROFILE

#---------- Functions ---------------------------------------------------------

# Import-Module if not already loaded
function Ensure-Imported
{
  Param( [parameter(Mandatory = $true)][alias("Module")][string]$ModuleName)
  $LoadedModules = Get-Module | Select-Object Name
  if (!$LoadedModules -like "*$ModuleName*") {Import-Module -Name $ModuleName}
}

#---------- Modules -----------------------------------------------------------

Ensure-Imported Terminal-Icons
Ensure-Imported PSReadLine
Ensure-Imported CompletionPredictor

#---------- Variables ---------------------------------------------------------

$Docroot = "${env:USERPROFILE}\OneDrive - Hogeschool Gent\Documenten"
$ProfileDir = "${env:USERPROFILE}\OneDrive - Hogeschool Gent\Documenten\PowerShell"
$omp = "${env:USERPROFILE}\AppData\Local\Programs\oh-my-posh\bin"

#---------- Load oh-my-posh ---------------------------------------------------

& "${omp}\oh-my-posh" init pwsh --config "${ProfileDir}\agnosterplus.omp.json" | Invoke-Expression

#---------- PSReadLine settings -----------------------------------------------
# See
# - https://devblogs.microsoft.com/powershell/announcing-psreadline-2-1-with-predictive-intellisense/?WT.mc_id=-blog-scottha
# - https://learn.microsoft.com/en-us/powershell/scripting/learn/shell/using-predictors?view=powershell-7.3

Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

#---------- Define Aliases ----------------------------------------------------

# Git
function s { git status }
function c { git commit -m $args }
function p { git push $args }
function a { git add $args }
function d { git diff $args }
function h { git log --pretty='format:%C(yellow)%h %C(blue)%ad %C(reset)%s%C(red)%d %C(green)%an%C(reset), %C(cyan)%ar' --date=short --graph }

# Vagrant
function v { vagrant $args }
function vD { vagrant destroy -f $args }
function vd { vagrant destroy $args }
function vh { vagrant halt $args }
function vp { vagrant provision $args }
function vr { vagrant reload $args }
function vS { vagrant ssh $args }
function vs { vagrant status }
function vu { vagrant up $args }

# Go to often used directories
function docs   { Set-Location $Docroot }
function bp     { Set-Location $Docroot\Vakken\Bachelorproef }
function dsai   { Set-Location $Docroot\Vakken\DataScienceAI }
function devops { Set-Location $Docroot\Vakken\DevopsProjectOperations }
function infra  { Set-Location $Docroot\Vakken\InfrastructureAutomation }
function linux  { Set-Location $Docroot\Vakken\Linux }
function ozt    { Set-Location $Docroot\Vakken\ResearchMethods }
function stage  { Set-Location $Docroot\Vakken\Stage }
 