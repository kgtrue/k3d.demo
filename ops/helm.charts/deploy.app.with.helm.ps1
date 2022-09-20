kubectl create namespace demo-app
helm upgrade --install demo-app-release demo --namespace demo-app