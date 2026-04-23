[root@aamslc4kbc01 ~]# kubectl -n pgweb get ingress kindo-pgweb -o yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    field.cattle.io/publicEndpoints: '[{"addresses":["10.200.248.41","10.200.248.42","10.200.248.43","10.200.248.44","10.200.248.45"],"port":80,"protocol":"HTTP","serviceName":"pgweb:kindo-pgweb","ingressName":"pgweb:kindo-pgweb","hostname":"pgweb.kbai.ttmtech.com","path":"/","allNodes":false}]'
    meta.helm.sh/release-name: kindo-pgweb
    meta.helm.sh/release-namespace: pgweb
  creationTimestamp: "2026-01-18T19:06:47Z"
  generation: 3
  labels:
    app.kubernetes.io/instance: kindo-pgweb
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/name: pgweb
    app.kubernetes.io/version: 0.14.1
    helm.sh/chart: pgweb-0.1.9
  name: kindo-pgweb
  namespace: pgweb
  resourceVersion: "75538893"
  uid: 1f730c2a-bb10-47b6-aacc-a86779d20579
spec:
  ingressClassName: nginx
  rules:
  - host: pgweb.kbai.ttmtech.com
    http:
      paths:
      - backend:
          service:
            name: kindo-pgweb
            port:
              number: 80
        path: /
        pathType: ImplementationSpecific
status:
  loadBalancer:
    ingress:
    - ip: 10.200.248.41
    - ip: 10.200.248.42
    - ip: 10.200.248.43
    - ip: 10.200.248.44
    - ip: 10.200.248.45
[root@aamslc4kbc01 ~]# kubectl -n kube-system logs -l app.kubernetes.io/name=rke2-ingress-nginx --tail=5 2>/dev/null | grep pgweb
10.200.248.30 - - [23/Apr/2026:19:59:41 +0000] "HEAD / HTTP/1.1" 404 0 "-" "curl/7.76.1" 87 0.001 [pgweb-kindo-pgweb-80] [] 10.42.3.3:8081 0 0.001 404 12a871f50e23ace048f79c973282542f
10.200.248.30 - - [23/Apr/2026:19:59:50 +0000] "GET / HTTP/1.1" 200 15088 "-" "curl/7.76.1" 86 0.001 [pgweb-kindo-pgweb-80] [] 10.42.3.3:8081 15088 0.001 200 513f1472a546224ce297c0011cee3c03
10.200.248.30 - - [23/Apr/2026:19:59:59 +0000] "HEAD / HTTP/1.1" 404 0 "-" "curl/7.76.1" 87 0.002 [pgweb-kindo-pgweb-80] [] 10.42.3.3:8081 0 0.001 404 d53db7776dccc916e4630f6e7ed95f2a
[root@aamslc4kbc01 ~]# 
