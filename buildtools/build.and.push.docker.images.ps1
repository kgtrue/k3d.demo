#Build images ad push to registry
$env:CLUSTER_REGISTRY_URL="k3d-rancher-registry:5111"

docker build -t demo-api-first:1.0.0 -f "../src/Demo.Api.First/." "../"
docker image tag demo-api-first:1.0.0 ${env:CLUSTER_REGISTRY_URL}/demo-api-first:latest
docker push ${env:CLUSTER_REGISTRY_URL}/demo-api-first:latest

docker build -t demo-api-second:1.0.0 -f "../src/Demo.Api.Second/." "../"
docker image tag demo-api-second:1.0.0 ${env:CLUSTER_REGISTRY_URL}/demo-api-second:latest
docker push ${env:CLUSTER_REGISTRY_URL}/demo-api-second:latest

docker build -t demo-ui:1.0.0 -f "../src/Demo.Ui.WebUi/." "../"
docker image tag demo-ui:1.0.0 ${env:CLUSTER_REGISTRY_URL}/demo-ui:latest
docker push ${env:CLUSTER_REGISTRY_URL}/demo-ui:latest

