# PowerShell $PROFILE
#
# Inspired by Scott Hanselman's video <https://youtu.be/VT2L1SXFq9U>
# His PS profile: <https://gist.github.com/shanselman/25f5550ad186189e0e68916c6d7f44c3>

using namespace System.Management.Automation
using namespace System.Management.Automation.Language

#---------- Functions ---------------------------------------------------------

# Import-Module if not already loaded
function Ensure-Imported
{
  Param( [parameter(Mandatory = $true)][alias("Module")][string]$ModuleName)
  $LoadedModules = Get-Module | Select-Object Name
  if (!$LoadedModules -like "*$ModuleName*") {Import-Module -Name $ModuleName}
}

#---------- Variables ---------------------------------------------------------

$Docroot = "${env:USERPROFILE}\OneDrive - Hogeschool Gent\Documenten"
$ProfileDir = "${env:USERPROFILE}\OneDrive - Hogeschool Gent\Documenten\PowerShell"

#---------- Powerline prompt --------------------------------------------------
# Source: https://docs.microsoft.com/nl-be/windows/terminal/tutorials/powerline-setup

# Set predefined oh-my-posh theme:
# Other themes can be found in  C:\Users\bertv\AppData\Local\Programs\oh-my-posh\themes

# Set custom oh-my posh definition:
oh-my-posh init pwsh --config "${ProfileDir}\agnosterplus.omp.json" | Invoke-Expression

#---------- PSReadLine settings -----------------------------------------------
# See
# - https://devblogs.microsoft.com/powershell/announcing-psreadline-2-1-with-predictive-intellisense/?WT.mc_id=-blog-scottha
# - https://learn.microsoft.com/en-us/powershell/scripting/learn/shell/using-predictors?view=powershell-7.3

if ($host.Name -eq 'ConsoleHost')
{
  Import-Module PSReadLine
  Import-Module CompletionPredictor
}

Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
        [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
        $Local:word = $wordToComplete.Replace('"', '""')
        $Local:ast = $commandAst.ToString().Replace('"', '""')
        winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}

Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit

#---------- Terminal icons ----------------------------------------------------

Import-Module Terminal-Icons

#---------- Define Aliases ----------------------------------------------------

# Git
function s { git status }
function c { git commit -m $args }
function p { git push $args }
function a { git add $args }
function d { git diff $args }
function l { git log --pretty='format:%C(yellow)%h %C(blue)%ad %C(reset)%s%C(red)%d %C(green)%an%C(reset), %C(cyan)%ar' --date=short --graph }

# Vagrant
function v { vagrant $args }
function vdd { vagrant destroy -f $args }
function vd { vagrant destroy $args }
function vh { vagrant halt $args }
function vp { vagrant provision $args }
function vr { vagrant reload $args }
function vss { vagrant ssh $args }
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
 