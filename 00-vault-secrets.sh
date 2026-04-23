  [3/4]: starting ipa-custodia
  [4/4]: configuring ipa-custodia to start on boot
Done configuring ipa-custodia.
Configuring certificate server (pki-tomcatd)
  [1/2]: configure certmonger for renewals
  [2/2]: Importing RA key
Done configuring certificate server (pki-tomcatd).
wait_for_entry timeout on ldap://cpeg-ipareplica.ipa.calix.local:389 for cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
The ipa-replica-install command failed. See /var/log/ipareplica-install.log for more information
Your system may be partly configured.
Run /usr/sbin/ipa-server-install --uninstall to clean up.

[root@pln-petipareplica ~]#
'''26-04-23T16:59:24Z DEBUG stdout=
2026-04-23T16:59:24Z DEBUG stderr=
2026-04-23T16:59:24Z DEBUG Starting external process
2026-04-23T16:59:24Z DEBUG args=['/usr/sbin/selinuxenabled']
2026-04-23T16:59:24Z DEBUG Process finished, return code=0
2026-04-23T16:59:24Z DEBUG stdout=
2026-04-23T16:59:24Z DEBUG stderr=
2026-04-23T16:59:24Z DEBUG Starting external process
2026-04-23T16:59:24Z DEBUG args=['/sbin/restorecon', '/var/lib/ipa/ra-agent.key']
2026-04-23T16:59:24Z DEBUG Process finished, return code=0
2026-04-23T16:59:24Z DEBUG stdout=
2026-04-23T16:59:24Z DEBUG stderr=
2026-04-23T16:59:24Z DEBUG step duration: pki-tomcatd __import_ra_key 3.70 sec
2026-04-23T16:59:24Z DEBUG Done configuring certificate server (pki-tomcatd).
2026-04-23T16:59:24Z DEBUG service duration: pki-tomcatd 3.97 sec
2026-04-23T16:59:24Z DEBUG Removing /root/.dogtag/pki-tomcat/ca
2026-04-23T16:59:24Z DEBUG Waiting up to 300 seconds for replication (ldap://cpeg-ipareplica.ipa.calix.local:389) cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local (objectclass=*)
2026-04-23T16:59:34Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T16:59:44Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T16:59:55Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:00:05Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:00:16Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:00:26Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:00:37Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:00:47Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:00:58Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:01:08Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:01:19Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:01:29Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:01:40Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:01:50Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:02:01Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:02:11Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:02:22Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:02:32Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:02:43Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:02:53Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:03:04Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:03:14Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:03:25Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:03:35Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:03:46Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:03:56Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:04:07Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
2026-04-23T17:04:17Z DEBUG Still waiting for replication of cn=KDC,cn=pln-petipareplica.ipa.calix.local,cn=masters,cn=ipa,cn=etc,dc=ipa,dc=calix,dc=local
[root@pln-petipareplica ~]#
[root@pln-petipareplica ~]#
