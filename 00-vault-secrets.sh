# What cert is actually served on HTTPS for pgweb?
echo | openssl s_client -connect pgweb.kbai.ttmtech.com:443 -servername pgweb.kbai.ttmtech.com 2>/dev/null | openssl x509 -noout -subject -issuer -dates

# Does the ingress-nginx controller have a default-ssl-certificate configured?
kubectl -n kube-system get deploy rke2-ingress-nginx-controller -o yaml 2>/dev/null | grep -i default-ssl
# Also check the DaemonSet (RKE2 runs ingress-nginx as a DaemonSet)
kubectl -n kube-system get ds rke2-ingress-nginx-controller -o yaml 2>/dev/null | grep -iE 'default-ssl|ssl-certificate' | head
