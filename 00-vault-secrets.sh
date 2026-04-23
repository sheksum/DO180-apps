# On cpeg
kinit admin
ipa host-del pln-petipareplica.ipa.calix.local --updatedns 2>&1

# Verify
ipa host-show pln-petipareplica.ipa.calix.local 2>&1


# On cpeg
ipa dnsrecord-add ipa.calix.local pln-petipareplica --a-rec=10.172.248.57
dig @172.23.49.10 pln-petipareplica.ipa.calix.local +short

# On cpeg - pre-create host (generates one-time password)
ipa host-add pln-petipareplica.ipa.calix.local --ip-address=10.172.248.57 --force

# Add to ipaservers group (required for replica)
ipa hostgroup-add-member ipaservers --hosts=pln-petipareplica.ipa.calix.local

# Pre-create HTTP service
ipa service-add HTTP/pln-petipareplica.ipa.calix.local

# Verify all three
ipa host-show pln-petipareplica.ipa.calix.local
ipa service-show HTTP/pln-petipareplica.ipa.calix.local
