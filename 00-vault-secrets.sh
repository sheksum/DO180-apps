#!/bin/bash
# Commercial cluster discovery sweep
# Output goes to ./commercial-discovery-$(date +%F)/

OUT="./commercial-discovery-$(date +%F)"
mkdir -p $OUT

# Pillar 1: Baseline & topology
{ kubectl version; kubectl cluster-info; kubectl get nodes -o wide; ... } > $OUT/01-baseline.txt 2>&1

# Pillar 2: Control plane & etcd
# Pillar 3: HA / workload posture
# Pillar 4: Security
# Pillar 5: Storage
# Pillar 6: Network policies
# Pillar 7: Observability
# Pillar 8: Backups
# Pillar 9: Workload inventory
# Pillar 10: Specific patterns we found on kindo-ai

# Then a tarball
tar czf $OUT.tgz $OUT
