# https://rancher.com/docs/rancher/v2.x/en/installation/k8s-install/helm-rancher/
# Install cert-manager with helm
helm repo add jetstack https://charts.jetstack.io
helm repo update
kubectl create namespace cert-manager
helm install cert-manager jetstack/cert-manager --namespace cert-manager --version v1.0.4 --set installCRDs=true --wait
kubectl -n cert-manager rollout status deploy/cert-manager
date