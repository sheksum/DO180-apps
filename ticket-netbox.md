# TASK 15: NetBox IPAM — OCP-AI Infrastructure Documentation

## Summary
Populate the existing NetBox IPAM/DCIM instance with all OCP-AI platform infrastructure data including networks, VLANs, IP assignments, hardware inventory, and cable mapping.

## Assigned To: Vinoth
## Priority: Medium
## Target Completion: March 14, 2026

---

## Subtasks

| Subtask | Description | Est. | Status | Notes |
|---------|-------------|------|--------|-------|
| 15.1 | Document all OCP-AI VLANs and subnets (mgmt, storage, SVM mgmt) | 1d | Done | Data gathered — see reference data below. Enter into NetBox. |
| 15.2 | Document all node IPs, VIPs, iDRAC IPs, and management interfaces | 1d | Done | Data gathered — see reference data below. Enter into NetBox. |
| 15.3 | Document NetApp cluster, SVM, and LIF details | 0.5d | Done | Data gathered — see reference data below. Enter into NetBox. |
| 15.4 | Document rack layouts and hardware inventory in NetBox | 1d | Open | Enter hardware data and document rack positions |
| 15.5 | Document switch port mappings and cable connections | 1d | Open | Coordinate with Chetan/Gowtham for physical layer details |
| 15.6 | Validate entries and review with team | 0.5d | Open | Validate all entries with Haj |

## Estimated Duration: 5 days total (2.5 days completed, 2.5 days remaining)

---

## Reference Data to Populate in NetBox

### Management Network (VLAN 1510)

| Parameter | Value |
|-----------|-------|
| VLAN ID | 1510 |
| Subnet | 10.172.248.0/24 |
| Gateway | 10.172.248.1 |
| DNS Servers | 10.172.248.31, 10.172.248.32 |
| MTU | 9000 |

### Node IP Assignments

| Hostname | IP Address | Role | Hardware |
|----------|-----------|------|----------|
| ocp-ai-master01.calix.local | 10.172.248.150 | Control Plane + Worker | UCS-X 210C-M7 |
| ocp-ai-master02.calix.local | 10.172.248.151 | Control Plane + Worker | UCS-X 210C-M7 |
| ocp-ai-master03.calix.local | 10.172.248.152 | Control Plane + Worker | UCS-X 210C-M7 |
| ocp-ai-gpu01.calix.local | 10.172.248.153 | Worker (GPU) | Dell R760xa |
| ocp-ai-gpu02.calix.local | 10.172.248.154 | Worker (GPU) | Dell R760xa |
| api.ocp-ai.calix.local | 10.172.248.155 | API VIP | Virtual |
| *.apps.ocp-ai.calix.local | 10.172.248.156 | Ingress VIP | Virtual |

### Storage Network VLANs

| Environment | Purpose | VLAN ID | Subnet | NetApp LIF IPs |
|-------------|---------|---------|--------|----------------|
| Dev | Infra | 1792 | 10.172.192.0/23 | 10.172.192.22, .23 |
| Dev | Application | 1794 | 10.172.194.0/23 | 10.172.194.22, .23 |
| Test | Infra | 1796 | 10.172.196.0/23 | 10.172.196.22, .23 |
| Test | Application | 1798 | 10.172.198.0/23 | 10.172.198.22, .23 |
| Prod | Infra | 1793 | 10.172.200.0/23 | 10.172.200.22, .23 |
| Prod | Application | 1797 | 10.172.202.0/23 | 10.172.202.22, .23 |

### SVM Management Network (VLAN 1570)

| SVM | Management LIF | IP |
|-----|---------------|-----|
| ocp_infra_svm | ocp_infra_mgmt | 10.172.254.46/24 |
| ocp_app_svm | ocp_app_mgmt | 10.172.254.47/24 |

### Storage Node IPs (Master Nodes)

| VLAN | Master01 | Master02 | Master03 |
|------|----------|----------|----------|
| 1792 | 10.172.192.150 | 10.172.192.151 | 10.172.192.152 |
| 1794 | 10.172.194.150 | 10.172.194.151 | 10.172.194.152 |
| 1796 | 10.172.196.150 | 10.172.196.151 | 10.172.196.152 |
| 1798 | 10.172.198.150 | 10.172.198.151 | 10.172.198.152 |
| 1793 | 10.172.200.150 | 10.172.200.151 | 10.172.200.152 |
| 1797 | 10.172.202.150 | 10.172.202.151 | 10.172.202.152 |

### Infrastructure Management IPs

| System | IP | Purpose |
|--------|-----|---------|
| plnx-admin (workstation) | 10.172.248.50/105 | OCP admin workstation |
| NetApp Cluster Mgmt | 10.152.0.110 | NetApp cluster management |
| NetApp ocp_infra_svm Mgmt | 10.172.254.46 | Infra SVM management |
| NetApp ocp_app_svm Mgmt | 10.172.254.47 | App SVM management |
| GPU01 iDRAC | 10.152.0.43 | Dell GPU01 out-of-band management |
| GPU02 iDRAC | 10.152.0.44 | Dell GPU02 out-of-band management |
| Vault | plnx-vault.calix.local | HashiCorp Vault PKI |

### Hardware Inventory

#### UCS-X Blades (Control Plane) — Chassis PLN-UCSX-F1-01 Slot 4

| Blade | Hostname | Model | CPU | RAM | Storage |
|-------|----------|-------|-----|-----|---------|
| 4-1 | ocp-ai-master01 | UCS-X 210C-M7 | 128 cores | 2 TiB | 480 GB |
| 4-2 | ocp-ai-master02 | UCS-X 210C-M7 | 128 cores | 2 TiB | 480 GB |
| 4-3 | ocp-ai-master03 | UCS-X 210C-M7 | 128 cores | 2 TiB | 480 GB |

#### UCS-X vNIC MAC Addresses

| Blade | OCP-MGT-A (eno5) | OCP-DATA-A (eno7) |
|-------|-------------------|-------------------|
| 4-1 (master01) | 00:25:B5:50:0A:64 | 00:25:B5:50:0A:65 |
| 4-2 (master02) | 00:25:B5:50:0A:66 | 00:25:B5:50:0A:67 |
| 4-3 (master03) | 00:25:B5:50:0A:68 | 00:25:B5:50:0A:69 |

#### Dell GPU Servers (Workers)

| Parameter | GPU01 | GPU02 |
|-----------|-------|-------|
| Model | Dell PowerEdge R760xa | Dell PowerEdge R760xa |
| Serial | 6RJWMD4 | 7RJWMD4 |
| CPU | 2x Intel Xeon Platinum 8562Y+ (128 cores HT) | Same |
| RAM | 2 TiB | 2 TiB |
| GPU | 4x NVIDIA H100L 94GB | 4x NVIDIA H100L 94GB |
| Boot Drive | 480 GB NVMe (Dell BOSS-N1) | Same |
| Local Storage | 26.88 TB RAID | Same |
| Mgmt NIC (eno8303) | Broadcom BCM5720 1GbE | Same |
| Mgmt NIC MAC | C8:4B:D6:F3:D8:40 | C8:4B:D6:F3:D8:22 |
| Mellanox NIC (Slot 8) | ConnectX-6 Dx 100GbE | Same |
| Mellanox Port 2 MAC | 7C:8C:09:C3:74:1F | 7C:8C:09:C3:79:87 |

#### NetApp Cluster

| Parameter | Value |
|-----------|-------|
| Cluster Name | plano_aff_cl |
| Type | AFF (All Flash) |
| Nodes | 6 (plano_aff_cl-01 through 06) |
| Cluster Mgmt IP | 10.152.0.110 |

| SVM | Purpose | Aggregates |
|-----|---------|------------|
| ocp_infra_svm | Infrastructure storage | aggr1_n1 through aggr1_n6 |
| ocp_app_svm | Application storage | aggr1_n1 through aggr1_n6 |

### NetApp LIFs

#### ocp_infra_svm

| LIF | IP | VLAN | Home Node |
|-----|-----|------|-----------|
| ocp_infra_mgmt | 10.172.254.46 | a0a-1570 | plano_aff_cl-05 |
| ocp_infra_dev_lif01 | 10.172.192.22 | a0a-1792 | plano_aff_cl-05 |
| ocp_infra_dev_lif02 | 10.172.192.23 | a0a-1792 | plano_aff_cl-06 |
| ocp_infra_test_lif01 | 10.172.196.22 | a0a-1796 | plano_aff_cl-05 |
| ocp_infra_test_lif02 | 10.172.196.23 | a0a-1796 | plano_aff_cl-06 |
| ocp_infra_prod_lif01 | 10.172.200.22 | a0a-1793 | plano_aff_cl-05 |
| ocp_infra_prod_lif02 | 10.172.200.23 | a0a-1793 | plano_aff_cl-06 |

#### ocp_app_svm

| LIF | IP | VLAN | Home Node |
|-----|-----|------|-----------|
| ocp_app_mgmt | 10.172.254.47 | a0a-1570 | plano_aff_cl-06 |
| ocp_app_dev_lif01 | 10.172.194.22 | a0a-1794 | plano_aff_cl-05 |
| ocp_app_dev_lif02 | 10.172.194.23 | a0a-1794 | plano_aff_cl-06 |
| ocp_app_test_lif01 | 10.172.198.22 | a0a-1798 | plano_aff_cl-05 |
| ocp_app_test_lif02 | 10.172.198.23 | a0a-1798 | plano_aff_cl-06 |
| ocp_app_prod_lif01 | 10.172.202.22 | a0a-1797 | plano_aff_cl-05 |
| ocp_app_prod_lif02 | 10.172.202.23 | a0a-1797 | plano_aff_cl-06 |

---

## Acceptance Criteria
- All OCP-AI VLANs (1510, 1570, 1792-1798) and subnets documented in NetBox
- All node IP assignments (masters, GPU workers, VIPs) recorded
- All infrastructure management IPs (iDRAC, NetApp, Vault) recorded
- All hardware (3x UCS-X blades, 2x Dell GPU servers, NetApp 6-node cluster) inventoried
- MAC addresses documented for all NICs
- NetApp LIFs and SVM details documented
- Switch port and cable mappings documented
- Entries reviewed and validated

## Dependencies
- Access to NetBox instance (coordinate with NetBox team)
