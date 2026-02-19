# OCP-AI Cluster — Technical Documentation

**Last updated:** Feb 18, 2026 | **Author:** Haj Suma

OCP 4.20.13 bare metal cluster for AI/ML workloads. 5 nodes — 3 Cisco UCS-X control plane + 2 Dell R760xa GPU workers with 8x NVIDIA H100 GPUs.

---

## Cluster Overview

| Parameter | Value |
|-----------|-------|
| Cluster Name | ocp-ai |
| Base Domain | calix.local |
| OpenShift | 4.20.13 / Kubernetes v1.33.6 |
| Network Plugin | OVNKubernetes |
| Install Method | Red Hat Assisted Installer |
| Cluster ID | a755e1fd-ea30-48c8-ae58-28e16e760bae |
| License | 60-day trial — expires ~April 12, 2026 |

| Resource | Total |
|----------|-------|
| CPU | 640 cores |
| Memory | ~9.9 TiB |
| GPU | 8x NVIDIA H100L 94GB |
| Nodes | 5 |

---

## Management Network — VLAN 1510

| Parameter | Value |
|-----------|-------|
| Subnet | 10.172.248.0/24 |
| Gateway | 10.172.248.1 |
| DNS | 10.172.248.31, .32 |
| MTU | 9000 |

### Node IPs

| Hostname | IP | Role | Hardware |
|----------|-----|------|----------|
| ocp-ai-master01.calix.local | 10.172.248.150 | Control Plane | UCS-X 210C-M7 |
| ocp-ai-master02.calix.local | 10.172.248.151 | Control Plane | UCS-X 210C-M7 |
| ocp-ai-master03.calix.local | 10.172.248.152 | Control Plane | UCS-X 210C-M7 |
| ocp-ai-gpu01.calix.local | 10.172.248.153 | GPU Worker | Dell R760xa |
| ocp-ai-gpu02.calix.local | 10.172.248.154 | GPU Worker | Dell R760xa |
| api.ocp-ai.calix.local | 10.172.248.155 | API VIP | — |
| *.apps.ocp-ai.calix.local | 10.172.248.156 | Ingress VIP | — |

---

## Storage Network VLANs

Configured on master nodes only via NMState bond (bnd0) + VLAN subinterfaces. GPU workers do not have storage VLANs.

| Env | Type | VLAN | Subnet | LIF IPs |
|-----|------|------|--------|---------|
| Dev | Infra | 1792 | 10.172.192.0/23 | .22, .23 |
| Dev | App | 1794 | 10.172.194.0/23 | .22, .23 |
| Test | Infra | 1796 | 10.172.196.0/23 | .22, .23 |
| Test | App | 1798 | 10.172.198.0/23 | .22, .23 |
| Prod | Infra | 1793 | 10.172.200.0/23 | .22, .23 |
| Prod | App | 1797 | 10.172.202.0/23 | .22, .23 |

### SVM Management — VLAN 1570

| SVM | LIF | IP |
|-----|-----|-----|
| ocp_infra_svm | ocp_infra_mgmt | 10.172.254.46/24 |
| ocp_app_svm | ocp_app_mgmt | 10.172.254.47/24 |

### Master Node Storage IPs

Third octet matches VLAN subnet (e.g., VLAN 1792 = 10.172.192.x)

| VLAN | master01 | master02 | master03 |
|------|----------|----------|----------|
| 1792 | .150 | .151 | .152 |
| 1794 | .150 | .151 | .152 |
| 1796 | .150 | .151 | .152 |
| 1798 | .150 | .151 | .152 |
| 1793 | .150 | .151 | .152 |
| 1797 | .150 | .151 | .152 |

---

## Hardware — UCS-X Blades (Control Plane)

3x Cisco UCS-X 210C-M7 in chassis PLN-UCSX-F1-01, Slot 4. Each: 128 cores, 2 TiB RAM, 480 GB disk.

### Intersight Policies

| Component | Policy |
|-----------|--------|
| Server Profile Template | pln_srv_EO_UCS_M7 |
| LAN Connectivity | pln_svr_OCP_LAN_EO |
| IMC Access | pln_imc_EO (OOB only) |
| Eth Network Group (MGT) | pln_eth_MGT_OCP_ng_EO |
| Eth Network Group (DATA) | pln_eth_DATA_OCP_ng_EO |

### vNIC Layout

| vNIC | Interface | Use | Fabric |
|------|-----------|-----|--------|
| OCP-MGT-A | eno5 | Mgmt | A |
| OCP-MGT-B | eno6 | Mgmt standby | B |
| OCP-DATA-A | eno7 | Storage | A |
| OCP-DATA-B | eno8 | Storage standby | B |

### MAC Addresses

| Blade | MGT (eno5) | DATA (eno7) |
|-------|------------|-------------|
| 4-1 (master01) | 00:25:B5:50:0A:64 | 00:25:B5:50:0A:65 |
| 4-2 (master02) | 00:25:B5:50:0A:66 | 00:25:B5:50:0A:67 |
| 4-3 (master03) | 00:25:B5:50:0A:68 | 00:25:B5:50:0A:69 |

---

## Hardware — Dell GPU Servers (Workers)

2x Dell PowerEdge R760xa. Each: 2x Xeon Platinum 8562Y+ (128 cores HT), 2 TiB RAM, 4x NVIDIA H100L 94GB, 480 GB NVMe boot, 26.88 TB RAID.

| | GPU01 | GPU02 |
|-|-------|-------|
| Serial | 6RJWMD4 | 7RJWMD4 |
| iDRAC | 10.152.0.43 | 10.152.0.44 |
| iDRAC creds | root / calvin | root / calvin |
| Mgmt NIC MAC (eno8303) | C8:4B:D6:F3:D8:40 | C8:4B:D6:F3:D8:22 |
| Mellanox 100G MAC (ens8f1np1) | 7C:8C:09:C3:74:1F | 7C:8C:09:C3:79:87 |

Currently on 1Gbps Broadcom. Plan to migrate to Mellanox 100GbE — waiting on Chetan for switch config.

### GPU PCIe Mapping (same both servers)

| GPU | Model | PCIe Address |
|-----|-------|-------------|
| 0 | H100L 94GB | 0000:4a:00.0 |
| 1 | H100L 94GB | 0000:61:00.0 |
| 2 | H100L 94GB | 0000:ca:00.0 |
| 3 | H100L 94GB | 0000:e1:00.0 |

---

## Node Networking

### Masters

Mgmt: OVN br-ex on eno5 (VLAN 1510, MTU 9000). Storage: bnd0 (active-backup, eno7 + eno8, MTU 9000) with 6 VLAN subinterfaces.

NMState NNCPs per node — all SuccessfullyConfigured.

> Linux interface names max 15 chars. Used "bnd0" because "bond-storage.1792" = 18 chars and NMState fails silently.

### GPU Workers

Mgmt: OVN br-ex on eno8303 (Broadcom 1GbE, VLAN 1510, MTU 9000). No storage VLANs.

MTU persisted via MachineConfig `99-worker-mtu-9000` — systemd unit at boot:
```
ip link set eno8303 mtu 9000 && ovs-vsctl set int br-ex mtu_request=9000
```

> Hit MTU mismatch on initial join — cluster overlay expects 8958, workers came up at 1500. ovnkube-node fails with NetworkPluginNotReady. Fix: jumbo frames on switch + MachineConfig.

---

## NetApp Storage

### Cluster

| Parameter | Value |
|-----------|-------|
| Cluster | plano_aff_cl |
| Mgmt IP | 10.152.0.110 |
| Nodes | 6 (plano_aff_cl-01 through 06) |
| Type | AFF |

### SVMs

| SVM | Purpose | Mgmt LIF | Aggregates |
|-----|---------|----------|------------|
| ocp_infra_svm | Infrastructure | 10.172.254.46 | aggr1_n1 through n6 |
| ocp_app_svm | Application | 10.172.254.47 | aggr1_n1 through n6 |

### LIFs — ocp_infra_svm

| LIF | IP | VLAN | Node |
|-----|-----|------|------|
| ocp_infra_mgmt | 10.172.254.46 | a0a-1570 | cl-05 |
| ocp_infra_dev_lif01 | 10.172.192.22 | a0a-1792 | cl-05 |
| ocp_infra_dev_lif02 | 10.172.192.23 | a0a-1792 | cl-06 |
| ocp_infra_test_lif01 | 10.172.196.22 | a0a-1796 | cl-05 |
| ocp_infra_test_lif02 | 10.172.196.23 | a0a-1796 | cl-06 |
| ocp_infra_prod_lif01 | 10.172.200.22 | a0a-1793 | cl-05 |
| ocp_infra_prod_lif02 | 10.172.200.23 | a0a-1793 | cl-06 |

### LIFs — ocp_app_svm

| LIF | IP | VLAN | Node |
|-----|-----|------|------|
| ocp_app_mgmt | 10.172.254.47 | a0a-1570 | cl-06 |
| ocp_app_dev_lif01 | 10.172.194.22 | a0a-1794 | cl-05 |
| ocp_app_dev_lif02 | 10.172.194.23 | a0a-1794 | cl-06 |
| ocp_app_test_lif01 | 10.172.198.22 | a0a-1798 | cl-05 |
| ocp_app_test_lif02 | 10.172.198.23 | a0a-1798 | cl-06 |
| ocp_app_prod_lif01 | 10.172.202.22 | a0a-1797 | cl-05 |
| ocp_app_prod_lif02 | 10.172.202.23 | a0a-1797 | cl-06 |

### Export Policies

Both SVMs allow NFS from storage subnets + mgmt subnet. All rules: RO/RW/Superuser = any.

**backend_infra_access:** 10.172.192.0/24, 10.172.196.0/24, 10.172.200.0/24, 10.172.248.0/24

**backend_app_access:** 10.172.194.0/24, 10.172.198.0/24, 10.172.202.0/24, 10.172.248.0/24

---

## Trident CSI

| Component | Value |
|-----------|-------|
| Operator | NetApp Trident Certified (OperatorHub) |
| Namespace | trident |

### Backends

| Backend | SVM | Data LIF | Mgmt LIF | Creds | Status |
|---------|-----|----------|----------|-------|--------|
| backend-infra-nfs | ocp_infra_svm | 10.172.192.22 | 10.172.254.46 | vsadmin | Bound/Success |
| backend-app-nfs | ocp_app_svm | 10.172.194.22 | 10.172.254.47 | vsadmin | Bound/Success |

Secrets: `backend-infra-secret` / `backend-app-secret` in trident ns. Originally cluster admin — migrated to vsadmin Feb 18.

### Storage Classes

| Name | Driver | Default | Reclaim | NFS |
|------|--------|---------|---------|-----|
| netapp-app | ontap-nas | Yes | Retain | 4.1 |
| netapp-infra | ontap-nas | No | Retain | 4.1 |

### Notes

Create secrets with single quotes (special chars):
```
oc -n trident create secret generic backend-infra-secret \
  --from-literal=username=vsadmin --from-literal=password='<pw>' \
  --dry-run=client -o yaml | oc apply -f -
```

If backend goes Failed after patching managementLIF, bump `spec.version` or delete/recreate the tbc. Make sure aggregates are assigned to SVMs first:
```
vserver modify -vserver <svm> -aggr-list aggr1_n1,aggr1_n2,aggr1_n3,aggr1_n4,aggr1_n5,aggr1_n6
```

---

## GPU Operator

NFD (Red Hat) + NVIDIA GPU Operator. Default settings. ClusterPolicy: Ready.

| Node | GPUs | Model |
|------|------|-------|
| ocp-ai-gpu01 | 4 | H100L 94GB |
| ocp-ai-gpu02 | 4 | H100L 94GB |
| Total | 8 | 752 GB GPU memory |

DCGM exporter may restart a couple times on initial setup — waits on driver pods.

---

## Image Registry

| Parameter | Value |
|-----------|-------|
| State | Managed |
| Replicas | 2 |
| Storage | 100Gi PVC (netapp-infra) |
| Node Selector | master nodes only |
| Route | default-route-openshift-image-registry.apps.ocp-ai.calix.local |
| Route Timeout | 600s |

Pinned to masters — GPU workers don't have storage VLANs, NFS mounts hang.

---

## GitOps — ArgoCD

| Parameter | Value |
|-----------|-------|
| Operator | Red Hat OpenShift GitOps |
| Namespace | openshift-gitops |
| URL | openshift-gitops-server-openshift-gitops.apps.ocp-ai.calix.local |
| Creds | admin / extract from secret |

Repo: ocp-ai-platform in Stash project OCPAI (ticket submitted). Branch-based: main=prod, dev, test.

> Install hit DeadlineExceeded on bundle unpack first time. Delete failed job + configmap + namespace, reinstall.

---

## TLS / Vault PKI

cert-manager operator installed. Vault at plnx-vault.calix.local as issuer.

| Item | Value |
|------|-------|
| PKI Engine | pki_int |
| CN | Calix OCP-AI Intermediate CA |
| pathlen | 0 |
| TTL | 5 years |
| CSR | /tmp/ocp-ai-intermediate.csr on vault |
| Scope | *.calix.local, internal only |

Trust chain: Calix Root CA > Calix Intermediate > OCP-AI Intermediate (Vault) > leaf certs

CSR pending IT signing — discussing with Brian. Proceeding with self-signed CA in Vault to unblock k8s auth + cert-manager now. Will swap to Calix-signed intermediate once approved.

---

## AI Platform Services (Planned)

| Service | Tech | Status |
|---------|------|--------|
| Object storage | MinIO | Planned, NetApp backed |
| Vector database | Milvus | Confirmed (not pgvector) |
| PostgreSQL | CNPG | Planned |

Waiting on Sulabh for ML platform, notebooks, model serving details.

---

## Operators

| Operator | Namespace | Status |
|----------|-----------|--------|
| Kubernetes NMState | openshift-nmstate | Succeeded |
| NetApp Trident | trident | Installed |
| Node Feature Discovery | openshift-nfd | Installed |
| NVIDIA GPU Operator | nvidia-gpu-operator | Installed |
| cert-manager | cert-manager | Installed |
| OpenShift GitOps | openshift-gitops | Installed |

---

## MachineConfigs

| Name | Role | Purpose |
|------|------|---------|
| 99-worker-mtu-9000 | worker | MTU 9000 on eno8303 + br-ex at boot |

---

## Access

| | URL / Address |
|-|---------------|
| Console | https://console-openshift-console.apps.ocp-ai.calix.local |
| API | https://api.ocp-ai.calix.local:6443 |
| CLI | `oc login -u kubeadmin https://api.ocp-ai.calix.local:6443 --insecure-skip-tls-verify` |
| kubeconfig | ~/kubeconfig on plnx-admin |
| SSH masters | `ssh -i ~/.ssh/ocp-ai core@10.172.248.150/151/152` |
| SSH GPU | `ssh -i ~/.ssh/ocp-ai core@10.172.248.153/154` |
| Registry | default-route-openshift-image-registry.apps.ocp-ai.calix.local |
| ArgoCD | openshift-gitops-server-openshift-gitops.apps.ocp-ai.calix.local |

| System | Address | Creds |
|--------|---------|-------|
| plnx-admin | 10.172.248.50 | hsuma |
| Intersight | us-east-1.intersight.com | haj.suma@calix.com |
| NetApp cluster | 10.152.0.110 | admin |
| NetApp infra SVM | 10.172.254.46 | vsadmin |
| NetApp app SVM | 10.172.254.47 | vsadmin |
| GPU01 iDRAC | 10.152.0.43 | root/calvin |
| GPU02 iDRAC | 10.152.0.44 | root/calvin |
| Vault | plnx-vault.calix.local | — |

---

## Resolved Issues

| What | Fix | When |
|------|-----|------|
| Prod LIFs on wrong VLANs | Moved to 1793/1797 | Feb 18 |
| Dell servers missing VLAN 1510 | Configured Leaf-3 | Feb 18 |
| GPU worker MTU 1500 vs overlay 8958 | MachineConfig + switch jumbo frames | Feb 18 |
| Trident on cluster admin creds | Migrated to vsadmin per SVM | Feb 18 |
| Trident on cluster mgmt LIF | Patched to SVM mgmt LIFs | Feb 18 |
| vsadmin can't see aggregates | Assigned all aggrs to both SVMs | Feb 18 |
| Registry NFS hang on GPU workers | nodeSelector to masters | Feb 18 |

## Open Items

| Item | Owner | Status |
|------|-------|--------|
| NTP config | Haj | Not started |
| GPU NIC migration (1G to 100G) | Chetan/Haj | Waiting on switch config |
| Red Hat subscription | Haj | Need before April |
| Vault CSR signing | Haj/Brian | Discussing with IT |
| Vault k8s auth + cert-manager | Haj | Proceeding with self-signed for now |
| Stash project (OCPAI) | Haj | Ticket submitted |
| ArgoCD repo | Haj | Blocked on Stash |
| NetBox IPAM | Vinoth | Assigned |
| AI stack details | Sulabh | Expected Friday |

---

## Git Repo

Local: `~/ocp-ai-config` on plnx-admin. Remote: Stash (pending).

```
ocp-ai-config/
├── nmstate/
│   ├── nncp-master01.yaml
│   ├── nncp-master02.yaml
│   └── nncp-master03.yaml
├── trident/
│   ├── backend-infra.yaml
│   ├── backend-app.yaml
│   ├── storageclasses.yaml
│   ├── secret-infra.yaml        # gitignored
│   └── secret-app.yaml          # gitignored
└── machineconfigs/
    └── mc-worker-mtu.yaml
```

---

## Timeline

| When | What |
|------|------|
| Week of Feb 9 | Networking finished switch/VLAN config |
| Feb 11 | Started OCP deployment ~2pm |
| Feb 11-14 | Assisted Installer, ISO, vMedia troubleshooting |
| Feb 15 | First install failed (vMedia disconnect at 28%). Second attempt — 3 masters up |
| Feb 16 | Holiday |
| Feb 17 | NMState + storage VLANs, Trident + PVC test, GPU server investigation (blocked) |
| Feb 18 | GPU workers joined, GPU Operator (8x H100), registry, Trident SVM migration, cert-manager, Vault PKI, ArgoCD |

### Milestones

| Target | Date |
|--------|------|
| Engineering complete | March 18 |
| Shakeout | March 19-20 |
| Hardening | March 21-22 |
| Release | March 23 |

---

## Contacts

| Who | What |
|-----|------|
| Haj | Cluster build, config, ops |
| Deonna | NetApp storage |
| Gowtham | DC ops, cabling, iDRAC |
| Chetan | Switches, VLANs, MTU |
| Brian | Manager, PKI approval |
| Sulabh | AI/ML stack |
| Vinoth | NetBox IPAM |
