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
