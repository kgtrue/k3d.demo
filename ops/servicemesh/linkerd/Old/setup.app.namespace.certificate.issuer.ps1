$title    = 'Setup app namespace and issuer and certificate'
$question = 'This will create selfsigned issuer and certificate'
$choices  = '&Yes', '&No'
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	./setup.certificates.ps1
}