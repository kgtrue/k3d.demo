# Default env vars
$env:RANCHER_SERVER_HOSTNAME="rancher.localhost"

$title    = 'Deploy rancher to k3d cluster'
$question = 'This will deploy rancer to k3d cluster. Do you want to continue?'
$choices  = '&Yes', '&No'

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {	

# Install Rancher
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
helm repo update
kubectl create namespace cattle-system
helm install rancher rancher-latest/rancher --namespace cattle-system --set hostname=${env:RANCHER_SERVER_HOSTNAME} --wait
kubectl -n cattle-system rollout status deploy/rancher
date

}