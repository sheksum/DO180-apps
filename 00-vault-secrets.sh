# On pln-petipareplica
ipa-replica-install \
  --server=cpeg-ipareplica.ipa.calix.local \
  --domain=ipa.calix.local \
  --realm=IPA.CALIX.LOCAL \
  --principal=admin \
  --admin-password='vV+DyEsStenbkQq5TxLP5ly2wq/X4CPXW38mpDpCHUU=' \
  --no-ntp \
  --skip-conncheck \
  --unattended 2>&1 | tee /var/log/pln-petipareplica-install-$(date +%Y%m%d-%H%M).log
