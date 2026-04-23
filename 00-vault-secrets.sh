Unattended mode was selected, installer will NOT run ipa-sidgen task!
Disabled p11-kit-proxy
Configuring directory server (dirsrv). Estimated time: 30 seconds
  [1/40]: creating directory server instance
Validate installation settings ...
Create file system structures ...
Perform SELinux labeling ...
Create database backend: dc=ipa,dc=calix,dc=local ...
Perform post-installation tasks ...
  [2/40]: tune ldbm plugin
  [3/40]: adding default schema
  [4/40]: enabling memberof plugin
  [5/40]: enabling winsync plugin
  [6/40]: configure password logging
  [7/40]: configuring replication version plugin
  [8/40]: enabling IPA enrollment plugin
  [9/40]: configuring uniqueness plugin
  [10/40]: configuring uuid plugin
  [11/40]: configuring modrdn plugin
  [12/40]: configuring DNS plugin
  [13/40]: enabling entryUSN plugin
  [14/40]: configuring lockout plugin
  [15/40]: configuring graceperiod plugin
  [16/40]: configuring topology plugin
  [17/40]: creating indices
  [18/40]: enabling referential integrity plugin
  [19/40]: configuring certmap.conf
  [20/40]: configure new location for managed entries
  [21/40]: configure dirsrv ccache and keytab
  [22/40]: enabling SASL mapping fallback
  [23/40]: restarting directory server
  [24/40]: creating DS keytab
  [25/40]: ignore time skew for initial replication
  [26/40]: setting up initial replication
Starting replication, please wait until this has completed.
Update in progress, 22 seconds elapsed
Update succeeded

  [27/40]: prevent time skew after initial replication
  [28/40]: adding sasl mappings to the directory
  [29/40]: updating schema
  [30/40]: setting Auto Member configuration
  [31/40]: enabling S4U2Proxy delegation
  [32/40]: initializing group membership
  [33/40]: adding master entry
  [34/40]: initializing domain level
  [35/40]: configuring Posix uid/gid generation
  [36/40]: adding replication acis
  [37/40]: activating sidgen plugin
  [38/40]: activating extdom plugin
  [39/40]: configuring directory to start on boot
  [40/40]: restarting directory server
Done configuring directory server (dirsrv).
Replica DNS records could not be added on master: Insufficient access: Insufficient 'add' privilege to add the entry 'idnsname=pln-petipareplica,idnsname=ipa.calix.local.,cn=dns,dc=ipa,dc=calix,dc=local'.
Configuring Kerberos KDC (krb5kdc)
  [1/5]: configuring KDC
  [2/5]: adding the password extension to the directory
  [3/5]: creating anonymous principal
  [4/5]: starting the KDC
  [5/5]: configuring KDC to start on boot
Done configuring Kerberos KDC (krb5kdc).
Configuring kadmin
  [1/2]: starting kadmin
  [2/2]: configuring kadmin to start on boot
Done configuring kadmin.
Configuring directory server (dirsrv)
  [1/3]: configuring TLS for DS instance
  [2/3]: importing CA certificates from LDAP
  [3/3]: restarting directory server
Done configuring directory server (dirsrv).
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
