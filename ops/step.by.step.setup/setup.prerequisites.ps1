
$title    = 'Install chocolatey'
$question = 'This will install chocolatey. Do you want to continue?'
$choices  = '&Yes', '&No'

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
# Get kubectl and helm
choco list --local-only
}

$title    = 'Install k3d'
$question = 'This will install k3d. Do you want to continue?'
$choices  = '&Yes', '&No'

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
choco install k3d -y
}

$title    = 'Install kubernetes-cli'
$question = 'kubernetes-cli. Do you want to continue?'
$choices  = '&Yes', '&No'

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
choco install kubernetes-cli -y
}

$title    = 'Install helm'
$question = 'This will install helm. Do you want to continue?'
$choices  = '&Yes', '&No'

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
choco install kubernetes-helm -y
}
