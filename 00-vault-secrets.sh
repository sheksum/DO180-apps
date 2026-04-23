# From cpeg
dig @172.23.49.10 pln-petipareplica.ipa.calix.local +short

# From pln-petipareplica
dig @172.23.49.10 pln-petipareplica.ipa.calix.local +short


# Can pln-petipareplica reach cpeg?
nc -zv cpeg-ipareplica.ipa.calix.local 389
nc -zv cpeg-ipareplica.ipa.calix.local 88
nc -zv cpeg-ipareplica.ipa.calix.local 464

# Is pln-petipareplica's /etc/hosts clean?
grep -i "pln\|cpeg" /etc/hosts

# Time sync sanity
date
timedatectl status | grep -i "NTP\|sync"
