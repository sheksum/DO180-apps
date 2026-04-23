
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
  [11/22]: configuring Gssproxy
  [12/22]: setting up ssl
  [13/22]: configure certmonger for renewals
  [14/22]: publish CA cert
  [15/22]: clean up any existing httpd ccaches
  [16/22]: enable ccache sweep
  [17/22]: configuring SELinux for httpd
  [18/22]: create KDC proxy config
  [19/22]: enable KDC proxy
  [20/22]: starting httpd
  [21/22]: configuring httpd to start on boot
  [22/22]: enabling oddjobd
Done configuring the web interface (httpd).
Configuring ipa-otpd
  [1/2]: starting ipa-otpd
  [2/2]: configuring ipa-otpd to start on boot
Done configuring ipa-otpd.
Custodia uses 'cpeg-ipareplica.ipa.calix.local' as master peer.
Configuring ipa-custodia
  [1/4]: Generating ipa-custodia config file
  [2/4]: Generating ipa-custodia keys
  [3/4]: starting ipa-custodia
  [4/4]: configuring ipa-custodia to start on boot
Done configuring ipa-custodia.
Configuring certificate server (pki-tomcatd)
  [1/2]: configure certmonger for renewals
  [2/2]: Importing RA key
Done configuring certificate server (pki-tomcatd).
