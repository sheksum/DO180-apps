# Which node is actually firing the evictions? Find the source.
kubectl get events -A --field-selector reason=EvictionThresholdMet -o json 2>/dev/null | \
  jq -r '.items[] | "\(.source.host)\t\(.message)\t\(.lastTimestamp)"' | sort | uniq -c | sort -rn | head

# Inode usage on the suspect node
ssh asvc.rhautomation@camslc4kbw01 'sudo df -hi /var/lib/kubelet /var/lib/rancher /var /'

# What kubelet thinks about its filesystems
ssh asvc.rhautomation@camslc4kbw01 'sudo journalctl -u rke2-agent --since "1 hour ago" 2>/dev/null | grep -iE "evict|threshold|imagefs|nodefs|disk" | tail -20'

# And what the kubelet config says about thresholds
ssh asvc.rhautomation@camslc4kbw01 'cat /var/lib/rancher/rke2/agent/etc/kubelet.conf.d/*.conf 2>/dev/null | grep -iE "evict|imagefs|nodefs"'
