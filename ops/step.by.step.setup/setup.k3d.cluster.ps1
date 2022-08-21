# Default env vars
$env:CLUSTER_NAME="k3d-rancher"
$env:KUBECONFIG_FILE="${env:CLUSTER_NAME}.yaml"

k3d cluster stop $env:CLUSTER_NAME
k3d cluster delete $env:CLUSTER_NAME

# Create the cluster
k3d cluster create $env:CLUSTER_NAME --api-port 6550 --servers 1 --port 443:443@loadbalancer --agents 3 --wait 

k3d cluster list
k3d kubeconfig get ${env:CLUSTER_NAME} > $env:KUBECONFIG_FILE

$env:KUBECONFIG=($env:KUBECONFIG_FILE)

kubectl get nodes

date