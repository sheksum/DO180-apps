[root@aamslc4kbc01 ~]# 
[root@aamslc4kbc01 ~]# 
[root@aamslc4kbc01 ~]# 
[root@aamslc4kbc01 ~]# kubectl -n pgweb get ingress kindo-pgweb -o yaml | grep -A5 -E 'tls:|host:'
  - host: pgweb.kbai.ttmtech.com
    http:
      paths:
      - backend:
          service:
            name: kindo-pgweb
[root@aamslc4kbc01 ~]# 
[root@aamslc4kbc01 ~]# 
[root@aamslc4kbc01 ~]# kubectl -n pgweb get ingress kindo-pgweb -o jsonpath='{.spec.tls}' ; echo

[root@aamslc4kbc01 ~]# kubectl -n pgweb get ingress kindo-pgweb -o jsonpath='{range .spec.rules[*]}host={.host} paths={.http.paths[*].path}{"\n"}{end}'
host=pgweb.kbai.ttmtech.com paths=/
[root@aamslc4kbc01 ~]# 
[root@aamslc4kbc01 ~]# curl -sk -o /dev/null -w "HTTP %{http_code} | redirected-to: %{redirect_url}\n" http://pgweb.kbai.ttmtech.com/
HTTP 200 | redirected-to: 
[root@aamslc4kbc01 ~]# curl -sk -o /dev/null -w "HTTPS %{http_code}\n" https://pgweb.kbai.ttmtech.com/
HTTPS 200
[root@aamslc4kbc01 ~]# 
