# Watch fresh errors in real-time
sudo tail -f /var/log/dirsrv/slapd-IPA-CALIX-LOCAL/errors | grep -E "pln-petipareplica|keytab|SASL|permission|ACL"

# Count connections currently from pln-petipareplica's IP
sudo ss -tn state established '( dport = :389 or sport = :389 )' | grep 10.172.248.57

# Check for any new principals being created  
sudo grep "ADD" /var/log/dirsrv/slapd-IPA-CALIX-LOCAL/access | grep -i "pln-petipareplica" | tail -10

# Check ipa-replica-manage to see if pln-petipareplica joined topology
ipa-replica-manage list 2>&1
ipa host-show pln-petipareplica.ipa.calix.local 2>&1
