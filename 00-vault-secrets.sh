# Confirm clean state
rpm -qa | grep -E "ipa-server|389-ds-base|pki-" | sort
ls /etc/dirsrv/ 2>/dev/null
ls /var/lib/ipa/sysrestore/ 2>/dev/null
sudo systemctl is-active dirsrv@IPA-CALIX-LOCAL 2>&1
hostname -f
cat /etc/resolv.conf


# Confirm pln-petipareplica is not in topology
ipa host-show pln-petipareplica.ipa.calix.local 2>&1
ipa-replica-manage list

# DNS should resolve pln-petipareplica — add if needed
dig @172.23.49.10 pln-petipareplica.ipa.calix.local +short
dig @172.23.49.10 -x <pln-petipareplica IP> +short
