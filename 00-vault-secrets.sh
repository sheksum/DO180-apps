[root@pln-petipareplica ~]#
[root@pln-petipareplica ~]# ldapsearch -x -H ldap://pln-petipareplica.ipa.calix.local -b "cn=users,cn=accounts,dc=ipa,dc=calix,dc=local" "(uid=hsuma)" uid uidNumber 2>&1 | tail -10
dn: uid=hsuma,cn=users,cn=accounts,dc=ipa,dc=calix,dc=local
uid: hsuma
uidNumber: 13232

# search result
search: 2
result: 0 Success

# numResponses: 2
# numEntries: 1
[root@pln-petipareplica ~]#
[root@pln-petipareplica ~]#
[root@pln-petipareplica ~]# sudo ss -tlnp | grep -E ":88|:464|:389"
LISTEN 0      5                 0.0.0.0:464        0.0.0.0:*    users:(("kadmind",pid=192587,fd=9))
LISTEN 0      5                 0.0.0.0:88         0.0.0.0:*    users:(("krb5kdc",pid=192520,fd=9),("krb5kdc",pid=192519,fd=9),("krb5kdc",pid=192518,fd=9),("krb5kdc",pid=192517,fd=9))
LISTEN 0      5                    [::]:464           [::]:*    users:(("kadmind",pid=192587,fd=10))
LISTEN 0      5                    [::]:88            [::]:*    users:(("krb5kdc",pid=192520,fd=10),("krb5kdc",pid=192519,fd=10),("krb5kdc",pid=192518,fd=10),("krb5kdc",pid=192517,fd=10))
LISTEN 0      128                     *:389              *:*    users:(("ns-slapd",pid=192825,fd=7))
[root@pln-petipareplica ~]#
[root@pln-petipareplica ~]# sudo systemctl is-active dirsrv@IPA-CALIX-LOCAL krb5kdc kadmin
active
active
active
[root@pln-petipareplica ~]#
