asvc.rhautomation@camslc4kbw01's password: 
Filesystem                         Size  Used Avail Use% Mounted on
/dev/mapper/kubelet_vg-kubelet_lv  150G  1.2G  149G   1% /var/lib/kubelet
/dev/mapper/rancher_vg-rancher_lv  150G   52G   99G  35% /var/lib/rancher
/dev/mapper/rootvg-varlv            20G  9.4G   11G  47% /var
/dev/mapper/rootvg-rootlv           10G  3.5G  6.5G  36% /
[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# ssh camslc4kbw01 'sudo du -sh /var/lib/kubelet/pods/ /var/lib/rancher/ 2>/dev/null'
Authorized users only. All activity may be monitored and reported.
root@camslc4kbw01's password: 

[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# ssh asvc.rhautomation@camslc4kbw01 'sudo du -sh /var/lib/kubelet/pods/ /var/lib/rancher/ 2>/dev/null'
Authorized users only. All activity may be monitored and reported.
asvc.rhautomation@camslc4kbw01's password: 
3.1G    /var/lib/kubelet/pods/
50G     /var/lib/rancher/
[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# 
