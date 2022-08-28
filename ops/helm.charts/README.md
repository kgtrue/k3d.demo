Create new helm chart by using the command "helm create {name}"
Try the command by opening a terminal and running this command helm create my-first-chart

run deploy.app.with.helm.ps1 The script will create a new depoyment of the demo deployment and the sub deployments

$Env:KUBECONFIG=("../../lazy.full.setup/demo-rancher.yaml") ==> sets KUBECONFIG 
helm upgrade --install demo-app-release . --namespace demo-app --set demo-ui.image.tag="1.0.0" --set demo-api-first.image.tag="1.0.0" --set demo-api-second.image.tag="1.0.0" ==> Runs a deployment named demo-app-release of the demmo deployment.