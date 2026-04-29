#!/bin/bash
#
# RKE2 Cluster Discovery Sweep
# ============================
# Runs a comprehensive read-only discovery against an RKE2 cluster.
# Designed to mirror the discovery pattern used on the kindo-ai cluster,
# adapted to learn about a new RKE2 environment from scratch.
#
# Usage (from a control-plane node):
#   sudo bash rke2-discovery.sh
#
# Or from any host with kubectl + kubeconfig:
#   KUBECONFIG=/path/to/kubeconfig bash rke2-discovery.sh
#
# Output:
#   Creates ./rke2-discovery-<date>/ with one file per pillar
#   Tarballs the directory at the end for easy sharing
#
# This script is READ-ONLY. It does not modify cluster state.

set +e  # don't bail on first error - we want all commands to attempt

# ---------- setup ----------
DATE=$(date +%F-%H%M)
OUT="./rke2-discovery-${DATE}"
mkdir -p "$OUT"

# Try to set up kubeconfig if running on RKE2 control plane
if [ -z "$KUBECONFIG" ] && [ -f /etc/rancher/rke2/rke2.yaml ]; then
  export KUBECONFIG=/etc/rancher/rke2/rke2.yaml
fi

# Helper: run a command and label its output
run() {
  local label="$1"; shift
  echo "==== $label ===="
  echo "\$ $*"
  eval "$@" 2>&1
  echo
}

# Helper: dump a section to a file
section() {
  local file="$1"; shift
  local title="$1"; shift
  exec > "$OUT/$file"
  echo "================================================"
  echo "  $title"
  echo "  Generated: $(date)"
  echo "================================================"
  echo
}

# Reset stdout helper
stdout() { exec > /dev/tty 2>&1 || exec > /dev/stdout; }

# ---------- 01: Baseline ----------
section "01-baseline.txt" "Baseline cluster info"
run "kubectl version" kubectl version
run "kubectl cluster-info" kubectl cluster-info
run "Server URL the kubeconfig points to" "kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}{\"\\n\"}'"
run "RKE2 version (if running on a server node)" "rke2 --version 2>/dev/null || echo 'not on a server node'"
run "Nodes (wide)" kubectl get nodes -o wide
run "Nodes with full labels" kubectl get nodes --show-labels
run "Namespaces" kubectl get ns

# ---------- 02: Control plane & etcd ----------
section "02-control-plane.txt" "Control plane configuration and etcd"
run "RKE2 config.yaml (server node only; check on each control plane)" "cat /etc/rancher/rke2/config.yaml 2>/dev/null || echo 'not on a server node'"
run "RKE2 server systemd status" "systemctl status rke2-server 2>/dev/null | head -30 || echo 'not a server node'"
run "Static pod manifests directory" "ls -la /var/lib/rancher/rke2/agent/pod-manifests/ 2>/dev/null"
run "Auto-deployed manifests" "ls /var/lib/rancher/rke2/server/manifests/ 2>/dev/null"
run "etcd snapshot directory contents" "ls -lh /var/lib/rancher/rke2/server/db/snapshots/ 2>/dev/null | tail -10"
run "etcd snapshot count" "ls /var/lib/rancher/rke2/server/db/snapshots/ 2>/dev/null | wc -l"
run "Recent rke2-server log errors (last 24h)" "journalctl -u rke2-server --since '24 hours ago' 2>/dev/null | grep -iE 'error|fail|warning' | tail -30"
run "etcd pod status" "kubectl -n kube-system get pods -l component=etcd -o wide"
run "kube-apiserver running args (encryption, audit, etc.)" "ps auxww 2>/dev/null | grep kube-apiserver | grep -oE -- '--[a-z-]+(=[^ ]+)?' | sort"
run "Audit policy file" "cat /etc/kubernetes/audit/policy.yaml 2>/dev/null"
run "Audit log directory" "ls -lh /var/log/kubernetes/audit/ 2>/dev/null"

# ---------- 03: HA-related items ----------
section "03-ha-resilience.txt" "HA, resilience, replicas, PDBs"
run "All deployments cluster-wide" "kubectl get deploy -A"
run "All statefulsets cluster-wide" "kubectl get sts -A"
run "All daemonsets cluster-wide" "kubectl get ds -A"
run "PodDisruptionBudgets cluster-wide" "kubectl get pdb -A"
run "HorizontalPodAutoscalers cluster-wide" "kubectl get hpa -A"
run "PriorityClasses defined" "kubectl get priorityclass"
run "Single-replica deployments (excluding system namespaces)" "kubectl get deploy -A -o json | jq -r '.items[] | select(.spec.replicas==1) | select(.metadata.namespace | test(\"^(kube-|cattle-|longhorn|gpu-operator)\") | not) | \"\\(.metadata.namespace)/\\(.metadata.name)\"' 2>/dev/null"
run "Multi-replica deployments WITHOUT pod anti-affinity or topology spread" "kubectl get deploy -A -o json | jq -r '.items[] | select((.spec.replicas // 0) > 1) | select(.spec.template.spec.affinity.podAntiAffinity == null and .spec.template.spec.topologySpreadConstraints == null) | select(.metadata.namespace | test(\"^(kube-|cattle-|longhorn|gpu-operator)\") | not) | \"\\(.metadata.namespace)/\\(.metadata.name)\"' 2>/dev/null"
run "Pods missing readiness probes (user namespaces)" "kubectl get pods -A -o json | jq -r '.items[] | select(.metadata.namespace | test(\"^(kube-|cattle-|longhorn|gpu-operator)\") | not) | select(.spec.containers[]?.readinessProbe == null) | \"\\(.metadata.namespace)/\\(.metadata.name)\"' 2>/dev/null | sort -u | head -50"
run "Pods missing resource requests/limits (user namespaces)" "kubectl get pods -A -o json | jq -r '.items[] | select(.metadata.namespace | test(\"^(kube-|cattle-|longhorn|gpu-operator)\") | not) | select(.spec.containers[]? | .resources.requests == null or .resources.limits == null) | \"\\(.metadata.namespace)/\\(.metadata.name)\"' 2>/dev/null | sort -u | head -50"
run "CoreDNS replica count" "kubectl -n kube-system get deploy rke2-coredns-rke2-coredns -o jsonpath='{.spec.replicas}{\"\\n\"}' 2>/dev/null"
run "Ingress controller pod placement" "kubectl -n kube-system get pods -l app.kubernetes.io/name=rke2-ingress-nginx -o wide 2>/dev/null"

# ---------- 04: Security ----------
section "04-security.txt" "Security posture"
run "RKE2 CIS profile flag" "grep -i '^profile:' /etc/rancher/rke2/config.yaml 2>/dev/null || echo 'not on a server node or profile not set'"
run "PSA admission config file" "ls /etc/rancher/rke2/rke2-pss.yaml 2>/dev/null && cat /etc/rancher/rke2/rke2-pss.yaml 2>/dev/null"
run "PSA enforce labels per namespace" "kubectl get ns -o json | jq -r '.items[] | \"\\(.metadata.name)\\tenforce=\\(.metadata.labels[\"pod-security.kubernetes.io/enforce\"] // \"NONE\")\\tversion=\\(.metadata.labels[\"pod-security.kubernetes.io/enforce-version\"] // \"-\")\"' | column -t"
run "Secrets encryption status (CLI)" "rke2 secrets-encrypt status 2>&1 || /var/lib/rancher/rke2/bin/rke2 secrets-encrypt status 2>&1"
run "Cluster-admin role bindings" "kubectl get clusterrolebinding -o json | jq -r '.items[] | select(.roleRef.name==\"cluster-admin\") | \"\\(.metadata.name)\\t\\(.subjects // [] | map(\"\\(.kind):\\(.namespace // \\\"-\\\")/\\(.name)\") | join(\" , \"))\"'"
run "Privileged or host-access pods" "kubectl get pods -A -o json | jq -r '.items[] | select((.spec.containers[]?.securityContext.privileged==true) or (.spec.hostNetwork==true) or (.spec.hostPID==true)) | \"\\(.metadata.namespace)/\\(.metadata.name)\\tpriv=\\([.spec.containers[]?.securityContext.privileged] | any)\\thostNet=\\(.spec.hostNetwork // false)\\thostPID=\\(.spec.hostPID // false)\"' | sort -u"
run "Pods that don't enforce non-root (user namespaces)" "kubectl get pods -A -o json | jq -r '.items[] | select(.metadata.namespace | test(\"^(kube-|cattle-|longhorn|gpu-operator)\") | not) | select([.spec.containers[]? | (.securityContext.runAsNonRoot == true)] | all | not) | \"\\(.metadata.namespace)/\\(.metadata.name)\"' | sort -u | wc -l"
run "Default ServiceAccount auto-mount on user namespaces" "kubectl get sa default -A -o json | jq -r '.items[] | select((.automountServiceAccountToken // true) == true) | .metadata.namespace' | grep -Ev '^(kube-|cattle-|longhorn|rancher|gpu-operator)' | head"
run "Validating webhooks" "kubectl get validatingwebhookconfiguration"
run "Mutating webhooks" "kubectl get mutatingwebhookconfiguration"
run "Policy engine CRDs (kyverno, gatekeeper, etc.)" "kubectl get crd | grep -Ei 'kyverno|gatekeeper|constraint|policy'"

# ---------- 05: Network policies & ingress ----------
section "05-network.txt" "Network policies and ingress"
run "Namespaces with ZERO NetworkPolicies" "for ns in \$(kubectl get ns -o name | cut -d/ -f2); do count=\$(kubectl -n \$ns get netpol --no-headers 2>/dev/null | wc -l); [ \"\$count\" -eq 0 ] && echo \"  \$ns\"; done"
run "All NetworkPolicies" "kubectl get netpol -A"
run "All ingresses" "kubectl get ingress -A -o wide"
run "Ingress auth annotations and TLS status" "kubectl get ingress -A -o json | jq -r '.items[] | \"\\(.metadata.namespace)/\\(.metadata.name)\\thosts=\\([.spec.rules[]?.host] | join(\",\"))\\ttls=\\((.spec.tls // []) | length)\\tauth_url=\\(.metadata.annotations[\"nginx.ingress.kubernetes.io/auth-url\"] // \"none\")\"' | column -t"
run "NodePort and LoadBalancer services" "kubectl get svc -A -o json | jq -r '.items[] | select(.spec.type==\"NodePort\" or .spec.type==\"LoadBalancer\") | \"\\(.metadata.namespace)/\\(.metadata.name)\\ttype=\\(.spec.type)\"'"
run "CNI in use" "kubectl -n kube-system get pods 2>/dev/null | grep -Ei 'canal|cilium|calico|flannel|weave|antrea' | head -5"

# ---------- 06: Storage ----------
section "06-storage.txt" "Storage: Longhorn, PVCs, storage classes"
run "Storage classes" "kubectl get storageclass -o json | jq -r '.items[] | \"\\(.metadata.name)\\tprovisioner=\\(.provisioner)\\tdefault=\\(.metadata.annotations[\"storageclass.kubernetes.io/is-default-class\"] // \"false\")\"'"
run "Total PVCs by storage class" "kubectl get pvc -A -o json | jq -r '.items[].spec.storageClassName' | sort | uniq -c | sort -rn"
run "PVCs not Bound" "kubectl get pvc -A -o json | jq -r '.items[] | select(.status.phase != \"Bound\") | \"\\(.metadata.namespace)/\\(.metadata.name)\\t\\(.status.phase)\"'"
run "Longhorn namespace check" "kubectl get ns | grep -i longhorn"
run "Longhorn pods" "kubectl -n longhorn get pods 2>/dev/null | head -20 || kubectl -n longhorn-system get pods 2>/dev/null | head -20"
run "Longhorn settings (key items)" "kubectl get settings.longhorn.io -A -o json 2>/dev/null | jq -r '.items[] | select(.metadata.name | test(\"replica|backup|node|anti-affinity|data-locality|drain\")) | \"\\(.metadata.name) = \\(.value)\"'"
run "Longhorn backup target" "kubectl get backuptarget.longhorn.io -A 2>/dev/null"
run "Longhorn recurring jobs" "kubectl get recurringjob.longhorn.io -A 2>/dev/null"
run "Longhorn volume state summary" "kubectl get volumes.longhorn.io -A -o json 2>/dev/null | jq -r '.items[] | .status.state' | sort | uniq -c"
run "Longhorn volume robustness" "kubectl get volumes.longhorn.io -A -o json 2>/dev/null | jq -r '.items[] | .status.robustness' | sort | uniq -c"
run "hostPath volumes (excluding system namespaces)" "kubectl get pods -A -o json | jq -r '.items[] as \$p | \$p.spec.volumes[]? | select(.hostPath != null) | \"\\(\$p.metadata.namespace)/\\(\$p.metadata.name)\\tpath=\\(.hostPath.path)\"' | grep -viE '^(kube-|cattle-|longhorn|gpu-operator|cnpg-system|minio-operator|rabbitmq-system|redis-operator|logging)' | sort -u"
run "Uncapped emptyDir volumes by namespace count" "kubectl get pods -A -o json | jq -r '.items[] as \$p | \$p.spec.volumes[]? | select(.emptyDir != null and .emptyDir.sizeLimit == null) | \"\\(\$p.metadata.namespace)\"' | grep -viE '^(kube-|cattle-|longhorn|logging)' | sort | uniq -c | sort -rn"

# ---------- 07: Backup & DR ----------
section "07-backup-dr.txt" "Backup and disaster recovery"
run "Velero presence" "kubectl get ns velero 2>/dev/null"
run "Velero CRDs" "kubectl get crd | grep -i velero"
run "Velero backups" "kubectl -n velero get backups,schedules,backupstoragelocations,restores 2>/dev/null"
run "VolumeSnapshotClass" "kubectl get volumesnapshotclass 2>/dev/null"
run "VolumeSnapshots" "kubectl get volumesnapshot -A 2>/dev/null | head -20"
run "CNPG Postgres clusters" "kubectl get cluster.postgresql.cnpg.io -A 2>/dev/null"
run "CNPG cluster backup config" "kubectl get cluster.postgresql.cnpg.io -A -o json 2>/dev/null | jq -r '.items[] | \"\\(.metadata.namespace)/\\(.metadata.name)\\tinstances=\\(.spec.instances)\\tbackup=\\(.spec.backup.barmanObjectStore.destinationPath // \"NONE\")\"'"
run "CNPG ScheduledBackups" "kubectl get scheduledbackup.postgresql.cnpg.io -A 2>/dev/null"
run "CNPG most recent Backups" "kubectl get backup.postgresql.cnpg.io -A 2>/dev/null | tail -10"
run "Cohesity-related resources or annotations (best-effort)" "kubectl get all -A -o json 2>/dev/null | jq -r '.items[]? | select((.metadata.annotations // {}) | tostring | test(\"cohesity\"; \"i\")) | \"\\(.kind) \\(.metadata.namespace)/\\(.metadata.name)\"' | head"

# ---------- 08: Observability ----------
section "08-observability.txt" "Monitoring, logging, tracing"
run "cattle-monitoring-system pods" "kubectl -n cattle-monitoring-system get pods 2>/dev/null"
run "Prometheus replica/retention/remoteWrite" "kubectl -n cattle-monitoring-system get prometheus -o json 2>/dev/null | jq -r '.items[] | \"replicas=\\(.spec.replicas)\\tretention=\\(.spec.retention)\\tretentionSize=\\(.spec.retentionSize // \"unset\")\\tremoteWrite=\\((.spec.remoteWrite // []) | length)\"'"
run "Alertmanager replica count" "kubectl -n cattle-monitoring-system get alertmanager -o json 2>/dev/null | jq -r '.items[] | \"replicas=\\(.spec.replicas)\"'"
run "Alertmanager configured receivers (decoded)" "kubectl -n cattle-monitoring-system get secret alertmanager-rancher-monitoring-alertmanager -o jsonpath='{.data.alertmanager\\.yaml}' 2>/dev/null | base64 -d | grep -iE 'receiver|pagerduty|slack|webhook|opsgenie|email' | head -30"
run "PrometheusRule count" "kubectl get prometheusrule -A --no-headers 2>/dev/null | wc -l"
run "ServiceMonitor count by namespace" "kubectl get servicemonitor -A --no-headers 2>/dev/null | awk '{print \$1}' | sort | uniq -c"
run "Logging namespace pods" "kubectl -n logging get pods 2>/dev/null"
run "Logging CRDs" "kubectl get crd 2>/dev/null | grep -Ei 'logging|flow|output|fluent|loki|vector'"
run "Audit log exporter" "kubectl get ns audit-log-exporter 2>/dev/null && kubectl -n audit-log-exporter get pods 2>/dev/null"
run "OpenTelemetry / tracing CRDs" "kubectl get crd 2>/dev/null | grep -Ei 'opentelemetry|jaeger|tempo|trace'"
run "Metrics server check" "kubectl top nodes 2>/dev/null | head -15"

# ---------- 09: Lifecycle & GitOps ----------
section "09-lifecycle.txt" "Versioning, drift, GitOps"
run "Node version distribution" "kubectl get nodes -o json | jq -r '.items[] | \"\\(.metadata.name)\\t\\(.status.nodeInfo.kubeletVersion)\\t\\(.status.nodeInfo.osImage)\\t\\(.status.nodeInfo.kernelVersion)\"'"
run "cattle-fleet-system presence" "kubectl get ns cattle-fleet-system 2>/dev/null && kubectl -n cattle-fleet-system get pods 2>/dev/null"
run "Fleet GitRepos" "kubectl get gitrepos.fleet.cattle.io -A 2>/dev/null"
run "Fleet Bundles" "kubectl get bundles.fleet.cattle.io -A 2>/dev/null | head"
run "Flux CRDs" "kubectl get crd 2>/dev/null | grep -i flux"
run "Argo CD CRDs" "kubectl get crd 2>/dev/null | grep -i argoproj"
run "System upgrade plans" "kubectl get plans.upgrade.cattle.io -A 2>/dev/null"
run "Helm releases" "helm list -A 2>/dev/null"
run "Helm releases that are not Deployed" "helm list -A --all 2>/dev/null | awk 'NR>1 && \$8 != \"deployed\"'"
run "Image registries in use (sources)" "kubectl get pods -A -o json | jq -r '.items[].spec.containers[].image' | awk -F/ '{if (NF==1) print \"docker.io (implicit)\"; else print \$1}' | sort | uniq -c | sort -rn"
run "Images using :latest tag" "kubectl get pods -A -o json | jq -r '.items[].spec.containers[] | select(.image | test(\":latest\\$|^[^:]+\\$\")) | \"\\(.image)\"' | sort -u"
run "ImagePullBackOff or ErrImagePull pods" "kubectl get pods -A 2>/dev/null | grep -Ei 'ImagePullBackOff|ErrImagePull|InvalidImageName'"

# ---------- 10: Workload inventory & known patterns ----------
section "10-workload-inventory.txt" "Workload inventory and pattern recognition"
run "All running pods, namespace summary" "kubectl get pods -A --no-headers 2>/dev/null | awk '{print \$1}' | sort | uniq -c | sort -rn"
run "Failed/Pending/CrashLoop pods" "kubectl get pods -A 2>/dev/null | grep -vE 'Running|Completed' | head -30"
run "Recent warning events (last hour)" "kubectl get events -A --field-selector type=Warning --sort-by=.lastTimestamp 2>/dev/null | tail -30"
run "Stuck VolumeFailedDelete events check" "kubectl get events -A --sort-by='.lastTimestamp' 2>/dev/null | grep -i 'VolumeFailedDelete' | tail -10"
run "Familiar namespace check (Kindo + AITK + supporting)" "for ns in api next litellm credits cerbos hatchet ssoready dex unleash nango pgweb presidio kindo-deps kindo-system aitk-zuva aitk-console gpu-operator longhorn cattle-monitoring-system external-secrets; do kubectl get ns \$ns 2>/dev/null > /dev/null && echo \"  PRESENT: \$ns\" || echo \"  ABSENT:  \$ns\"; done"
run "GPU operator presence" "kubectl get ns gpu-operator 2>/dev/null && kubectl -n gpu-operator get pods 2>/dev/null"
run "GPU node labels" "kubectl get nodes -o json | jq -r '.items[] | select(.metadata.labels[\"nvidia.com/gpu.present\"]==\"true\") | \"\\(.metadata.name)\\tcount=\\(.metadata.labels[\"nvidia.com/gpu.count\"] // \"?\")\\tproduct=\\(.metadata.labels[\"nvidia.com/gpu.product\"] // \"?\")\\tmig.state=\\(.metadata.labels[\"nvidia.com/mig.config.state\"] // \"none\")\"'"
run "Kafka clusters (Strimzi)" "kubectl get kafka -A 2>/dev/null"
run "RabbitMQ clusters" "kubectl get rabbitmqcluster -A 2>/dev/null"
run "Istio injection labels per namespace" "kubectl get ns -L istio-injection 2>/dev/null | grep -v '^NAME' | awk '\$NF != \"\" {print \$1, \$NF}'"

# ---------- 11: Resource utilization ----------
section "11-utilization.txt" "Resource utilization"
run "Node CPU/memory utilization" "kubectl top nodes 2>/dev/null"
run "Top memory pods" "kubectl top pods -A --sort-by=memory 2>/dev/null | head -20"
run "Top CPU pods" "kubectl top pods -A --sort-by=cpu 2>/dev/null | head -20"
run "Node conditions (memory/disk pressure)" "kubectl describe nodes 2>/dev/null | grep -A2 'Conditions' | grep -E 'Pressure|Ready' | head -30"
run "Ephemeral storage allocatable per node" "kubectl describe nodes 2>/dev/null | grep -A1 'ephemeral-storage' | head -30"

# ---------- finalize ----------
exec > /dev/tty 2>&1 || exec > /dev/stdout
echo "=================================================="
echo "  Discovery complete"
echo "  Output directory: $OUT"
ls -la "$OUT"
echo
echo "  Tarballing..."
tar czf "${OUT}.tgz" "$OUT"
echo "  Created: ${OUT}.tgz ($(du -h ${OUT}.tgz | awk '{print $1}'))"
echo "=================================================="
echo
echo "Next: copy ${OUT}.tgz off this host and share the contents."
echo "      You can also paste individual files from $OUT/ as needed."
