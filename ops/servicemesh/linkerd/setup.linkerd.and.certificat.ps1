#install linkerd-cli
$title    = 'linkerd-cli'
$question = 'This will instal linkerd-cli'
$choices  = '&Yes', '&No'
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	choco install linkerd2
}

$env:CERT_ROOT = "."

step certificate create root.linkerd.cluster.local "${CERT_ROOT}/ca.crt" "${CERT_ROOT}/ca.key" --profile root-ca --no-password --insecure --force

step certificate create identity.linkerd.cluster.local ${CERT_ROOT}/issuer.crt ${CERT_ROOT}/issuer.key --profile intermediate-ca --not-after 8760h --no-password --insecure --ca ${CERT_ROOT}/ca.crt --ca-key ${CERT_ROOT}/ca.key --force

kubectl label namespace kube-system config.linkerd.io/admission-webhooks=disabled

#install linkerd crds
$title    = 'Setup linkerd crds on cluster'
$question = 'This will deploy linkerd crds to cluster'
$choices  = '&Yes', '&No'
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	helm repo add linkerd https://helm.linkerd.io/stable
	helm repo add linkerd-edge https://helm.linkerd.io/edge
	
	helm install linkerd-crds linkerd/linkerd-crds -n linkerd --create-namespace
	
}

#install linkerd-control-plane
$title    = 'Setup linkerd-control-plane on cluster'
$question = 'This will deploy linkerd-control-plane to cluster'
$choices  = '&Yes', '&No'
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	helm install linkerd-control-plane -n linkerd --set-file identityTrustAnchorsPEM=${CERT_ROOT}/issuer.crt --set-file identity.issuer.tls.crtPEM=${CERT_ROOT}/issuer.crt --set-file identity.issuer.tls.keyPEM=${CERT_ROOT}/issuer.key linkerd/linkerd-control-plane
}