# Align Ceph Hosts with Static Worker Node Count

## Goal
Ensure that all static worker nodes are present in the Ceph cluster. Identify any nodes that are missing, wipe their disks if previously used as hypervisors, and allow Ceph to detect them.

---

## 1. Identify Missing Nodes in Ceph

```bash
# Access the Ceph tools pod
kubectl exec -it rook-ceph-tools-<id> -n rook-ceph -- bash

# List current hosts in Ceph
ceph osd tree
```

Then compare with the Kubernetes node list:

```bash
kubectl get nodes
```

Identify any node that appears in `kubectl get nodes` but not in `ceph osd tree`.

---

## 2. Drain and Access the Node

```bash
kubectl drain <node-name>
ssh <node-name>
sudo su -
```

---

## 3. Clean the Disk

### List Disks
```bash
lsblk
blkid
```

Check for any disks with Linux software RAID headers or previous Ceph usage.

### Stop RAID if present
```bash
mdadm --stop /dev/mdX
```

### Wipe Beginning of Disk
```bash
wipefs -a /dev/sdX
dd if=/dev/zero of=/dev/sdX bs=1M count=10
```

### Check Disk Size
```bash
fdisk -l /dev/sdX
```

Sample output:
```
Disk /dev/sdX: 549 MiB, 575668224 bytes, ...
```

---

## 4. Scrub the End of the Disk

To ensure all trailing metadata is removed, subtract 5 MiB (5242880 bytes) from the total disk size:

```bash
# Remove trailing metadata
dd if=/dev/zero of=/dev/sdX bs=512 seek=$(( (575668224 - 5242880) / 512 )) count=10240
```

> Replace `575668224` with the actual byte size from your `fdisk` output.

---

## 5. Delete Machine Resources

### Find the Associated Machine
```bash
kubectl get machines -A -o wide | grep <node-name>
```

### Delete Both Machine and Metal3Machine
```bash
kubectl delete machine <machine-name> -n <namespace>
kubectl delete metal3machine <metal3machine-name> -n <namespace>
```

---

## 6. Trigger Node Remediation

### Check Remediation Status
```bash
kubectl get metal3remediation -n <namespace>
```

If `RETRY COUNT` has reached the `RETRY LIMIT`, bump the limit to retrigger:

```bash
kubectl patch metal3remediation <remediation-name>   -n <namespace> --type merge   -p '{"spec": {"retryLimit": <new-value>}}'
```

Example:
```bash
kubectl patch metal3remediation kvalgen-1-workload-static-workers-m69nk-kvsn7   -n kvalgen-1 --type merge   -p '{"spec": {"retryLimit": 3}}'
```

Then watch for the remediation to kick off:
```bash
kubectl get metal3remediation -n <namespace> <remediation-name> -w
```

---

## 7. Restart Rook Operator to Detect Cleaned Disks

```bash
kubectl rollout restart deployment/rook-ceph-operator -n rook-ceph
```

