# 1. setup.purge.docker
Removes all docker containers images and volumes 

**commands run**
	docker rm -f $(docker ps -qa)
	docker network prune -f
	docker network prune -f
	docker volume prune -
	docker system prune -a -f

# 2. setup.prerequisites
2.1 Setup of chocolatey
**commands run**
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

## 2.2 Setup of k3d
**commands run**
	choco install k3d -y

## 2.3 Setup of kubernetes-cli
**commands run**
	choco install kubernetes-cli -y

## 2.4 Setup helm
**commands run**
	choco install kubernetes-helm -y

# 3. setup k3d cluster
**commands run**
	$env:CLUSTER_NAME="demo-rancher"
	$env:CLUSTER_REGISTRY_NAME= ${env:CLUSTER_NAME} + "-registry"
	$env:CLUSTER_REGISTRY_HOST_PORT=":0.0.0.0:62701"
	$env:CLUSTER_REGISTRY_NAME_PORT= ${env:CLUSTER_REGISTRY_NAME} + ${env:CLUSTER_REGISTRY_HOST_PORT}
	$env:KUBECONFIG_FILE="${env:CLUSTER_NAME}.yaml"
	k3d cluster stop $env:CLUSTER_NAME
	k3d cluster delete $env:CLUSTER_NAME
	k3d cluster create $env:CLUSTER_NAME --api-port 6550 --servers 1 --port 443:443@loadbalancer --port 80:80@loadbalancer --agents 1 --registry-create $env:CLUSTER_REGISTRY_NAME_PORT --wait 
	k3d cluster list
	k3d kubeconfig get ${env:CLUSTER_NAME} > $env:KUBECONFIG_FILE
	$env:KUBECONFIG=($env:KUBECONFIG_FILE)
	kubectl get nodes
	docker ps -f name=${env:CLUSTER_REGISTRY_NAME}

# 4. setup setup.cert-manager
**commands run**
	helm repo add jetstack https://charts.jetstack.io
	helm repo update
	kubectl create namespace cert-manager
	helm install cert-manager jetstack/cert-manager --namespace cert-manager --version v1.9.1 --set installCRDs=true --wait
	kubectl -n cert-manager rollout status deploy/cert-manager

# 5. setup selfsigned issuer and certificate
**commands run**
	kubectl create namespace demo-app
	kubectl apply -f issuer.yaml -n demo-app
	kubectl apply -f certificate.yaml -n demo-app

# 6. setup rancher ui on cluster
**commands run**
	$env:RANCHER_SERVER_HOSTNAME="rancher.localhost"
	helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
	helm repo update
	kubectl create namespace cattle-system
	helm install rancher rancher-latest/rancher --namespace cattle-system --set hostname=${env:RANCHER_SERVER_HOSTNAME} --wait
	kubectl -n cattle-system rollout status deploy/rancher
	Write-Host "To login into rancher open this url and use the following secret to login" -ForegroundColor blue
	kubectl get secret --namespace cattle-system bootstrap-secret -o go-template='{{.data.bootstrapPassword|base64decode}}'

# 7. Build anmd push dockker images to k3d registry
**commands run**
	$env:CLUSTER_REGISTRY_URL="demo-rancher-registry:62701"
	
	docker build -t demo-api-first:1.0.0 -f "../src/Demo.Api.First/." "../"
	docker image tag demo-api-first:1.0.0 ${env:CLUSTER_REGISTRY_URL}/demo-api-first:1.0.0
	docker image tag ${env:CLUSTER_REGISTRY_URL}/demo-api-first:1.0.0 ${env:CLUSTER_REGISTRY_URL}/demo-api-first:latest
	docker push ${env:CLUSTER_REGISTRY_URL}/demo-api-first:1.0.0
	docker push ${env:CLUSTER_REGISTRY_URL}/demo-api-first:latest

	docker build -t demo-api-second:1.0.0 -f "../src/Demo.Api.Second/." "../"
	docker image tag demo-api-second:1.0.0 ${env:CLUSTER_REGISTRY_URL}/demo-api-second:1.0.0
	docker image tag ${env:CLUSTER_REGISTRY_URL}/demo-api-second:1.0.0 ${env:CLUSTER_REGISTRY_URL}/demo-api-second:latest
	docker push ${env:CLUSTER_REGISTRY_URL}/demo-api-second:1.0.0
	docker push ${env:CLUSTER_REGISTRY_URL}/demo-api-second:latest

	docker build -t demo-ui:1.0.0 -f "../src/Demo.Ui.WebUi/." "../"
	docker image tag demo-ui:1.0.0 ${env:CLUSTER_REGISTRY_URL}/demo-ui:1.0.0
	docker image tag ${env:CLUSTER_REGISTRY_URL}/demo-ui:1.0.0 ${env:CLUSTER_REGISTRY_URL}/demo-ui:latest
	docker push ${env:CLUSTER_REGISTRY_URL}/demo-ui:1.0.0
	docker push ${env:CLUSTER_REGISTRY_URL}/demo-ui:latest
