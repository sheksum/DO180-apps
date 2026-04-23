[root@pln-petipareplica ~]# dig @172.23.49.10 pln-petipareplica.ipa.calix.local +short
10.172.248.57
[root@pln-petipareplica ~]#
[root@pln-petipareplica ~]# nc -zv cpeg-ipareplica.ipa.calix.local 389
Ncat: Version 7.92 ( https://nmap.org/ncat )
Ncat: Connected to 172.23.49.10:389.
Ncat: 0 bytes sent, 0 bytes received in 0.06 seconds.
[root@pln-petipareplica ~]# nc -zv cpeg-ipareplica.ipa.calix.local 88
Ncat: Version 7.92 ( https://nmap.org/ncat )
Ncat: Connected to 172.23.49.10:88.
Ncat: 0 bytes sent, 0 bytes received in 0.06 seconds.
[root@pln-petipareplica ~]# nc -zv cpeg-ipareplica.ipa.calix.local 464
Ncat: Version 7.92 ( https://nmap.org/ncat )
Ncat: Connected to 172.23.49.10:464.
Ncat: 0 bytes sent, 0 bytes received in 0.06 seconds.
[root@pln-petipareplica ~]# grep -i "pln\|cpeg" /etc/hosts
10.172.248.57 pln-petipareplica.ipa.calix.local pln-petipareplica
172.23.49.10	cpeg-ipareplica.ipa.calix.local
[root@pln-petipareplica ~]# date
Thu Apr 23 16:10:38 UTC 2026
[root@pln-petipareplica ~]# timedatectl status | grep -i "NTP\|sync"
System clock synchronized: yes
              NTP service: active
[root@pln-petipareplica ~]#

[root@cpeg-ipareplica ~]# dig @172.23.49.10 pln-petipareplica.ipa.calix.local +short
10.172.248.57
[root@cpeg-ipareplica ~]#
[root@cpeg-ipareplica ~]#
