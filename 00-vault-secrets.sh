root@sdaxos-u22-mrollins:~# cat <<EOF >/etc/apt/preferences.d/firefox
Package: firefox*
Pin: release n=stable-mozilla-firefox-onprem
Pin-Priority: 1001
EOF
root@sdaxos-u22-mrollins:~#
root@sdaxos-u22-mrollins:~# apt update
Hit:1 http://pln-landscape01.caal.dev/repository/standalone/ubuntu-jammy-onprem jammy-updates InRelease
Hit:2 http://pln-landscape01.caal.dev/repository/standalone/ubuntu-jammy-onprem jammy-security InRelease
Hit:3 http://pln-landscape01.caal.dev/repository/standalone/ubuntu-jammy-onprem jammy InRelease
Hit:4 http://pln-landscape01.caal.dev/repository/standalone/third-party stable-grafana-onprem InRelease
Hit:5 http://pln-landscape01.caal.dev/repository/standalone/third-party stable-google-chrome-onprem InRelease
Hit:6 http://pln-landscape01.caal.dev/repository/standalone/third-party stable-microsoft-vscode-onprem InRelease
Hit:7 http://pln-landscape01.caal.dev/repository/standalone/third-party stable-mozilla-firefox-onprem InRelease
Hit:8 http://pln-landscape01.caal.dev/repository/standalone/ubuntu-jammy-onprem jammy-docker-jammy-onprem InRelease
Hit:9 https://packages.microsoft.com/repos/code stable InRelease
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
2 packages can be upgraded. Run 'apt list --upgradable' to see them.
root@sdaxos-u22-mrollins:~# apt-cache policy firefox
firefox:
  Installed: (none)
  Candidate: 150.0~build1
  Version table:
     1:1snap1-0ubuntu2 500
        500 http://pln-landscape01.caal.dev/repository/standalone/ubuntu-jammy-onprem jammy/main amd64 Packages
     150.0~build1 1001
        500 http://pln-landscape01.caal.dev/repository/standalone/third-party stable-mozilla-firefox-onprem/main amd64 Packages
root@sdaxos-u22-mrollins:~# apt-get install -s firefox
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following NEW packages will be installed:
  firefox
0 upgraded, 1 newly installed, 0 to remove and 2 not upgraded.
Inst firefox (150.0~build1 stable-mozilla-firefox-onprem [amd64])
Conf firefox (150.0~build1 stable-mozilla-firefox-onprem [amd64])
root@sdaxos-u22-mrollins:~#
