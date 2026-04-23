cat <<EOF >/etc/apt/preferences.d/firefox
Package: firefox*
Pin: origin pln-landscape01.caal.dev
Pin-Priority: 1001
EOF


apt update
apt-cache policy firefox

apt-get install -s firefox
