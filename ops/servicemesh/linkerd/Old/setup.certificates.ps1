kubectl apply -f cert.bootstrap.yaml
kubectl apply -f linkerd-identity-issuer.yaml

$env:CA_CRT=""
$env:TLS_CRT=""
$env:TLS_KEY=""

$env:CA_CRT = kubectl get secret linkerd-identity-issuer -o jsonpath="{.data.ca\.crt}" -n linkerd
$env:TLS_CRT = kubectl get secret linkerd-identity-issuer -o jsonpath="{.data.tls\.crt}" -n linkerd 
$env:TLS_KEY = kubectl get secret linkerd-identity-issuer -o jsonpath="{.data.tls\.key}" -n linkerd

echo ""

echo "#################CA_CRT##################"
echo ${env:CA_CRT}
echo ""

echo "#################TLS_CRT##################"
echo ${env:TLS_CRT}
echo ""

echo "#################TLS_KEY##################"
echo ${env:TLS_KEY}
echo ""

#$ca-crt = Get-Content -Path .\ca-crt.val
[Text.Encoding]::Utf8.GetString([Convert]::FromBase64String(${env:CA_CRT})) > ca.crt
#
#$tls-crt = Get-Content -Path .\tls-crt.val
[Text.Encoding]::Utf8.GetString([Convert]::FromBase64String(${env:TLS_CRT})) > tls.crt
#
#$tls-key = Get-Content -Path .\tls-key.val
[Text.Encoding]::Utf8.GetString([Convert]::FromBase64String(${env:TLS_KEY})) > tls.key