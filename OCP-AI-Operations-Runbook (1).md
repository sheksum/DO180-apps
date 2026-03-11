# OCP-AI Platform — Operations Runbook

**Cluster:** ocp-ai.calix.local
**OpenShift:** 4.20.13 (Kubernetes v1.33.6)


---

## 1. Cluster Overview

### 1.1 Nodes

| Hostname | IP | Role | Hardware |
|---|---|---|---|
| ocp-ai-master01.calix.local | 10.172.248.150 | Control Plane + Worker | Cisco UCS-X 210C-M7, 128 cores, 2 TiB RAM |
| ocp-ai-master02.calix.local | 10.172.248.151 | Control Plane + Worker | Cisco UCS-X 210C-M7, 128 cores, 2 TiB RAM |
| ocp-ai-master03.calix.local | 10.172.248.152 | Control Plane + Worker | Cisco UCS-X 210C-M7, 128 cores, 2 TiB RAM |
| ocp-ai-gpu01.calix.local | 10.172.248.153 | GPU Worker | Dell R760xa, 128 cores, 2 TiB RAM, 4x H100L 94GB |
| ocp-ai-gpu02.calix.local | 10.172.248.154 | GPU Worker | Dell R760xa, 128 cores, 2 TiB RAM, 4x H100L 94GB |

### 1.2 VIPs

| Purpose | Hostname | IP |
|---|---|---|
| API | api.ocp-ai.calix.local | 10.172.248.155 |
| Ingress | *.apps.ocp-ai.calix.local | 10.172.248.156 |
| Gateway API | *.dev/test/prod.ocp-ai.calix.local | 10.172.248.175 |

### 1.3 Access

```bash
# CLI login (LDAP)
oc login -u <ipa-username> https://api.ocp-ai.calix.local:6443 --insecure-skip-tls-verify


# Web Console
https://console-openshift-console.apps.ocp-ai.calix.local

# ArgoCD
https://openshift-gitops-server-openshift-gitops.apps.ocp-ai.calix.local

# SSH to masters (ocp-ai SSH key available in CyberArk)
ssh -i ~/.ssh/ocp-ai core@10.172.248.150  # master01
ssh -i ~/.ssh/ocp-ai core@10.172.248.151  # master02
ssh -i ~/.ssh/ocp-ai core@10.172.248.152  # master03

# SSH to GPU workers
ssh -i ~/.ssh/ocp-ai core@10.172.248.153  # gpu01
ssh -i ~/.ssh/ocp-ai core@10.172.248.154  # gpu02
```

### 1.4 Namespaces

| Namespace | Purpose | VLAN |
|---|---|---|
| pai-dev | Development AI/ML workloads | 1794 |
| pai-test | Test AI/ML workloads | 1798 |
| pai-prod | Production AI/ML workloads | 1797 |

---

## 2. Day-to-Day Health Checks

### 2.1 Quick Cluster Status

```bash
# Node status
oc get nodes

# Node resource usage
oc adm top nodes

# Top pods by memory
oc top pods -A --sort-by=memory | head -20

# Top pods by CPU
oc top pods -A --sort-by=cpu | head -20

# Cluster operators
oc get clusteroperators

# Any degraded operators
oc get co | grep -v "True.*False.*False"
```

### 2.2 Pod Health

```bash
# Pods not running
oc get pods -A --field-selector=status.phase!=Running,status.phase!=Succeeded

# Pods with high restart counts
oc get pods -A | awk '$5 > 5 {print $0}'

# Pods in CrashLoopBackOff
oc get pods -A | grep CrashLoop

# Events across cluster (last hour)
oc get events -A --sort-by='.lastTimestamp' | tail -30
```

### 2.3 Etcd Health

```bash
# Etcd pods
oc get pods -n openshift-etcd

# Check for slow etcd operations
oc logs -n openshift-etcd etcd-ocp-ai-master01 --tail=50 | grep -i "slow\|took too long\|overloaded"
```

### 2.4 Storage Health

```bash
# Trident pods
oc get pods -n trident

# Trident backends
oc get tridentbackend -n trident

# PVC status across namespaces
oc get pvc -A

# Any PVCs not bound
oc get pvc -A | grep -v Bound
```

### 2.5 ArgoCD Application Health

```bash
# All ArgoCD apps
oc get applications -n openshift-gitops

# Any out of sync
oc get applications -n openshift-gitops | grep -v "Synced.*Healthy"
```

### 2.6 ESO/Vault Health

```bash
# SecretStore status
oc get secretstores -A

# ExternalSecret sync status
oc get externalsecrets -A

# Any not synced
oc get externalsecrets -A | grep -v SecretSynced
```

---

## 3. ArgoCD — GitOps Management

### 3.1 What's Managed

| ArgoCD App | Path in Git | Resources |
|---|---|---|
| metallb | metallb/ | IPAddressPools, L2Advertisements |
| gateway-api | gateway-api/ | Gateway, TLS certs, HTTPRoutes |
| machineconfigs | machineconfigs/ | MachineConfigs (NTP, MTU, SSH, policy routes) |
| minio | minio/ | Deployments, Services, PVCs, ExternalSecrets (3 envs) |
| milvus | milvus/ | Deployments, Services, PVCs, ConfigMaps (3 envs) |
| trident | trident/ | StorageClasses, TridentBackendConfigs |
| nmstate | nmstate/ | NodeNetworkConfigurationPolicies |
| eso | eso/ | SecretStores, ExternalSecrets, NetworkPolicy |
| network-policies | network-policies/ | Environment isolation NetworkPolicies |
| authentication | authentication/ | OAuth LDAP config, group sync CronJob, RBAC bindings |

### 3.2 Git Repository

```
Repository: git@bitbucket.org:calixprod/ocp-ai-platform.git
Branch: main
Auth: SSH deploy key (argocd-ocp-ai)
```

### 3.3 Making Changes

All infrastructure changes go through Git. Never edit live resources directly — ArgoCD selfHeal will revert them.

```bash
cd ~/ocp-ai-config
git pull
# Make changes
git add .
git commit -m "Description of change"
git push
# ArgoCD auto-syncs within ~3 minutes
```

### 3.4 Force Sync

```bash
# From ArgoCD UI: click app → Sync
# For immutable resources (StorageClass), use Sync with Replace
```

### 3.5 Troubleshooting Sync Issues

```bash
# Check app status
oc get application <app-name> -n openshift-gitops -o yaml | tail -30

# Check sync status
oc describe application <app-name> -n openshift-gitops | grep -A20 "Status:"
```

---

## 4. Storage — Trident / NetApp

### 4.1 Architecture

| Backend | SVM | Data LIF | StorageClass |
|---|---|---|---|
| backend-infra-nfs | ocp_infra_svm | 10.172.192.22 | netapp-infra |
| backend-app-nfs | ocp_app_svm | 10.172.194.22 | netapp-app (default) |

### 4.2 Storage VLANs

| Env | Type | VLAN | Subnet | NetApp LIF IPs |
|---|---|---|---|---|
| Dev | Infra | 1792 | 10.172.192.0/23 | 10.172.192.22, .23 |
| Dev | App | 1794 | 10.172.194.0/23 | 10.172.194.22, .23 |
| Test | Infra | 1796 | 10.172.196.0/23 | 10.172.196.22, .23 |
| Test | App | 1798 | 10.172.198.0/23 | 10.172.198.22, .23 |
| Prod | Infra | 1793 | 10.172.200.0/23 | 10.172.200.22, .23 |
| Prod | App | 1797 | 10.172.202.0/23 | 10.172.202.22, .23 |

### 4.3 NFS Mount Options

StorageClass uses `nfsvers=4.1`. If NFS mounts hang, check jumbo frames first (Section 13.1).

### 4.4 Checking Trident

```bash
# Backend status
oc get tridentbackend -n trident

# Backend config
oc get tridentbackendconfig -n trident -o yaml

# Trident node pods (one per node)
oc get pods -n trident -o wide | grep trident-node

# Check for high restart counts on Trident nodes
oc get pods -n trident | awk '$4 > 5'

# Trident controller logs
oc logs -n trident deployment/trident-controller -c trident-main --tail=50
```

### 4.5 PVC Troubleshooting

```bash
# PVC stuck in Pending
oc describe pvc <pvc-name> -n <namespace>

# Check if Trident provisioned the volume
oc get pv | grep <pvc-name>

# Check NetApp for the volume
# On NetApp CLI:
volume show -vserver ocp_app_svm -volume trident_pvc_*

# PVC stuck terminating (finalizer)
oc patch pvc <pvc-name> -n <namespace> -p '{"metadata":{"finalizers":null}}' --type=merge
```

---

## 5. Networking

### 5.1 Master Node Bond Configuration

Masters use active-backup bond (bnd0 = eno7 + eno8) with 6 VLAN subinterfaces. MTU 9000 on bond and all VLANs.

```bash
# Check bond status
ssh -i ~/.ssh/ocp-ai core@10.172.248.150 "cat /proc/net/bonding/bnd0"

# Check VLAN interfaces
ssh -i ~/.ssh/ocp-ai core@10.172.248.150 "ip -br addr show | grep bnd0"

# Verify MTU on all interfaces
ssh -i ~/.ssh/ocp-ai core@10.172.248.150 "ip link show bnd0 | grep mtu; ip link show bnd0.1794 | grep mtu"
```

### 5.2 GPU Worker Bond Configuration

GPU workers use LACP bond (bond0 = ens8f0np0 + ens8f1np1, 802.3ad mode) at 100Gbps.

```bash
# Check LACP bond
ssh -i ~/.ssh/ocp-ai core@10.172.248.153 "cat /proc/net/bonding/bond0"
```

### 5.3 MetalLB IP Pools

| Pool | IP Range | VLAN | Namespace |
|---|---|---|---|
| pai-services-dev | 10.172.194.160-179 | 1794 | pai-dev |
| pai-services-test | 10.172.198.160-179 | 1798 | pai-test |
| pai-services-prod | 10.172.202.160-179 | 1797 | pai-prod |
| reserved-future | 10.172.248.175-180 | 1510 | Gateway VIP |

### 5.4 Current IP Allocations

| Service | pai-dev | pai-test | pai-prod |
|---|---|---|---|
| MinIO | 10.172.194.160 | 10.172.198.160 | 10.172.202.160 |
| Milvus | 10.172.194.161 | 10.172.198.161 | 10.172.202.161 |
| Kafka (reserved) | 10.172.194.162 | 10.172.198.162 | 10.172.202.162 |

### 5.5 Gateway API

Single gateway (pai-gateway) in openshift-ingress namespace. VIP 10.172.248.175.

| Listener | Port | Hostname | Purpose |
|---|---|---|---|
| http | 80 | all | 301 redirect to HTTPS |
| https-dev | 443 | *.dev.ocp-ai.calix.local | Dev services |
| https-test | 443 | *.test.ocp-ai.calix.local | Test services |
| https-prod | 443 | *.prod.ocp-ai.calix.local | Prod services |

```bash
# Check gateway status
oc get gateway pai-gateway -n openshift-ingress

# Check HTTPRoutes
oc get httproutes -A

# Check if routes are accepted
oc describe httproute <route-name> -n <namespace>
```

### 5.6 MTU Verification

Jumbo frames (9000) must work end-to-end from masters to NetApp. If NFS hangs, this is the first thing to check.

```bash
# Test jumbo frames from each master to NetApp LIF
ssh -i ~/.ssh/ocp-ai core@10.172.248.150 "ping -I 10.172.194.150 -M do -s 8972 10.172.194.22 -c 3"
ssh -i ~/.ssh/ocp-ai core@10.172.248.151 "ping -I 10.172.194.151 -M do -s 8972 10.172.194.22 -c 3"
ssh -i ~/.ssh/ocp-ai core@10.172.248.152 "ping -I 10.172.194.152 -M do -s 8972 10.172.194.22 -c 3"

# Test all VLANs from master03
ssh -i ~/.ssh/ocp-ai core@10.172.248.152 "ping -I 10.172.192.152 -M do -s 8972 10.172.192.22 -c 3"  # 1792
ssh -i ~/.ssh/ocp-ai core@10.172.248.152 "ping -I 10.172.194.152 -M do -s 8972 10.172.194.22 -c 3"  # 1794
ssh -i ~/.ssh/ocp-ai core@10.172.248.152 "ping -I 10.172.196.152 -M do -s 8972 10.172.196.22 -c 3"  # 1796
ssh -i ~/.ssh/ocp-ai core@10.172.248.152 "ping -I 10.172.198.152 -M do -s 8972 10.172.198.22 -c 3"  # 1798
ssh -i ~/.ssh/ocp-ai core@10.172.248.152 "ping -I 10.172.200.152 -M do -s 8972 10.172.200.22 -c 3"  # 1793
ssh -i ~/.ssh/ocp-ai core@10.172.248.152 "ping -I 10.172.202.152 -M do -s 8972 10.172.202.22 -c 3"  # 1797
```

If jumbo pings fail (100% packet loss) but standard pings work, check the Nexus SVI MTU. The SVIs for VLANs 1792-1798 must be MTU 9216 on both Nexus switches (N9K-C9336C-FX2-005 and N9K-C9336C-FX2-006):

```
# On Nexus
show interface Vlan1794 | include MTU
```

### 5.7 NetworkPolicies

Environment isolation is enforced. Pods can only receive traffic from their own namespace, the ingress namespace (Gateway API/router), and the monitoring namespace (Prometheus).

```bash
# List policies
oc get networkpolicy -n pai-dev
oc get networkpolicy -n pai-test
oc get networkpolicy -n pai-prod

# Test isolation (should FAIL)
oc run test --rm -it --image=busybox --restart=Never -n pai-dev -- wget -qO- --timeout=3 http://milvus.pai-test.svc:9091/healthz

# Test same-namespace (should WORK)
oc run test --rm -it --image=busybox --restart=Never -n pai-dev -- wget -qO- --timeout=3 http://milvus.pai-dev.svc:9091/healthz
```

---

## 6. Vault / ESO — Secrets Management

### 6.1 Architecture

Vault runs on `plnx-vault.calix.local` (10.172.249.106), accessible at `vault.calix.local:8200` (CNAME). KV v2 secrets engine mounted at `kv/`. ESO pulls secrets from Vault into Kubernetes secrets. Audit log: `/var/log/vault/audit.log` on plnx-vault.

### 6.2 Vault Auth

Two auth methods:

**Kubernetes auth** (`kubernetes-ocp-ai` path) — used by ESO service accounts to pull secrets automatically.

**LDAP auth** — used by humans via Vault UI. Integrated with Red Hat IdM (`cpeg-ipareplica.ipa.calix.local`, domain `ipa.calix.local`).

| IPA Group | Vault Policy | Access |
|---|---|---|
| engops | engops-admin | Full access to all secrets, PKI |
| mlops | mlops-app | Read/write to kv/pai-dev/*, kv/pai-test/*, kv/pai-prod/* |

### 6.3 Vault PKI

| Component | Value |
|---|---|
| Root PKI Engine | pki_root (self-signed, temporary) |
| Intermediate PKI Engine | pki_int |
| PKI Role | ocp-ai (*.calix.local, wildcards, 1yr max TTL) |
| Vault Auth Path | kubernetes-ocp-ai |
| ClusterIssuer | vault-issuer — Ready |

Two trust chains: (1) Vault server TLS (corporate CA chain) — ESO and cert-manager trust via caBundle. (2) Vault PKI engine (self-signed) — signs cluster certificates. Will be swapped to corporate CA.

### 6.4 SecretStores

```bash
# Check all SecretStores
oc get secretstores -A

# Detailed status
oc describe secretstore vault-store -n pai-dev
```

Each SecretStore uses a different Vault role:

| Namespace | Vault Role |
|---|---|
| pai-dev | eso-pai-dev |
| pai-test | eso-pai-test |
| pai-prod | eso-pai-prod |
| trident | eso-trident |
| ldap-group-sync | eso-ldap-group-sync |

**Vault Kubernetes Auth Config (`auth/kubernetes-ocp-ai`):**

| Config Key | Value |
|---|---|
| kubernetes_host | https://api.ocp-ai.calix.local:6443 |
| kubernetes_ca_cert | Combined: K8s internal CAs + Calix CA chain |
| token_reviewer_jwt | SA external-secrets:external-secrets (8760h TTL) |
| disable_iss_validation | true |

**Required RBAC:** `ClusterRoleBinding vault-tokenreview-binding` binds `system:auth-delegator` to `external-secrets:external-secrets`.

### 6.5 ExternalSecrets

```bash
# Check sync status
oc get externalsecrets -A

# Force refresh
oc annotate externalsecret <name> -n <namespace> force-sync=$(date +%s) --overwrite

# Check the actual secret was created
oc get secret <secret-name> -n <namespace>
```

### 6.6 Vault Login (Human)

```bash
# CLI
export VAULT_ADDR=https://vault.calix.local:8200
vault login -method=ldap username=<IPA-USERNAME>

# UI
# Browse to https://vault.calix.local:8200
# Select LDAP method, enter IPA credentials
```

### 6.7 Vault User Lockout

After 5 failed login attempts, account is locked for 15 minutes. To unlock:

```bash
vault write -force /sys/locked-users/<mount_accessor>/unlock/<username>
```

---

## 7. Authentication & RBAC

### 7.1 Identity Provider

All authentication is through LDAP (Red Hat IdM).

| Property | Value |
|---|---|
| Provider | ldap-ipa |
| IPA Server | cpeg-ipareplica.ipa.calix.local |
| Login URL | https://console-openshift-console.apps.ocp-ai.calix.local |

### 7.2 LDAP Group Sync

CronJob in `ldap-group-sync` namespace syncs IPA groups every 30 minutes. ArgoCD managed.

```bash
# Check groups
oc get groups

# Check last sync job
oc get jobs -n ldap-group-sync --sort-by='.metadata.creationTimestamp' | tail -3

# Check sync logs
oc logs -n ldap-group-sync -l job-name=<latest-job>

# Force a manual sync
oc create job --from=cronjob/ldap-group-sync manual-sync -n ldap-group-sync
```

### 7.3 RBAC — Tiered Access

| Group | Cluster Role | pai-dev | pai-test | pai-prod |
|---|---|---|---|---|
| engops | cluster-admin | full | full | full |
| mlops | — | admin | edit | view |

- **pai-dev:** MLOps can do anything — manual applies, exec, create resources
- **pai-test:** MLOps can view, exec, port-forward. Cannot create/modify deployments or secrets directly.
- **pai-prod:** MLOps is read-only. All deployments through ArgoCD only. No exec.

```bash
# Check rolebindings
oc get rolebindings -n pai-dev | grep -v system
oc get rolebindings -n pai-test | grep -v system
oc get rolebindings -n pai-prod | grep -v system

# Test what a group can do
oc auth can-i create deployments -n pai-prod --as="" --as-group=mlops
oc auth can-i get pods -n pai-prod --as="" --as-group=mlops
```

### 7.4 Adding/Removing Users

Add users to IPA groups — the CronJob syncs them to OpenShift automatically within 30 minutes.

```bash
# Add a user to mlops
ipa group-add-member mlops --users=<ipa-username>

# Remove a user from mlops
ipa group-remove-member mlops --users=<ipa-username>

# Force immediate sync
oc create job --from=cronjob/ldap-group-sync manual-sync -n ldap-group-sync
```

---

## 8. Installed Operators

| Operator | Namespace | Purpose |
|---|---|---|
| Kubernetes NMState | openshift-nmstate | Network bond and VLAN configuration |
| NetApp Trident Certified | trident | CSI storage driver for NetApp |
| Node Feature Discovery | openshift-nfd | Hardware feature detection for GPU |
| NVIDIA GPU Operator | nvidia-gpu-operator | GPU driver and device plugin |
| cert-manager | cert-manager | TLS certificate lifecycle |
| Red Hat OpenShift GitOps | openshift-gitops | ArgoCD |
| External Secrets Operator | external-secrets | Vault → Kubernetes secret sync |
| MetalLB | metallb-system | L2 load balancer |
| Service Mesh (Istio/Envoy) | istio-system | Gateway API controller |
| CloudNativePG | openshift-operators | PostgreSQL operator |

### 8.1 Checking Operator Health

```bash
# All CSVs (ClusterServiceVersions)
oc get csv -A | grep -v Succeeded

# Operator pods
oc get pods -n openshift-operators
oc get pods -n nvidia-gpu-operator
oc get pods -n cert-manager
oc get pods -n external-secrets
oc get pods -n metallb-system
```

---

## 9. Infrastructure Services

### 8.1 MinIO (S3-Compatible Object Storage)

ArgoCD managed. Deployed in all three environments.

| | pai-dev | pai-test | pai-prod |
|---|---|---|---|
| S3 API (internal) | minio.pai-dev.svc:9000 | minio.pai-test.svc:9000 | minio.pai-prod.svc:9000 |
| S3 API (external) | 10.172.194.160:9000 | 10.172.198.160:9000 | 10.172.202.160:9000 |
| Console | https://minio.dev.ocp-ai.calix.local | https://minio.test.ocp-ai.calix.local | https://minio.prod.ocp-ai.calix.local |
| Storage | 100Gi | 100Gi | 200Gi |
| Credentials | minio-credentials secret (Vault/ESO) | same | same |

```bash
# Check pods
oc get pods -n pai-dev -l app=minio
oc get pods -n pai-test -l app=minio
oc get pods -n pai-prod -l app=minio

# Check services
oc get svc -n pai-dev | grep minio

# Health check from inside cluster
oc run minio-test --rm -it --image=busybox --restart=Never -n pai-dev -- wget -qO- http://minio.pai-dev.svc:9000/minio/health/live

# Get credentials
oc get secret minio-credentials -n pai-dev -o jsonpath='{.data.MINIO_ROOT_USER}' | base64 -d
oc get secret minio-credentials -n pai-dev -o jsonpath='{.data.MINIO_ROOT_PASSWORD}' | base64 -d
```

### 8.2 Milvus (Vector Database)

ArgoCD managed. Standalone mode with embedded etcd. Vector data stored in MinIO.

| | pai-dev | pai-test | pai-prod |
|---|---|---|---|
| gRPC (internal) | milvus.pai-dev.svc:19530 | milvus.pai-test.svc:19530 | milvus.pai-prod.svc:19530 |
| gRPC (external) | 10.172.194.161:19530 | 10.172.198.161:19530 | 10.172.202.161:19530 |
| CPU / Memory | 4 / 8Gi | 4 / 8Gi | 8 / 16Gi |
| rootPath | milvus/dev | milvus/test | milvus/prod |

```bash
# Check pods
oc get pods -n pai-dev -l app=milvus
oc get pods -n pai-test -l app=milvus
oc get pods -n pai-prod -l app=milvus

# Health check
oc run milvus-test --rm -it --image=busybox --restart=Never -n pai-dev -- wget -qO- http://milvus.pai-dev.svc:9091/healthz

# Check logs
oc logs -n pai-dev -l app=milvus --tail=50
```

**Environment variables (all environments):**

```
DEPLOY_MODE=STANDALONE
ETCD_USE_EMBED=true
ETCD_CONFIG_PATH=/milvus/configs/embedEtcd.yaml
ETCD_DATA_DIR=/var/lib/milvus/etcd
COMMON_STORAGETYPE=remote
MINIO_ADDRESS=minio.<namespace>.svc.cluster.local
MINIO_PORT=9000
MINIO_USE_SSL=false
MINIO_BUCKET_NAME=milvus-bucket
MINIO_ROOT_PATH=milvus/<env>
MINIO_ACCESS_KEY_ID — from minio-credentials secret
MINIO_SECRET_ACCESS_KEY — from minio-credentials secret
```

**Probes:**
- startupProbe: `/healthz` on HTTP port, 10s initial, 10s period, 30 failures (5 min tolerance)
- livenessProbe: `/healthz`, 10s initial, 30s period
- readinessProbe: `/healthz`, 10s initial, 15s period

**Clean start (delete all state in an environment):**

```bash
oc delete deploy milvus -n <namespace>
oc delete pvc milvus-data -n <namespace>
oc exec -n <namespace> deploy/minio -- mc alias set local http://localhost:9000 <user> <password>
oc exec -n <namespace> deploy/minio -- mc rm --recursive --force local/milvus-bucket/milvus/<env>/
```

Architecture notes:
- Standalone mode with embedded etcd (external etcd requires block storage, NFS doesn't support flock)
- emptyDir overlay at /var/lib/milvus/etcd provides local disk for etcd metadata
- Vector data persists in MinIO and survives pod rescheduling
- Do not modify `milvus-bucket` in MinIO
- Zilliztech Helm chart is NOT used — it bundles Bitnami etcd subchart that hardcodes `runAsUser: 1001` which OpenShift `restricted-v2` SCC rejects. Milvus is deployed via plain manifests instead. — reserved for Milvus

### 8.3 CNPG (PostgreSQL Operator)

Installed via OperatorHub (v1.28.1). Operator is cluster-wide in openshift-operators. Application teams create Cluster CRs in their namespaces.

```bash
# Check operator
oc get pods -n openshift-operators | grep cnpg

# Check CRDs
oc get crd | grep cnpg

# List all PostgreSQL clusters
oc get clusters.postgresql.cnpg.io -A

# Check a specific cluster
oc get cluster <name> -n <namespace>
oc describe cluster <name> -n <namespace>

# Check instances
oc get pods -n <namespace> -l cnpg.io/cluster=<name> -L role

# Get auto-generated credentials
oc get secret <cluster-name>-app -n <namespace> -o jsonpath='{.data.username}' | base64 -d
oc get secret <cluster-name>-app -n <namespace> -o jsonpath='{.data.password}' | base64 -d

# Connect to database
PGPASS=$(oc get secret <cluster-name>-app -n <namespace> -o jsonpath='{.data.password}' | base64 -d)
oc run pg-test --rm -it --image=postgres:17 --restart=Never -n <namespace> -- \
  psql "host=<cluster-name>-rw port=5432 dbname=<db> user=<user> password=$PGPASS sslmode=require"
```

CNPG services:
- `<cluster-name>-rw` — read-write (primary)
- `<cluster-name>-ro` — read-only (replicas)
- `<cluster-name>-r` — any instance

Credentials are managed by CNPG autonomously via `<cluster-name>-app` secret. Vault/ESO is not involved in database credential management.

---

## 10. MachineConfigs

| Name | Role | Purpose |
|---|---|---|
| 99-worker-mtu-9000 | worker | MTU 9000 on eno8303 + br-ex via systemd at boot |
| 99-master-chrony | master | NTP — time1/time2.calix.local |
| 99-worker-chrony | worker | NTP — time1/time2.calix.local |
| 99-worker-ssh | worker | SSH access |
| 99-worker-nm-dns-fix | worker | Fix NM DNS for OVN-K bare-metal reboot bug |
| 99-worker-app-vlan-policy-routes | worker | Policy routing for app VLANs 1794/1797/1798 |
| 99-master-app-vlan-policy-routes | master | Policy routing for app VLANs 1794/1797/1798 |
| 99-master-eno6-down | master | Disable eno6 standby NIC to prevent ARP conflicts with MetalLB VIPs |

```bash
# List MachineConfigs
oc get machineconfig | grep 99-

# Check MachineConfigPool status
oc get mcp

# Check if any node is updating
oc get mcp -o jsonpath='{range .items[*]}{.metadata.name}{": updated="}{.status.conditions[?(@.type=="Updated")].status}{", updating="}{.status.conditions[?(@.type=="Updating")].status}{"\n"}{end}'
```

**Authoring rules:** New MachineConfigs should use Ignition 3.5.0, `contents.source` (base64 data URI, NOT inline), `mode: 493` (0755). Earlier MCs use 3.2.0 with `contents.inline` — they work fine, don't need migration. Reference template: `oc get mc 99-worker-nm-dns-fix -o yaml`. Wrong Ignition version causes `RenderDegraded` which blocks ALL MC updates until the broken MC is deleted.

**WARNING:** MachineConfig changes trigger node reboots via the Machine Config Operator. Changes are rolled out one node at a time. Do not apply during business hours without a maintenance window.

---

## 11. NMState — Bond and VLAN Configuration

Managed via ArgoCD. One NNCP per node.

| NNCP | Node | Bond | Mode |
|---|---|---|---|
| storage-vlans-master01 | master01 | bnd0 (eno7+eno8) | active-backup |
| storage-vlans-master02 | master02 | bnd0 (eno7+eno8) | active-backup |
| storage-vlans-master03 | master03 | bnd0 (eno7+eno8) | active-backup |
| nncp-gpu01-bond | gpu01 | bond0 (ens8f0np0+ens8f1np1) | 802.3ad (LACP) |
| nncp-gpu02-bond | gpu02 | bond0 (ens8f0np0+ens8f1np1) | 802.3ad (LACP) |

```bash
# Check NNCP status
oc get nncp

# Check NNCE (per-node status)
oc get nnce

# Verify interface state on a node
ssh -i ~/.ssh/ocp-ai core@10.172.248.150 "ip -br addr show | grep bnd0"
```

**Important:** MTU 9000 must be explicitly set on both the bond AND each VLAN subinterface. The GPU NNCPs have this correct. The master NNCPs have been fixed.

---

## 12. TLS / Certificates

### 11.1 cert-manager + Vault PKI

```bash
# ClusterIssuer status
oc get clusterissuer vault-issuer

# List certificates
oc get certificates -A

# Check a certificate
oc describe certificate <name> -n <namespace>

# Check certificate expiry
oc get secret <cert-secret> -n <namespace> -o jsonpath='{.data.tls\.crt}' | base64 -d | openssl x509 -noout -dates
```

### 11.2 Gateway TLS Certificates

Wildcard certificates for each environment, auto-renewed 30 days before expiry:
- `*.dev.ocp-ai.calix.local`
- `*.test.ocp-ai.calix.local`
- `*.prod.ocp-ai.calix.local`

---

## 13. Troubleshooting Playbooks

### 12.1 NFS Mounts Hanging

**Symptoms:** Pods stuck in Init:0/1, `FailedMount` errors with `DeadlineExceeded`, dmesg shows "nfs: server 10.172.194.22 not responding".

**Step 1 — Check jumbo frames:**

```bash
ssh -i ~/.ssh/ocp-ai core@10.172.248.152 "ping -I 10.172.194.152 -M do -s 8972 10.172.194.22 -c 3"
```

If 100% packet loss → jumbo frames broken. Check Nexus SVI MTU (Section 5.6).

**Step 2 — Check NFS version and mount options:**

```bash
# Check StorageClass
oc get storageclass netapp-app -o yaml | grep -A3 mountOptions

# Test manual NFSv4.1 mount
ssh -i ~/.ssh/ocp-ai core@10.172.248.152 "sudo mount -v -t nfs4 -o nfsvers=4.1,tcp 10.172.194.22:/<volume> /mnt && echo SUCCESS && sudo umount /mnt"
```

**Step 3 — Check Trident node logs:**

```bash
oc get pods -n trident -o wide | grep trident-node
oc logs -n trident <trident-node-pod> -c trident-main --tail=100 | grep -i "error\|fail\|timeout\|lock"
```

**Step 4 — Check dmesg for NFS errors:**

```bash
ssh -i ~/.ssh/ocp-ai core@10.172.248.150 "dmesg | grep -c 'not responding'"
```

**Step 5 — Temporary workaround (MTU 1500):**

```bash
ssh -i ~/.ssh/ocp-ai core@10.172.248.150 "sudo ip link set bnd0 mtu 1500"
```

This reverts on reboot. Fix the root cause (Nexus SVI MTU) instead.

### 12.2 Milvus Crash-Looping

**Symptoms:** Milvus pod in CrashLoopBackOff, "fail to balance: no available streaming node" in logs.

**Check 1 — Is NFS working?** (Section 13.1)

**Check 2 — MinIO accessible?**

```bash
oc run minio-test --rm -it --image=busybox --restart=Never -n <namespace> -- wget -qO- --timeout=3 http://minio.<namespace>.svc:9000/minio/health/live
```

**Check 3 — Clean wipe and redeploy:**

```bash
# Delete the Milvus pod (ArgoCD recreates)
oc delete pod -n <namespace> -l app=milvus

# If that doesn't work, delete PVC and let ArgoCD recreate
# WARNING: This deletes all vector data in that environment
oc delete pvc milvus-data -n <namespace>
```

### 12.3 Pod Stuck on Specific Node

**Symptoms:** All pods in a namespace land on one node.

**Check 1 — Is there a nodeName or nodeSelector?**

```bash
oc get deployment <name> -n <namespace> -o yaml | grep -A5 "nodeName\|nodeSelector\|affinity"
```

**Check 2 — Is the PVC RWO and bound to a specific node?**

```bash
oc get pvc -n <namespace>
oc get pv <pv-name> -o yaml | grep nodeAffinity -A10
```

RWO PVCs on NFS don't have node affinity, but if the NFS client state is broken on other nodes, pods will only mount successfully on one node. Check NFS health (Section 13.1).

### 12.4 ESO Not Syncing Secrets

**Symptoms:** ExternalSecret shows status other than SecretSynced.

| Error | Fix |
|---|---|
| `x509: unknown authority` | Rebuild caBundle (see below) |
| `permission denied` (403) | Refresh reviewer JWT + check auth-delegator + check kubernetes_ca_cert has Calix CA |
| `ServiceAccount not found` | `oc create sa external-secrets -n <ns>` |
| `context deadline exceeded` | Test: `oc exec -n external-secrets deploy/external-secrets -- curl -sk https://vault.calix.local:8200/v1/sys/health` |

```bash
# Check ExternalSecret status
oc describe externalsecret <n> -n <namespace>

# Check SecretStore
oc describe secretstore vault-store -n <namespace>
```

**Rebuild caBundle:**

```bash
openssl s_client -connect vault.calix.local:8200 -showcerts 2>/dev/null \
  | awk '/BEGIN CERTIFICATE/,/END CERTIFICATE/' > /tmp/vault-ca.pem
CABUNDLE=$(base64 -w 0 /tmp/vault-ca.pem)
oc patch secretstore vault-store -n <ns> --type merge \
  -p "{\"spec\":{\"provider\":{\"vault\":{\"caBundle\":\"$CABUNDLE\"}}}}"
```

**Refresh reviewer JWT:**

```bash
# On plnx-admin:
oc create token external-secrets -n external-secrets --duration=8760h
# On plnx-vault (VAULT_SKIP_VERIFY=true):
vault write auth/kubernetes-ocp-ai/config \
  kubernetes_host="https://api.ocp-ai.calix.local:6443" \
  token_reviewer_jwt="<token>" \
  kubernetes_ca_cert=@/tmp/combined-ca.pem
```

**Always restart ESO after changes:** `oc rollout restart deployment -n external-secrets external-secrets`

### 12.5 Gateway API Route Not Working

```bash
# Check route status
oc get httproute <name> -n <namespace> -o yaml | grep -A10 "status:"

# Check if the gateway is accepting routes from this namespace
oc describe gateway pai-gateway -n openshift-ingress

# Check if DNS resolves
nslookup <hostname>.dev.ocp-ai.calix.local

# Check if the backend service exists
oc get svc <backend-name> -n <namespace>
```

### 12.6 CNPG Cluster Issues

```bash
# Cluster status
oc get cluster <name> -n <namespace>
oc describe cluster <name> -n <namespace>

# Check if instances are healthy
oc get pods -n <namespace> -l cnpg.io/cluster=<name> -L role

# Check CNPG operator logs
oc logs -n openshift-operators -l app.kubernetes.io/name=cloudnative-pg --tail=50

# Check instance logs
oc logs <pod-name> -n <namespace> -c postgres --tail=50

# Test failover
oc delete pod <primary-pod> -n <namespace>
# CNPG auto-promotes a replica
```

---

## 14. Emergency Procedures

### 13.1 Node Drain and Reboot

```bash
# Drain (moves workloads off)
oc adm drain <node-name> --ignore-daemonsets --delete-emptydir-data --force

# Reboot
ssh -i ~/.ssh/ocp-ai core@<node-ip> "sudo systemctl reboot"

# Watch it come back
oc get nodes -w

# Uncordon
oc adm uncordon <node-name>
```

For masters with NFS issues, you can skip the drain and reboot directly — pods will restart when the node comes back.

### 13.2 Cordon a Node (Prevent Scheduling)

```bash
# Prevent new pods from scheduling
oc adm cordon <node-name>

# Allow scheduling again
oc adm uncordon <node-name>
```

### 13.3 Vault Seal/Unseal

If Vault gets sealed (restart, crash), all ESO syncs will fail.

```bash
# Check seal status
vault status

# Unseal (requires unseal key)
vault operator unseal <key>
```

### 13.4 Force Delete Stuck Pod

```bash
oc delete pod <pod-name> -n <namespace> --force --grace-period=0
```

### 13.5 Force Delete Stuck PVC

```bash
oc patch pvc <pvc-name> -n <namespace> -p '{"metadata":{"finalizers":null}}' --type=merge
oc delete pvc <pvc-name> -n <namespace>
```

---

## 15. NTP

Masters and workers use internal NTP servers:
- time1.calix.local (10.168.21.1)
- time2.calix.local (10.168.21.2)

Configured via MachineConfigs `99-master-chrony` and `99-worker-chrony`.

```bash
# Check time sync on a node
ssh -i ~/.ssh/ocp-ai core@10.172.248.150 "chronyc sources"
ssh -i ~/.ssh/ocp-ai core@10.172.248.150 "chronyc tracking"
```

---

## 16. GPU Compute

8x NVIDIA H100L 94GB across 2 workers (4 per node). GPU Operator v25.10.1.

```bash
# Check GPU nodes
oc get nodes -l nvidia.com/gpu.present=true

# Check GPU operator pods
oc get pods -n nvidia-gpu-operator

# Check GPU availability
oc describe node ocp-ai-gpu01.calix.local | grep -A5 "nvidia.com/gpu"

# GPU workers are tainted
# nvidia.com/gpu=:NoSchedule
# Only pods requesting GPUs or tolerating the taint will schedule there
```

## Appendix A: NMState VLAN IP Map

### Master Node Storage IPs

| VLAN | Master01 | Master02 | Master03 |
|---|---|---|---|
| 1792 | 10.172.192.150 | 10.172.192.151 | 10.172.192.152 |
| 1794 | 10.172.194.150 | 10.172.194.151 | 10.172.194.152 |
| 1796 | 10.172.196.150 | 10.172.196.151 | 10.172.196.152 |
| 1798 | 10.172.198.150 | 10.172.198.151 | 10.172.198.152 |
| 1793 | 10.172.200.150 | 10.172.200.151 | 10.172.200.152 |
| 1797 | 10.172.202.150 | 10.172.202.151 | 10.172.202.152 |

### GPU Worker Storage IPs

| VLAN | GPU01 | GPU02 |
|---|---|---|
| 1792 | 10.172.192.153 | 10.172.192.154 |
| 1794 | 10.172.194.153 | 10.172.194.154 |
| 1796 | 10.172.196.153 | 10.172.196.154 |
| 1798 | 10.172.198.153 | 10.172.198.154 |
| 1793 | 10.172.200.153 | 10.172.200.154 |
| 1797 | 10.172.202.153 | 10.172.202.154 |

## Appendix B: MAC Addresses

### Control Plane

| Blade | MGT (eno5) | DATA (eno7) |
|---|---|---|
| 4-1 (master01) | 00:25:B5:50:0A:64 | 00:25:B5:50:0A:65 |
| 4-2 (master02) | 00:25:B5:50:0A:66 | 00:25:B5:50:0A:67 |
| 4-3 (master03) | 00:25:B5:50:0A:68 | 00:25:B5:50:0A:69 |

### GPU Workers

| | GPU01 | GPU02 |
|---|---|---|
| Mgmt NIC (eno8303) | C8:4B:D6:F3:D8:40 | C8:4B:D6:F3:D8:22 |
| Mellanox Port 1 | 7C:8C:09:C3:74:1E | 7C:8C:09:C3:79:86 |
| Mellanox Port 2 | 7C:8C:09:C3:74:1F | 7C:8C:09:C3:79:87 |

## Appendix C: NetApp Export Policies

| SVM | Policy | Allowed Clients |
|---|---|---|
| ocp_infra_svm | backend_infra_access | 10.172.192.0/24, .196.0/24, .200.0/24, .248.0/24 |
| ocp_app_svm | backend_app_access | 10.172.194.0/24, .198.0/24, .202.0/24, .248.0/24 |

Note: Trident PVC volumes use the `default` export policy (0.0.0.0/0, all access).

## Appendix D: Git Repository Structure

```
ocp-ai-platform/
├── apps/                    # ArgoCD Application manifests
│   ├── authentication.yaml
│   ├── eso.yaml
│   ├── gateway-api.yaml
│   ├── machineconfigs.yaml
│   ├── metallb.yaml
│   ├── milvus.yaml
│   ├── minio.yaml
│   ├── network-policies.yaml
│   ├── nmstate.yaml
│   └── trident.yaml
├── authentication/          # OAuth LDAP, group sync CronJob, RBAC bindings
├── eso/                     # SecretStores, ExternalSecrets, Vault NetworkPolicy
├── gateway-api/             # Gateway, TLS certs, HTTPRoutes
├── machineconfigs/          # NTP, MTU, SSH, policy routes, eno6-down
├── metallb/                 # IPAddressPools, L2Advertisements
├── milvus/                  # Milvus deployments (pai-dev, pai-test, pai-prod)
├── minio/                   # MinIO deployments + ExternalSecrets
├── network-policies/        # Environment isolation
├── nmstate/                 # NNCPs for all 5 nodes
└── trident/                 # StorageClasses, TridentBackendConfigs
```
