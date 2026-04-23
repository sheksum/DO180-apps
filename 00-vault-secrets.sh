[root@cpeg-ipareplica ~]#
[root@cpeg-ipareplica ~]#
[root@cpeg-ipareplica ~]# ipa-replica-manage list
sjc-ipareplica01.ipa.calix.local: master
nan-ipareplica01.ipa.calix.local: master
ric-ipareplica01.ipa.calix.local: master
ric-ipareplica.ipa.calix.local: master
cpeg-ipareplica.ipa.calix.local: master
[root@cpeg-ipareplica ~]# ipa host-show pln-petipareplica.ipa.calix.local 2>&1
  Host name: pln-petipareplica.ipa.calix.local
  Platform: x86_64
  Operating system: 4.18.0-553.16.1.el8_10.x86_64
  Principal name: host/pln-petipareplica.ipa.calix.local@IPA.CALIX.LOCAL
  Principal alias: host/pln-petipareplica.ipa.calix.local@IPA.CALIX.LOCAL
  SSH public key fingerprint: SHA256:O02Ame1MdRf8Yj9lFHKlnFk9Z5QXieTkgPecSu6Cy/k (ecdsa-sha2-nistp256), SHA256:yuMrtc+YsgpO4eYSWo/k4+kvX78q+uPF1HD2eSuM8tU (ssh-ed25519), SHA256:xInEV1YNPwtU1nA111SaLIIQUTSiMuo0f1mUk3VJPBQ (ssh-rsa)
  Password: False
  Member of host-groups: ipaservers
  Keytab: True
  Managed by: pln-petipareplica.ipa.calix.local
[root@cpeg-ipareplica ~]# sudo dsconf -D "cn=Directory Manager" ldap://cpeg-ipareplica.ipa.calix.local \
>   repl-agmt list --suffix="dc=ipa,dc=calix,dc=local" 2>&1 | grep -iE "petipareplica|nsds50ruv"
Enter password for cn=Directory Manager on ldap://cpeg-ipareplica.ipa.calix.local:
nsds50ruv: {replicageneration} 66ade489000000140000
nsds50ruv: {replica 10 ldap://nan-ipareplica01.ipa.calix.local:389} 69bb87f60000000a0000 69eb47850000000a0000
nsds50ruv: {replica 20 ldap://cpeg-ipareplica.ipa.calix.local:389} 66ade48b000000140000 699f3f63000100140000
nsds50ruv: {replica 12 ldap://ric-ipareplica.ipa.calix.local:389}
nsds50ruv: {replica 11 ldap://ric-ipareplica01.ipa.calix.local:389}
nsds50ruv: {replicageneration} 66ade489000000140000
nsds50ruv: {replica 11 ldap://ric-ipareplica01.ipa.calix.local:389} 69a03f9d0000000b0000 69eb95da0000000b0000
nsds50ruv: {replica 12 ldap://ric-ipareplica.ipa.calix.local:389}
nsds50ruv: {replica 20 ldap://cpeg-ipareplica.ipa.calix.local:389} 66ade48b000000140000 ffffffff6f0a00140000
nsds50ruv: {replica 10 ldap://nan-ipareplica01.ipa.calix.local:389}
dn: cn=meTopln-petipareplica.ipa.calix.local,cn=replica,cn=dc\3Dipa\2Cdc\3Dcalix\2Cdc\3Dlocal,cn=mapping tree,cn=config
cn: meTopln-petipareplica.ipa.calix.local
description: me to pln-petipareplica.ipa.calix.local
nsDS5ReplicaHost: pln-petipareplica.ipa.calix.local
nsds50ruv: {replicageneration} 66ade489000000140000
nsds50ruv: {replica 58 ldap://pln-petipareplica.ipa.calix.local:389} 69ea45ab0001003a0000 69ea4d6f0000003a0000
nsds50ruv: {replica 20 ldap://cpeg-ipareplica.ipa.calix.local:389} 66ade48b000000140000 699f3f63000100140000
nsds50ruv: {replica 12 ldap://ric-ipareplica.ipa.calix.local:389}
nsds50ruv: {replica 11 ldap://ric-ipareplica01.ipa.calix.local:389}
nsds50ruv: {replica 10 ldap://nan-ipareplica01.ipa.calix.local:389}
nsruvReplicaLastModified: {replica 58 ldap://pln-petipareplica.ipa.calix.local:389} 00000000
[root@cpeg-ipareplica ~]#
