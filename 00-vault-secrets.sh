# On cpeg - verify pln-petipareplica is cleaned out
kinit admin
ipa-replica-manage list
ipa host-show pln-petipareplica.ipa.calix.local 2>&1

# Check for leftover RUV
sudo dsconf -D "cn=Directory Manager" ldap://cpeg-ipareplica.ipa.calix.local \
  repl-agmt list --suffix="dc=ipa,dc=calix,dc=local" 2>&1 | grep -iE "petipareplica|nsds50ruv"
