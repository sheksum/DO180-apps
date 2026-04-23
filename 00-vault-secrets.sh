[root@cpeg-ipareplica ~]#
[root@cpeg-ipareplica ~]# sudo tail -f /var/log/dirsrv/slapd-IPA-CALIX-LOCAL/errors | grep -E "pln-petipareplica|keytab|SASL|permission|ACL"
[23/Apr/2026:16:20:56.829063168 +0000] - ERR - agmt="cn=meTopln-petipareplica.ipa.calix.local" (pln-petipareplica:389) - clcache_load_buffer - Can't locate CSN ffffffff6f0b00140000 in the changelog (DB rc=-30988). If replication stops, the consumer may need to be reinitialized.
[23/Apr/2026:16:21:00.772314596 +0000] - ERR - agmt="cn=meTopln-petipareplica.ipa.calix.local" (pln-petipareplica:389) - clcache_load_buffer - Can't locate CSN ffffffff6f0b00140000 in the changelog (DB rc=-30988). If replication stops, the consumer may need to be reinitialized.
[23/Apr/2026:16:21:03.141485811 +0000] - ERR - agmt="cn=meTopln-petipareplica.ipa.calix.local" (pln-petipareplica:389) - clcache_load_buffer - Can't locate CSN ffffffff6f0b00140000 in the changelog (DB rc=-30988). If replication stops, the consumer may need to be reinitialized.
[23/Apr/2026:16:21:08.830308029 +0000] - ERR - agmt="cn=meTopln-petipareplica.ipa.calix.local" (pln-petipareplica:389) - clcache_load_buffer - Can't locate CSN ffffffff6f0b00140000 in the changelog (DB rc=-30988). If replication stops, the consumer may need to be reinitialized.
[23/Apr/2026:16:21:11.197431338 +0000] - ERR - agmt="cn=meTopln-petipareplica.ipa.calix.local" (pln-petipareplica:389) - clcache_load_buffer - Can't locate CSN ffffffff6f0b00140000 in the changelog (DB rc=-30988). If replication stops, the consumer may need to be reinitialized.
[23/Apr/2026:16:21:13.566211381 +0000] - ERR - agmt="cn=meTopln-petipareplica.ipa.calix.local" (pln-petipareplica:389) - clcache_load_buffer - Can't locate CSN ffffffff6f0b00140000 in the changelog (DB rc=-30988). If replication stops, the consumer may need to be reinitialized.
[23/Apr/2026:16:21:16.891965406 +0000] - ERR - agmt="cn=meTopln-petipareplica.ipa.calix.local" (pln-petipareplica:389) - clcache_load_buffer - Can't locate CSN ffffffff6f0b00140000 in the changelog (DB rc=-30988). If replication stops, the consumer may need to be reinitialized.
[23/Apr/2026:16:21:19.260315672 +0000] - ERR - agmt="cn=meTopln-petipareplica.ipa.calix.local" (pln-petipareplica:389) - clcache_load_buffer - Can't locate CSN ffffffff6f0b00140000 in the changelog (DB rc=-30988). If replication stops, the consumer may need to be reinitialized.
[23/Apr/2026:16:21:21.629373118 +0000] - ERR - agmt="cn=meTopln-petipareplica.ipa.calix.local" (pln-petipareplica:389) - clcache_load_buffer - Can't locate CSN ffffffff6f0b00140000 in the changelog (DB rc=-30988). If replication stops, the consumer may need to be reinitialized.
[23/Apr/2026:16:21:23.998376350 +0000] - ERR - agmt="cn=meTopln-petipareplica.ipa.calix.local" (pln-petipareplica:389) - clcache_load_buffer - Can't locate CSN ffffffff6f0b00140000 in the changelog (DB rc=-30988). If replication stops, the consumer may need to be reinitialized.
[23/Apr/2026:16:21:26.368412824 +0000] - ERR - agmt="cn=meTopln-petipareplica.ipa.calix.local" (pln-petipareplica:389) - clcache_load_buffer - Can't locate CSN ffffffff6f0b00140000 in the changelog (DB rc=-30988). If replication stops, the consumer may need to be reinitialized.
[23/Apr/2026:16:21:28.737019726 +0000] - ERR - agmt="cn=meTopln-petipareplica.ipa.calix.local" (pln-petipareplica:389) - clcache_load_buffer - Can't locate CSN ffffffff6f0b00140000 in the changelog (DB rc=-30988). If replication stops, the consumer may need to be reinitialized.
[23/Apr/2026:16:21:31.106832554 +0000] - ERR - agmt="cn=meTopln-petipareplica.ipa.calix.local" (pln-petipareplica:389) - clcache_load_buffer - Can't locate CSN ffffffff6f0b00140000 in the changelog (DB rc=-30988). If replication stops, the consumer may need to be reinitialized.
[23/Apr/2026:16:21:33.475066962 +0000] - ERR - agmt="cn=meTopln-petipareplica.ipa.calix.local" (pln-petipareplica:389) - clcache_load_buffer - Can't locate CSN ffffffff6f0b00140000 in the changelog (DB rc=-30988). If replication stops, the consumer may need to be reinitialized.
[23/Apr/2026:16:21:36.335787246 +0000] - ERR - agmt="cn=meTopln-petipareplica.ipa.calix.local" (pln-petipareplica:389) - clcache_load_buffer - Can't locate CSN ffffffff6f0b00140000 in the changelog (DB rc=-30988). If replication stops, the consumer may need to be reinitialized.
[23/Apr/2026:16:21:38.705597513 +0000] - ERR - agmt="cn=meTopln-petipareplica.ipa.calix.local" (pln-petipareplica:389) - clcache_load_buffer - Can't locate CSN ffffffff6f0b00140000 in the changelog (DB rc=-30988). If replication stops, the consumer may need to be reinitialized.
^C
[root@cpeg-ipareplica ~]#
[root@cpeg-ipareplica ~]# sudo grep "ADD" /var/log/dirsrv/slapd-IPA-CALIX-LOCAL/access | grep -i "pln-petipareplica" | tail -10
[23/Apr/2026:16:15:46.025193849 +0000] conn=9028696 op=45 ADD dn="idnsname=pln-petipareplica,idnsname=ipa.calix.local.,cn=dns,dc=ipa,dc=calix,dc=local"
[root@cpeg-ipareplica ~]#
[root@cpeg-ipareplica ~]# ipa-replica-manage list 2>&1
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
[root@cpeg-ipareplica ~]#



Configuring the web interface (httpd)
  [1/22]: stopping httpd
  [2/22]: backing up ssl.conf
  [3/22]: disabling nss.conf
  [4/22]: configuring mod_ssl certificate paths
  [5/22]: setting mod_ssl protocol list
  [6/22]: configuring mod_ssl log directory
  [7/22]: disabling mod_ssl OCSP
  [8/22]: adding URL rewriting rules
  [9/22]: configuring httpd
Nothing to do for configure_httpd_wsgi_conf
  [10/22]: setting up httpd keytab
  [error] NotFound: wait_for_entry timeout on ldap://cpeg-ipareplica.ipa.calix.local:389 for krbprincipalname=HTTP/pln-petipareplica.ipa.calix.local@IPA.CALIX.LOCAL,cn=services,cn=accounts,dc=ipa,dc=calix,dc=local
wait_for_entry timeout on ldap://cpeg-ipareplica.ipa.calix.local:389 for krbprincipalname=HTTP/pln-petipareplica.ipa.calix.local@IPA.CALIX.LOCAL,cn=services,cn=accounts,dc=ipa,dc=calix,dc=local
The ipa-replica-install command failed. See /var/log/ipareplica-install.log for more information
Your system may be partly configured.
Run /usr/sbin/ipa-server-install --uninstall to clean up.

[root@pln-petipareplica ~]#
[root@pln-petipareplica ~]# sudo ss -tn state established '( dport = :389 or sport = :389 )' | grep 10.172.248.57
0      0               10.172.248.57:36942            172.23.49.10:389
0      699             10.172.248.57:41472            172.23.49.10:389
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.224.148]:39734
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.8.173]:38590
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.224.216]:45210
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.250.55]:56074
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.224.36]:59876
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.10.54]:44674
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.105]:37714
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.24.56]:60268
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.15.72]:40276
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.224.158]:57472
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.224.114]:42822
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.174.0.74]:56654
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.224.139]:43292
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.154]:59816
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.100]:48290
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.16.94]:52376
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.1.10]:33484
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.2.15]:55434
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.10.4]:49826
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.168.10.196]:39794
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.117]:52976
0      0      [::ffff:10.172.248.57]:389       [::ffff:10.168.1.3]:41100
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.16.84]:45276
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.2.109]:59116
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.32.77]:58624
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.224.81]:52120
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.224.224]:42710
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.40.17]:35636
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.8.124]:48040
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.8.78]:53606
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.174.250.211]:39122
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.2.119]:39090
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.2.228]:37248
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.10.80]:46048
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.174.9.43]:41576
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.2.154]:48296
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.174.9.32]:37760
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.227]:33736
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.225.93]:43178
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.3.42]:40190
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.224.33]:37248
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.171]:58982
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.0.128]:59758
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.193]:36920
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.16.160]:38944
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.16.138]:43800
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.224.32]:48056
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.10.1]:43490
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.8.207]:55916
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.2.241]:51590
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.4.62]:38672
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.16.172]:32876
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.2.140]:48358
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.0.199]:59242
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.168.10.156]:49528
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.159]:40910
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.224.180]:37624
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.248]:37908
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.8.150]:48830
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.250.25]:41892
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.250.68]:34352
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.130.96.17]:33182
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.1.24]:48172
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.250.64]:34416
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.2.87]:47722
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.0.214]:50484
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.168.10.201]:36368
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.8.125]:56908
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.224.80]:42622
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.224.217]:49132
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.224.125]:49408
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.234]:49106
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.225.54]:50976
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.138]:33314
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.219]:36860
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.168]:51838
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.174.0.53]:48738
0      0      [::ffff:10.172.248.57]:389     [::ffff:172.23.49.10]:39752
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.0.142]:60550
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.227]:54868
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.1.82]:59598
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.224.73]:54572
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.10.9]:36174
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.225.170]:46114
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.24.52]:39054
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.174.8.99]:33842
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.16.77]:49150
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.134]:44824
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.208.88]:48516
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.6.62]:36796
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.0.65]:47444
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.8.77]:55296
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.0.122]:38668
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.6.55]:38808
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.135]:59342
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.224.222]:59080
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.225.193]:44460
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.224.193]:51568
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.224.46]:59912
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.10.64]:57620
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.2.137]:32994
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.116]:48310
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.16.128]:34194
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.214]:39836
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.10.95]:38470
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.208.69]:42934
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.224.20]:54690
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.10.72]:48622
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.209]:57690
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.146]:34296
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.8.98]:40640
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.2.26]:52846
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.8.69]:41352
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.101]:35778
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.1.26]:33548
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.224.153]:44934
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.10.67]:46138
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.250.15]:60996
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.254]:58154
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.225.159]:47460
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.249.78]:42094
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.224.64]:33814
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.168.10.216]:39540
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.0.238]:54478
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.224.163]:56162
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.174.0.75]:53434
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.224.118]:33654
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.16.81]:43704
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.3.19]:58244
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.168.10.106]:38146
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.10.89]:54020
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.162]:42734
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.2.124]:40422
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.249.25]:35344
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.16.159]:54634
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.24.95]:38920
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.16.131]:58528
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.106]:38700
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.3.53]:34478
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.208.91]:33418
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.109]:39466
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.174.0.85]:44280
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.174.8.56]:37142
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.225.75]:50364
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.208.103]:48794
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.216]:49614
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.32.63]:45698
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.118]:38682
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.224]:46008
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.213]:40378
0      0      [::ffff:10.172.248.57]:389    [::ffff:192.168.53.22]:57112
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.149]:33954
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.196]:52802
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.0.169]:44892
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.250.59]:55526
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.179]:59646
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.174.250.105]:51024
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.186]:47558
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.112]:56012
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.224]:47056
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.224.209]:52108
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.174.9.41]:42514
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.16.139]:33204
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.249.31]:44222
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.24.50]:44184
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.1.38]:55966
0      0      [::ffff:10.172.248.57]:389       [::ffff:10.174.9.8]:44550
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.225.92]:42210
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.0.75]:43642
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.232.28]:51964
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.8.132]:49656
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.174.9.27]:43434
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.8.79]:55650
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.8.191]:40678
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.167]:53164
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.249.29]:55068
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.172]:55536
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.191]:54958
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.230]:58450
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.2.157]:53152
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.208.84]:47028
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.208.78]:40278
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.249.40]:36232
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.224.54]:49886
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.174.9.24]:58166
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.168.10.194]:51098
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.183]:51876
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.209.123]:35488
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.174.249.113]:58564
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.174.8.60]:38514
0      0      [::ffff:10.172.248.57]:389    [::ffff:192.168.14.49]:59572
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.224.92]:51038
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.8.118]:56896
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.2.131]:46550
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.8.237]:60246
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.16.122]:59454
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.250.50]:60262
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.16.193]:56696
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.224.249]:39306
0      0      [::ffff:10.172.248.57]:389   [::ffff:192.168.102.39]:42706
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.225.63]:37318
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.174.8.52]:54330
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.24.54]:53636
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.10.93]:41888
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.205]:43136
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.224.83]:60130
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.249.62]:39746
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.136]:34588
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.224.149]:46698
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.168.10.197]:60190
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.4.79]:53450
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.100]:36730
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.16.132]:60422
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.3.41]:55826
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.16.101]:42918
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.250.61]:39528
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.0.63]:33768
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.232.56]:34880
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.250.66]:37328
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.8.114]:34478
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.16.142]:43266
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.8.143]:54208
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.3.116]:49570
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.24.82]:40796
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.168.10.112]:40802
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.168.10.160]:53318
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.10.90]:58474
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.129]:58402
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.249.224]:58570
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.224.45]:57444
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.250]:45810
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.184]:50392
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.8.158]:55196
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.16.171]:38120
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.131]:32828
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.24.131]:33306
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.16.82]:35204
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.110]:47286
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.10.40]:38878
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.224.104]:50334
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.24.135]:35130
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.217]:34392
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.225.69]:35260
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.168.10.129]:55440
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.32.82]:36680
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.0.244]:56174
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.107]:46692
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.128]:47844
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.250.57]:51222
0      0      [::ffff:10.172.248.57]:389    [::ffff:192.168.97.28]:52600
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.0.198]:56892
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.1.100]:48798
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.8.153]:55486
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.10.78]:49324
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.16.129]:42930
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.249.223]:51338
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.1.57]:41514
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.1.105]:42692
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.2.190]:41190
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.225.74]:51338
0      0      [::ffff:10.172.248.57]:389       [::ffff:10.168.1.0]:58888
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.224.47]:57544
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.2.230]:46026
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.172.224.50]:33588
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.174.0.73]:47678
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.168.10.109]:42816
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.8.55]:33566
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.174.1.12]:51078
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.10.2]:36970
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.225.189]:47168
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.129]:49888
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.3.59]:51868
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.174.8.55]:49644
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.174.8.83]:51928
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.249.161]:49994
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.32.70]:37808
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.225.108]:51256
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.168.6.60]:53942
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.174.8.59]:34580
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.0.249]:49930
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.174.0.79]:57528
0      0      [::ffff:10.172.248.57]:389       [::ffff:10.168.1.8]:55992
0      0      [::ffff:10.172.248.57]:389      [::ffff:10.174.0.93]:41462
0      0      [::ffff:10.172.248.57]:389    [::ffff:10.174.16.178]:59860
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.8.186]:36980
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.127]:60926
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.8.101]:41860
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.0.127]:60516
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.202]:59462
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.249.221]:43050
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.0.138]:42004
0      0      [::ffff:10.172.248.57]:389       [::ffff:10.174.1.6]:59740
0      0      [::ffff:10.172.248.57]:389   [::ffff:10.172.224.133]:38110
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.174.8.211]:36282
0      0      [::ffff:10.172.248.57]:389     [::ffff:10.168.8.172]:57142
[root@pln-petipareplica ~]#
