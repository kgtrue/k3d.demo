# Default env vars
$env:RANCHER_SERVER_HOSTNAME="rancher.localhost"
date

# Install Rancher
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
helm repo update
kubectl create namespace cattle-system
helm install rancher rancher-latest/rancher --namespace cattle-system --set hostname=${env:RANCHER_SERVER_HOSTNAME} --wait
kubectl -n cattle-system rollout status deploy/rancher
date