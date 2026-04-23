# On pln-petipareplica
sudo ipa-server-install --uninstall -U

# Remove any stale keytabs / IPA config  
sudo rm -f /etc/krb5.keytab
sudo rm -f /var/lib/ipa/gssproxy/http.keytab
sudo rm -rf /var/lib/ipa/sysrestore/
sudo rm -rf /etc/dirsrv/slapd-IPA-CALIX-LOCAL


# On cpeg
kinit admin

# Remove host entry (which removes associated services/keytabs)
ipa host-del pln-petipareplica.ipa.calix.local --updatedns 2>&1

# Verify it's gone
ipa host-show pln-petipareplica.ipa.calix.local 2>&1
ipa-replica-manage list

# Check DNS is also clean
dig @172.23.49.10 pln-petipareplica.ipa.calix.local +short


sudo sed -i 's|^ipa_server = cpeg-ipareplica.ipa.calix.local|ipa_server = cpeg-ipareplica.ipa.calix.local, pln-petipareplica.ipa.calix.local|' /etc/sssd/sssd.conf
sudo grep ipa_server /etc/sssd/sssd.conf
sudo sss_cache -E
sudo systemctl restart sssd

# Run for 30 min to confirm improvement
for i in $(seq 1 60); do
  echo "$(date +%H:%M:%S) $(sudo sssctl domain-status ipa.calix.local | grep 'Online status')"
  sleep 30
done


# On cpeg
sudo dsconf -D "cn=Directory Manager" ldap://cpeg-ipareplica.ipa.calix.local \
  repl-agmt list --suffix="dc=ipa,dc=calix,dc=local" 2>&1 | \
  grep -E "^dn:|nsds5replicaHost|nsds5ReplicaEnabled|nsds5replicaLastUpdateStatus:"


  # On cpeg
kinit admin
ipa user-add testrepl --first=Test --last=Replication

# Immediately query from pln-petipareplica
ldapsearch -x -H ldap://pln-petipareplica.ipa.calix.local \
  -b "cn=users,cn=accounts,dc=ipa,dc=calix,dc=local" "(uid=testrepl)" uid 2>&1 | tail -5

# Should return the entry. If not, wait 30s and retry.

# Clean up
ipa user-del testrepl

[root@cpeg-ipareplica ~]# ipa user-add testrepl --first=Test --last=Replication
ipa: ERROR: user with name "testrepl" already exists
[root@cpeg-ipareplica ~]# ipa user-add testrepls --first=Test --last=Replication
----------------------
Added user "testrepls"
----------------------
  User login: testrepls
  First name: Test
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
