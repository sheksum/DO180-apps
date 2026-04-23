cat <<EOF >/etc/apt/preferences.d/firefox
Package: firefox*
Pin: release n=stable-mozilla-firefox-onprem
Pin-Priority: 1001
EOF
