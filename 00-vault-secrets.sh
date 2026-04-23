[root@pln-petipareplica ~]# ipa-server-install --uninstall -U
WARNING:
IPA server is not configured on this system. If you want to install the
IPA server, please install it using 'ipa-server-install'.
Server removal aborted:

Replication topology in suffix 'domain' is disconnected:
Topology does not allow server cpeg-ipareplica.ipa.calix.local to replicate with servers:
    pln-petipareplica.ipa.calix.local
Topology does not allow server nan-ipareplica01.ipa.calix.local to replicate with servers:
    pln-petipareplica.ipa.calix.local
Topology does not allow server ric-ipareplica.ipa.calix.local to replicate with servers:
    pln-petipareplica.ipa.calix.local
Topology does not allow server ric-ipareplica01.ipa.calix.local to replicate with servers:
    pln-petipareplica.ipa.calix.local
Topology does not allow server sjc-ipareplica01.ipa.calix.local to replicate with servers:
    pln-petipareplica.ipa.calix.local.
The ipa-server-install command failed. See /var/log/ipaserver-uninstall.log for more information
[root@pln-petipareplica ~]#  First name: Test
  Last name: Replication
  Full name: Test Replication
  Display name: Test Replication
  Initials: TR
  Home directory: /home/testrepls
  GECOS: Test Replication
  Login shell: /bin/bash
  Principal name: testrepls@IPA.CALIX.LOCAL
  Principal alias: testrepls@IPA.CALIX.LOCAL
  Email address: testrepls@calix.com
  UID: 87855
  GID: 87855
  Password: False
  Member of groups: sw
  Kerberos keys available: False
[root@cpeg-ipareplica ~]#

[root@pln-petipareplica ~]#
[root@pln-petipareplica ~]#
[root@pln-petipareplica ~]# ldapsearch -x -H ldap://pln-petipareplica.ipa.calix.local \
>   -b "cn=users,cn=accounts,dc=ipa,dc=calix,dc=local" "(uid=testrepls)" uid 2>&1 | tail -5
# search result
search: 2
result: 0 Success

# numResponses: 1
[root@pln-petipareplica ~]# ldapsearch -x -H ldap://pln-petipareplica.ipa.calix.local   -b "cn=users,cn=accounts,dc=ipa,dc=calix,dc=local" "(uid=testreplsa)" uid 2>&1 | tail -5
# search result
search: 2
result: 0 Success

# numResponses: 1
[root@pln-petipareplica ~]# ipa user-del testrepl
ipa: ERROR: Ticket expired
[root@pln-petipareplica ~]# kinit hsuma
Password for hsuma@IPA.CALIX.LOCAL:
[root@pln-petipareplica ~]# ipa user-del testrepls
------------------------
Deleted user "testrepls"
------------------------
[root@pln-petipareplica ~]#
