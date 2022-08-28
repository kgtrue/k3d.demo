# https://rancher.com/docs/rancher/v2.x/en/installation/k8s-install/helm-rancher/
# https://cert-manager.io/docs/installation/helm/#1-add-the-helm-repository
# Install cert-manager with helm

$title    = 'Deploy cert-manager to k3d cluster'
$question = 'This will deploy cert-manager to k3d cluster to namespace cert-manager. Do you want to continue?'
$choices  = '&Yes', '&No'

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
helm repo add jetstack https://charts.jetstack.io
helm repo update
kubectl create namespace cert-manager
helm install cert-manager jetstack/cert-manager --namespace cert-manager --version v1.9.1 --set installCRDs=true --wait
kubectl -n cert-manager rollout status deploy/cert-manager
}