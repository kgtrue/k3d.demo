#install linkerd-cli
$title    = 'linkerd-cli'
$question = 'This will instal linkerd-cli'
$choices  = '&Yes', '&No'
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	choco install linkerd2
}

#install linkerd crds
$title    = 'Setup linkerd crds on cluster'
$question = 'This will deploy linkerd crds to cluster'
$choices  = '&Yes', '&No'
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	helm repo add linkerd-edge https://helm.linkerd.io/edge
	helm install linkerd-crds linkerd/linkerd-crds -n linkerd
}

#install linkedrd
$title    = 'Setup linkerd on cluster'
$question = 'This will deploy linkerd to cluster'
$choices  = '&Yes', '&No'
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	helm repo add linkerd https://helm.linkerd.io/stable
	helm install linkerd2 --set-file identityTrustAnchorsPEM=ca.crt --set identity.issuer.scheme=kubernetes.io/tls --set installNamespace=false linkerd/linkerd2 -n linkerd
	kubectl -n linkerd get pod
	kubectl get configmap linkerd-config -o yaml -n linkerd
}

#install linkerd-control-plane
$title    = 'Setup linkerd-control-plane on cluster'
$question = 'This will deploy linkerd-control-plane to cluster'
$choices  = '&Yes', '&No'
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
	helm install linkerd-control-plane -n linkerd --devel --set installNamespace=false --set-file identityTrustAnchorsPEM=ca.crt --set-file identity.issuer.tls.crtPEM=tls.crt --set-file identity.issuer.tls.keyPEM=tls.key --dry-run --debug linkerd-edge/linkerd-control-plane
}