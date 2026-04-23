# 1. Full sosreport (big, covers everything)
sudo sos report --batch --tmp-dir=/tmp

# 2. DS errors log (last 24 hours is fine, or copy the whole thing)
sudo cp /var/log/dirsrv/slapd-IPA-CALIX-LOCAL/errors /tmp/cpeg-ds-errors-$(date +%F).log

# 3. DS access log (compressed since it's huge)
sudo tar czf /tmp/cpeg-ds-access-$(date +%F).tgz /var/log/dirsrv/slapd-IPA-CALIX-LOCAL/access*


# 1. Full sosreport
sudo sos report --batch --tmp-dir=/tmp

# 2. The install log (this is what Red Hat most wants)
sudo cp /var/log/ipareplica-install.log /tmp/pln-petipareplica-install-$(date +%F).log

# 3. Also grab this if it exists
sudo cp /var/log/ipareplica-ca-install.log /tmp/pln-petipareplica-ca-install-$(date +%F).log 2>/dev/null


# From your laptop/jump box
scp cpeg-ipareplica:/tmp/sosreport-*.tar.xz ./
scp cpeg-ipareplica:/tmp/cpeg-*.log ./
scp cpeg-ipareplica:/tmp/cpeg-*.tgz ./

scp pln-petipareplica:/tmp/sosreport-*.tar.xz ./
scp pln-petipareplica:/tmp/pln-petipareplica-install*.log ./

scp sjcx-admin-old:/tmp/sosreport-*.tar.xz ./
scp sjcx-admin-old:/tmp/sjcx-abrt-*.tgz ./

redhat-support-tool addattachment -c <case_number> /tmp/sosreport-cpeg-*.tar.xz
