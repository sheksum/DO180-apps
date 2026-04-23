root@pln-landscape01:~# lsctl restart
dpkg-query: no path found matching pattern /sbin/init
== landscape-appserver ==
== landscape-async-frontend ==
== landscape-job-handler ==
== landscape-msgserver ==
== landscape-pingserver ==
== landscape-api ==
== landscape-package-upload ==
== landscape-package-search ==
== landscape-hostagent-messenger ==
== landscape-hostagent-consumer ==
== landscape-secrets-service ==
root@pln-landscape01:~# ls /var/lib/landscape/landscape-repository/standalone/
third-party  ubuntu-bionic-onprem  ubuntu-focal-onprem  ubuntu-jammy-onprem  ubuntu-noble-onprem  ubuntu-xenial-onprem
root@pln-landscape01:~# ls /var/lib/landscape/landscape-repository/standalone/third-party/
conf  db  dists  incoming  lists  locks  pool  temp
root@pln-landscape01:~# ls /var/lib/landscape/landscape-repository/standalone/third-party/dists
stable-firefox-onprem  stable-google-chrome-onprem  stable-grafana-onprem  stable-microsoft-vscode-onprem
root@pln-landscape01:~#
