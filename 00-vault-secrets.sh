ssh camslc4kbw01 'df -h /var/lib/kubelet /var/lib/rancher /var /'
ssh camslc4kbw01 'sudo du -sh /var/lib/kubelet/pods/ /var/lib/rancher/ 2>/dev/null'
