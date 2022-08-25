#Build images ad push to registry
$env:CLUSTER_REGISTRY_URL="demo-rancher-registry:62701"

$title    = 'Build and push version 1.0.0 of docker images to k3d cluster registry'
$question = 'This will deploy and push images to registry:"' + ${env:CLUSTER_REGISTRY_URL} + '". Do you want to continue?'
$choices  = '&Yes', '&No'

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {

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
}

