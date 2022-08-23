# Default env vars
$env:CLUSTER_NAME="demo-rancher"
$env:CLUSTER_REGISTRY_NAME= ${env:CLUSTER_NAME} + "-registry"
$env:CLUSTER_REGISTRY_HOST_PORT=":0.0.0.0:62701"
$env:CLUSTER_REGISTRY_NAME_PORT= ${env:CLUSTER_REGISTRY_NAME} + ${env:CLUSTER_REGISTRY_HOST_PORT}
$env:KUBECONFIG_FILE="${env:CLUSTER_NAME}.yaml"

$title    = 'Setup k3d cluster'
$question = 'This will setup cluster named:' + ${env:CLUSTER_NAME} + ' and registry named:' + ${env:CLUSTER_REGISTRY_NAME} + ' on host and port:' + ${env:CLUSTER_REGISTRY_HOST_PORT} + ' if cluster with same name exists this script will delete it remember to add ' + ${env:CLUSTER_REGISTRY_NAME} + ' to host file. Do you want to continue?'
$choices  = '&Yes', '&No'

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	
k3d cluster stop $env:CLUSTER_NAME
k3d cluster delete $env:CLUSTER_NAME

# Create the cluster
k3d cluster create $env:CLUSTER_NAME --api-port 6550 --servers 1 --port 443:443@loadbalancer --agents 1 --registry-create $env:CLUSTER_REGISTRY_NAME_PORT --wait 

k3d cluster list
k3d kubeconfig get ${env:CLUSTER_NAME} > $env:KUBECONFIG_FILE

$env:KUBECONFIG=($env:KUBECONFIG_FILE)
kubectl get nodes

docker ps -f name=${env:CLUSTER_REGISTRY_NAME}

date
}