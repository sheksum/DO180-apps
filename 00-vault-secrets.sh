[root@aamslc4kbc01 ~]# curl -skI http://pgweb.kbai.ttmtech.com/
HTTP/1.1 404 Not Found
Date: Thu, 23 Apr 2026 19:59:41 GMT
Content-Type: text/plain
Content-Length: 18
Connection: keep-alive

[root@aamslc4kbc01 ~]# curl -skv http://pgweb.kbai.ttmtech.com/ 2>&1 | grep -E '^< HTTP|^< Location|^> GET' | head -10
> GET / HTTP/1.1
< HTTP/1.1 200 OK
[root@aamslc4kbc01 ~]# curl -skIL http://pgweb.kbai.ttmtech.com/ 2>&1 | grep -E '^HTTP|^Location' | head
HTTP/1.1 404 Not Found
[root@aamslc4kbc01 ~]# 
