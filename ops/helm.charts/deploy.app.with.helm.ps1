
#helm deploy
$title    = 'Deploy demo chart using default values with dry-run'
$question = 'This will not deploy demo chart'
$choices  = '&Yes', '&No'
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	echo "Commands run"
	echo "kubectl create namespace demo-app"
	echo "helm upgrade --install demo-app-release demo --namespace demo-app --dry-run"	
	kubectl create namespace demo-app
	helm upgrade --install demo-app-release demo --namespace demo-app --dry-run
}

$title    = 'Deploy demo chart using default values'
$question = 'This will deploy demo chart'
$choices  = '&Yes', '&No'
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	echo "Commands run"
	echo "helm upgrade --install demo-app-release demo --namespace demo-app"
	helm upgrade --install demo-app-release demo --namespace demo-app
}

#helm deploy
$title    = 'Deploy demo chart using default values and create namespace using helm'
$question = 'This will deploy demo chart'
$choices  = '&Yes', '&No'
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	echo "Commands run"
	echo "helm upgrade --install demo-app-release demo --namespace demo-app-2 --create-namespace"
	helm upgrade --install demo-app-release demo --namespace demo-app-2 --create-namespace
}

#helm deploy
$title    = 'Uninstall deployment demo-app-releas in namespace demo-app-2'
$question = 'This will uninstall demo chart'
$choices  = '&Yes', '&No'
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	echo "Commands run"
	echo "helm list --namespace demo-app-2"
	echo "helm uninstall demo-app-release --namespace demo-app-2"
	echo "helm list --namespace demo-app-2"	
	helm list --namespace demo-app-2
	helm uninstall demo-app-release --namespace demo-app-2
	helm list --namespace demo-app-2
}

#helm deploy
$title    = 'Deploy demo chart using foo values'
$question = 'This will deploy demo chart'
$choices  = '&Yes', '&No'
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	echo "Commands run"
	echo "helm list --namespace demo-app"
	echo "helm upgrade --install demo-app-release demo --namespace demo-app -f foo-values.yaml"
	echo "helm list --namespace demo-app"
	helm list --namespace demo-app
	helm upgrade --install demo-app-release demo --namespace demo-app -f foo-values.yaml
	helm list --namespace demo-app	
}

#helm deploy
$title    = 'Deploy demo chart using bar values'
$question = 'This will deploy demo chart'
$choices  = '&Yes', '&No'
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	echo "Commands run"
	echo "helm list --namespace demo-app"
	echo "helm upgrade --install demo-app-release demo --namespace demo-app -f bar-values.yaml"
	echo "helm list --namespace demo-app"
	helm list --namespace demo-app
	helm upgrade --install demo-app-release demo --namespace demo-app -f bar-values.yaml
	helm list --namespace demo-app	
}

#helm deploy
$title    = 'Uninstall demo chart using keep-history'
$question = 'This will uninstall demo chart'
$choices  = '&Yes', '&No'
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	echo "Commands run"
	echo "helm list --namespace demo-app"
	echo "helm uninstall demo-app-release --namespace demo-app --keep-history"
	echo "helm list --namespace demo-app"
	helm list --namespace demo-app
	helm uninstall demo-app-release --namespace demo-app --keep-history 
	helm list --namespace demo-app
}

#helm deploy
$title    = 'Deploy demo chart using foo values'
$question = 'This will deploy demo chart'
$choices  = '&Yes', '&No'
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	echo "Commands run"
	echo "helm list --namespace demo-app"
	echo "helm upgrade --install demo-app-release demo --namespace demo-app -f foo-values.yaml"
	echo "helm list --namespace demo-app"
	helm list --namespace demo-app
	helm upgrade --install demo-app-release demo --namespace demo-app -f foo-values.yaml
	helm list --namespace demo-app	
}

#helm deploy
$title    = 'Deploy demo chart using foo values with replace flag'
$question = 'This will deploy demo chart'
$choices  = '&Yes', '&No'
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	echo "Commands run"
	echo "helm list --namespace demo-app"
	echo "helm install --replace demo-app-release demo --namespace demo-app -f foo-values.yaml"
	echo "helm list --namespace demo-app"
	helm list --namespace demo-app
	helm install --replace demo-app-release demo --namespace demo-app -f foo-values.yaml
	helm list --namespace demo-app
}