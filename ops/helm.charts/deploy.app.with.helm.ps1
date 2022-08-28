Set-Location demo
$Env:KUBECONFIG=("../../lazy.full.setup/demo-rancher.yaml")
helm upgrade --install demo-app-release . --namespace demo-app --set demo-ui.image.tag="1.0.0" --set demo-api-first.image.tag="1.0.0" --set demo-api-second.image.tag="1.0.0"