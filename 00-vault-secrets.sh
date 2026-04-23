# On cpeg (already kinited as hsuma)
# Add forward A record
ipa dnsrecord-add ipa.calix.local pln-petipareplica --a-rec=10.172.248.57

# Add PTR record
# First check what reverse zone exists
ipa dnszone-find | grep -i "248"



# On pln-petipareplica (after DNS is set up)
ipa-replica-install \
  --server=cpeg-ipareplica.ipa.calix.local \
  --domain=ipa.calix.local \
  --realm=IPA.CALIX.LOCAL \
  --principal=admin \
  --admin-password='<admin-password>' \
  --no-ntp \
  --skip-conncheck \
  --unattended
