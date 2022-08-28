
$title    = 'Setup app namespace and issuer and certificate'
$question = 'This will create selfsigned issuer and certificate'
$choices  = '&Yes', '&No'

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {

.\setup.app.namespace.ps1
.\setup.certificate.issuer.ps1
.\setup.certificate.ps1
}