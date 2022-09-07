$title    = 'Setup Scoop'
$question = 'This will install scoop'
$choices  = '&Yes', '&No'
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
	iex "& {$(irm get.scoop.sh)} -RunAsAdmin"
}

$title    = 'Setup smallstep'
$question = 'This will install smallstep'
$choices  = '&Yes', '&No'
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	scoop bucket add smallstep https://github.com/smallstep/scoop-bucket.git
	scoop install smallstep/step
}