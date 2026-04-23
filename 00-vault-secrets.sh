# On pln-petipareplica
sudo systemctl is-active dirsrv@IPA-CALIX-LOCAL krb5kdc kadmin httpd pki-tomcatd ipa

# Is it registered as a master?
kinit admin
ipa server-find pln-petipareplica.ipa.calix.local 2>&1

# Try logging in via CLI (may give clearer error than web UI)
kdestroy
kinit admin
ipa user-show admin

# On pln-petipareplica
sudo tail -30 /var/log/httpd/error_log
sudo tail -30 /var/log/krb5kdc.log
