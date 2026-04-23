# Check the ingress TLS config
kubectl -n pgweb get ingress kindo-pgweb -o yaml | grep -A5 -E 'tls:|host:'

# Also — what does the ingress actually expose on the port side?
kubectl -n pgweb get ingress kindo-pgweb -o jsonpath='{.spec.tls}' ; echo
kubectl -n pgweb get ingress kindo-pgweb -o jsonpath='{range .spec.rules[*]}host={.host} paths={.http.paths[*].path}{"\n"}{end}'

# Try hitting it both ways to confirm what actually responds
curl -sk -o /dev/null -w "HTTP %{http_code} | redirected-to: %{redirect_url}\n" http://pgweb.kbai.ttmtech.com/
curl -sk -o /dev/null -w "HTTPS %{http_code}\n" https://pgweb.kbai.ttmtech.com/
