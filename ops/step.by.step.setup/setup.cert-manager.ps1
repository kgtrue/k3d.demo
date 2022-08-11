# https://rancher.com/docs/rancher/v2.x/en/installation/k8s-install/helm-rancher/
# https://cert-manager.io/docs/installation/helm/#1-add-the-helm-repository
# Install cert-manager with helm
helm repo add jetstack https://charts.jetstack.io
helm repo update
kubectl create namespace cert-manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.1/cert-manager.crds.yaml
helm install cert-manager jetstack/cert-manager --namespace cert-manager --version --version v1.9.1 --set installCRDs=true --wait
kubectl -n cert-manager rollout status deploy/cert-manager
date