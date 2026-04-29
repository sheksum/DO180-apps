[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# kubectl get events -A --field-selector reason=EvictionThresholdMet -o json 2>/dev/null | \
  jq -r '.items[] | "\(.source.host)\t\(.message)\t\(.lastTimestamp)"' | sort | uniq -c | sort -rn | head
      1 camslc4kbc02.viasystems.pri     Attempting to reclaim ephemeral-storage 2026-04-29T14:52:47Z
      1 camslc4kbc01.viasystems.pri     Attempting to reclaim ephemeral-storage 2026-04-29T14:54:47Z
[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# 
[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# 
[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# ssh asvc.rhautomation@camslc4kbc01 'sudo df -hi /var/lib/kubelet /var/lib/rancher /var /'
The authenticity of host 'camslc4kbc01 (10.201.248.21)' can't be established.
ED25519 key fingerprint is SHA256:aDDwdukZQ819pfL12QnlL5nrRhRjMeBHfj61gKchOi4.
This host key is known by the following other names/addresses:
    ~/.ssh/known_hosts:1: bootstrap.kbai.viasystems.pri
    ~/.ssh/known_hosts:4: camslc4kbw01
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'camslc4kbc01' (ED25519) to the list of known hosts.
Authorized users only. All activity may be monitored and reported.
asvc.rhautomation@camslc4kbc01's password: 
Filesystem                        Inodes IUsed IFree IUse% Mounted on
/dev/mapper/kubelet_vg-kubelet_lv    75M   158   75M    1% /var/lib/kubelet
/dev/mapper/rancher_vg-rancher_lv    20M   11K   20M    1% /var/lib/rancher
/dev/mapper/rootvg-varlv             10M   82K   10M    1% /var
/dev/mapper/rootvg-rootlv           5.0M   78K  5.0M    2% /
[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# ssh asvc.rhautomation@camslc4kbc01 'sudo journalctl -u rke2-agent --since "1 hour ago" 2>/dev/null | grep -iE "evict|threshold|imagefs|nodefs|disk" | tail -20'
Authorized users only. All activity may be monitored and reported.
asvc.rhautomation@camslc4kbc01's password: 
[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# ssh asvc.rhautomation@camslc4kbc01 'cat /var/lib/rancher/rke2/agent/etc/kubelet.conf.d/*.conf 2>/dev/null | grep -iE "evict|imagefs|nodefs"'
Authorized users only. All activity may be monitored and reported.
asvc.rhautomation@camslc4kbc01's password: 
[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# ssh asvc.rhautomation@camslc4kbc02 'sudo df -hi /var/lib/kubelet /var/lib/rancher /var /'
The authenticity of host 'camslc4kbc02 (10.201.248.22)' can't be established.
ED25519 key fingerprint is SHA256:aDDwdukZQ819pfL12QnlL5nrRhRjMeBHfj61gKchOi4.
This host key is known by the following other names/addresses:
    ~/.ssh/known_hosts:1: bootstrap.kbai.viasystems.pri
    ~/.ssh/known_hosts:4: camslc4kbw01
    ~/.ssh/known_hosts:5: camslc4kbc01
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'camslc4kbc02' (ED25519) to the list of known hosts.
Authorized users only. All activity may be monitored and reported.
asvc.rhautomation@camslc4kbc02's password: 
Filesystem                        Inodes IUsed IFree IUse% Mounted on
/dev/mapper/kubelet_vg-kubelet_lv    75M   155   75M    1% /var/lib/kubelet
/dev/mapper/rancher_vg-rancher_lv    22M   11K   22M    1% /var/lib/rancher
/dev/mapper/rootvg-varlv             10M   79K   10M    1% /var
/dev/mapper/rootvg-rootlv           5.0M   77K  5.0M    2% /
[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# ssh asvc.rhautomation@camslc4kbc02 'sudo journalctl -u rke2-agent --since "1 hour ago" 2>/dev/null | grep -iE "evict|threshold|imagefs|nodefs|disk" | tail -20'
Authorized users only. All activity may be monitored and reported.
asvc.rhautomation@camslc4kbc02's password: 
[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# ssh asvc.rhautomation@camslc4kbc02 'cat /var/lib/rancher/rke2/agent/etc/kubelet.conf.d/*.conf 2>/dev/null | grep -iE "evict|imagefs|nodefs"'
Authorized users only. All activity may be monitored and reported.
asvc.rhautomation@camslc4kbc02's password: 
[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# ssh asvc.rhautomation@camslc4kbw01 'sudo df -hi /var/lib/kubelet /var/lib/rancher /var /'
Authorized users only. All activity may be monitored and reported.
asvc.rhautomation@camslc4kbw01's password: 
Filesystem                        Inodes IUsed IFree IUse% Mounted on
/dev/mapper/kubelet_vg-kubelet_lv    75M   972   75M    1% /var/lib/kubelet
/dev/mapper/rancher_vg-rancher_lv    75M  1.3M   74M    2% /var/lib/rancher
/dev/mapper/rootvg-varlv             10M   78K   10M    1% /var
/dev/mapper/rootvg-rootlv           5.0M   77K  5.0M    2% /
[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# ssh asvc.rhautomation@camslc4kbw01 'sudo journalctl -u rke2-agent --since "1 hour ago" 2>/dev/null | grep -iE "evict|threshold|imagefs|nodefs|disk" | tail -20'
Authorized users only. All activity may be monitored and reported.
asvc.rhautomation@camslc4kbw01's password: 
[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# ssh asvc.rhautomation@camslc4kbw01 'cat /var/lib/rancher/rke2/agent/etc/kubelet.conf.d/*.conf 2>/dev/null | grep -iE "evict|imagefs|nodefs"'
Authorized users only. All activity may be monitored and reported.
asvc.rhautomation@camslc4kbw01's password: 
[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# 
