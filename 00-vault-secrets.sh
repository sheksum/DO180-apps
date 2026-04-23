# The full ingress spec — focus on annotations
kubectl -n pgweb get ingress kindo-pgweb -o yaml

# And what the ingress-nginx controller logs say about this request
kubectl -n kube-system logs -l app.kubernetes.io/name=rke2-ingress-nginx --tail=5 2>/dev/null | grep pgweb
