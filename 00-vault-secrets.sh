# Current DS errors log (full file, not just last lines)
sudo cp /var/log/dirsrv/slapd-IPA-CALIX-LOCAL/errors /tmp/cpeg-ds-errors-$(date +%F).log
sudo chown $(whoami) /tmp/cpeg-ds-errors-*.log


# The failed install log - most important single file
sudo cp /var/log/ipareplica-install.log /tmp/pln-petipareplica-install-$(date +%F).log
sudo chown $(whoami) /tmp/pln-petipareplica-install-*.log

# CA install log if present (from the pki-tomcatd phase)
sudo cp /var/log/ipareplica-ca-install.log /tmp/pln-petipareplica-ca-install-$(date +%F).log 2>/dev/null || echo "no ca install log"
