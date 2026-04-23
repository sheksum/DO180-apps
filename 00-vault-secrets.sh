# Can it serve a user lookup?
ldapsearch -x -H ldap://pln-petipareplica.ipa.calix.local -b "cn=users,cn=accounts,dc=ipa,dc=calix,dc=local" "(uid=hsuma)" uid uidNumber 2>&1 | tail -10

# KDC ports
sudo ss -tlnp | grep -E ":88|:464|:389"

# Services status  
sudo systemctl is-active dirsrv@IPA-CALIX-LOCAL krb5kdc kadmin
