#create image registry
$env:CLUSTER_REGISTRY_NAME="rancher-registry"

k3d registry list

k3d registry create ${env:CLUSTER_REGISTRY_NAME} --port 0.0.0.0:5111

k3d registry list

date