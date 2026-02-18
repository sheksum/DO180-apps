# OCP-AI Cluster — Task Tracker (Updated February 18, 2026)
## Engineer: Haj Suma

---

## TASK 1: OpenShift Installation — 95% COMPLETE (Est: 5 days | Remaining: 0.5 day)

| Subtask | Description | Est. | Status | Notes |
|---------|-------------|------|--------|-------|
| 1.1 | Generate discovery ISO via Assisted Installer | 0.5d | ✅ Done | Full image, OCP 4.20.13 |
| 1.2 | Configure Intersight vMedia / boot media | 1d | ✅ Done | Used KVM virtual media for UCS-X, iDRAC virtual media for Dell |
| 1.3 | Boot blades and assign roles | 0.5d | ✅ Done | 3 masters operational, 2 GPU workers installing |
| 1.4 | Complete OpenShift installation and bootstrap | 1.5d | ✅ Done | Cluster bootstrapped and operational |
| 1.5 | Validate all nodes Ready and operators healthy | 0.5d | ✅ Done | 3/3 masters Ready, all operators healthy, 223 pods |
| 1.6 | Configure kubeadmin credentials and oc CLI | 0.5d | ✅ Done | oc CLI on plnx-admin, kubeconfig downloaded |
| 1.7 | Configure NTP sync across all nodes | 0.5d | ⬜ Open | Not yet configured |

**Remaining:** NTP configuration (1.7), GPU worker CSR approval (pending install completion)

---

## TASK 2: Dell GPU Server Setup — 75% COMPLETE (Est: 4 days | Remaining: 1 day)

| Subtask | Description | Est. | Status | Notes |
|---------|-------------|------|--------|-------|
| 2.1 | Network connectivity on VLAN 1510 | 2d | ✅ Done | Gowtham/networking configured VLAN 1510 on Leaf-3 switch |
| 2.2 | Boot Discovery ISO and register hosts | 0.5d | ✅ Done | Both hosts discovered in Assisted Installer |
| 2.3 | Set hostnames and roles | 0.25d | ✅ Done | gpu01/gpu02 set as Worker role |
| 2.4 | Install CoreOS and join cluster | 0.5d | 🔄 In Progress | Installation started, awaiting completion |
| 2.5 | Approve worker CSRs | 0.25d | ⬜ Open | Pending install completion |

**Hardware Confirmed (per server):**
- 4x NVIDIA H100L 94GB GPUs (8 total across both servers)
- 128 cores (hyper-threaded) Intel Xeon Platinum 8562Y+
- 2 TiB RAM
- 480 GB NVMe boot drive (Dell BOSS-N1)
- 26.88 TB RAID array (local scratch storage)
- Mellanox ConnectX-6 Dx (40Gbps + 100Gbps)

**Updated Notes:** Original subtasks 2.1-2.4 (manual RHEL install, GPU drivers, CUDA toolkit) are NOT required — CoreOS is installed automatically by Assisted Installer, GPU drivers handled by NVIDIA GPU Operator (Task 8).

---

## TASK 3: Storage Networking — 95% COMPLETE (Est: 3 days | Remaining: 0.5 day)

| Subtask | Description | Est. | Status | Notes |
|---------|-------------|------|--------|-------|
| 3.1 | Create MachineConfigs for VLAN subinterfaces | 1d | ✅ Done | NMState NNCPs with bond (bnd0 = eno7 + eno8 active-backup) |
| 3.2 | Configure infra/app VLANs for dev/test/prod | 0.5d | ✅ Done | 6 VLANs: 1792, 1793, 1794, 1796, 1797, 1798 |
| 3.3 | Assign IPs and set MTU 9000 | 0.5d | ✅ Done | IPs .150/.151/.152 per VLAN, MTU 9000 on bond |
| 3.4 | Validate connectivity and jumbo frames to NetApp LIFs | 0.5d | ⬜ Open | Ping works, jumbo frame test not yet run |

**Remaining:** Jumbo frame validation (ping -M do -s 8972)

---

## TASK 4: NetApp Trident CSI — 90% COMPLETE (Est: 3 days | Remaining: 0.5 day)

| Subtask | Description | Est. | Status | Notes |
|---------|-------------|------|--------|-------|
| 4.1 | Install Trident operator | 0.5d | ✅ Done | NetApp Trident Certified from OperatorHub |
| 4.2 | Create Trident backends for infra and app SVMs | 1d | ✅ Done | backend-infra-nfs and backend-app-nfs — Bound/Success |
| 4.3 | Create StorageClasses per environment | 0.5d | ✅ Done | netapp-infra, netapp-app (default) |
| 4.4 | Validate PVC creation and pod mounts | 0.5d | ✅ Done | PVC test successful — Bound |
| 4.5 | Validate read/write access to NetApp | 0.5d | ⬜ Open | Pod mount read/write test not yet performed |

**Pending from Deonna:** ✅ ALL RESOLVED
- ~~Fix prod LIF VLANs (1800→1793, 1802→1797)~~ ✅ Done
- ~~Create SVM management LIFs~~ ✅ Done
- ~~Create SVM service accounts~~ ✅ Done
- ~~Configure NFS export policies~~ ✅ Done
- **Action needed:** Update Trident backend configs with new SVM mgmt LIFs and service account credentials

---

## TASK 5: Internal Image Registry — NOT STARTED (Est: 1 day)

| Subtask | Description | Est. | Status | Notes |
|---------|-------------|------|--------|-------|
| 5.1 | Enable OpenShift internal registry | 0.25d | ⬜ Open | |
| 5.2 | Back registry storage with NetApp via Trident | 0.25d | ⬜ Open | |
| 5.3 | Validate image push/pull | 0.25d | ⬜ Open | |
| 5.4 | Configure image pull secrets | 0.25d | ⬜ Open | |

**Dependencies:** Trident operational ✅ — no blockers

---

## TASK 6: Ingress and Load Balancing — NOT STARTED (Est: 3 days)

| Subtask | Description | Est. | Status | Notes |
|---------|-------------|------|--------|-------|
| 6.1 | Deploy MetalLB or configure F5 integration | 1d | ⬜ Open | |
| 6.2 | Define IP pools and ingress configuration | 0.5d | ⬜ Open | |
| 6.3 | Configure DNS wildcard records | 0.5d | ⬜ Open | |
| 6.4 | Configure TLS certificates | 0.5d | ⬜ Open | |
| 6.5 | Validate external access | 0.5d | ⬜ Open | |

**Dependencies:** None — can proceed now

---

## TASK 7: Authentication and RBAC — NOT STARTED (Est: 4 days)

| Subtask | Description | Est. | Status | Notes |
|---------|-------------|------|--------|-------|
| 7.1 | Configure identity provider (IPA/LDAP) | 1d | ⬜ Open | Haj manages IPA — no external dependency. Okta can be added later as second IdP if management decides |
| 7.2 | Define RBAC for admin, dev, and ops roles | 1d | ⬜ Open | Map LDAP groups to OCP ClusterRoles/RoleBindings |
| 7.3 | Create dev/test/prod namespaces | 0.5d | ⬜ Open | |
| 7.4 | Apply quotas, limits, and network policies | 0.5d | ⬜ Open | |
| 7.5 | Add Okta as secondary IdP (if approved) | 1d | ⬜ Pending | Awaiting manager decision — does not block other subtasks |

**Dependencies:** None — Haj manages IPA directly. Okta integration pending manager approval.

---

## TASK 8: GPU Operator and Scheduling — NOT STARTED (Est: 2 days | Blocked on Task 2)

| Subtask | Description | Est. | Status | Notes |
|---------|-------------|------|--------|-------|
| 8.1 | Install Node Feature Discovery | 0.25d | ⬜ Open | |
| 8.2 | Install NVIDIA GPU Operator | 0.5d | ⬜ Open | |
| 8.3 | Configure GPU scheduling | 0.5d | ⬜ Open | |
| 8.4 | Apply taints/tolerations for GPU nodes | 0.25d | ⬜ Open | |
| 8.5 | Validate GPU access from pods | 0.5d | ⬜ Open | |

**Dependencies:** GPU workers must be joined to cluster (Task 2.4/2.5)
**Hardware:** 8x NVIDIA H100L 94GB total (4 per server)

---

## TASK 9: GitOps — 10% COMPLETE (Est: 4 days | Remaining: 3.5 days)

| Subtask | Description | Est. | Status | Notes |
|---------|-------------|------|--------|-------|
| 9.1 | Install OpenShift GitOps (ArgoCD) | 0.5d | ⬜ Open | |
| 9.2 | Configure ArgoCD and RBAC | 1d | ⬜ Open | |
| 9.3 | Define repository structure | 1d | 🔄 Started | Local repo at ~/ocp-ai-config with nmstate/ and trident/ |
| 9.4 | Bootstrap cluster configuration via GitOps | 1d | ⬜ Open | |
| 9.5 | Validate sync and rollback | 0.5d | ⬜ Open | |

**Dependencies:** Bitbucket Stash repo creation pending

---

## TASK 10: Backup and Disaster Recovery — NOT STARTED (Est: 3 days)

| Subtask | Description | Est. | Status | Notes |
|---------|-------------|------|--------|-------|
| 10.1 | Install Velero or OADP | 0.5d | ⬜ Open | |
| 10.2 | Configure backup storage location | 0.5d | ⬜ Open | |
| 10.3 | Define backup schedules | 0.5d | ⬜ Open | |
| 10.4 | Configure etcd backup automation | 0.5d | ⬜ Open | |
| 10.5 | Test restore of a sample namespace | 1d | ⬜ Open | |

**Dependencies:** Storage classes operational ✅

---

## TASK 11: End-to-End Validation — NOT STARTED (Est: 4 days)

| Subtask | Description | Est. | Status | Notes |
|---------|-------------|------|--------|-------|
| 11.1 | Deploy sample AI workload (GPU + NetApp) | 1.5d | ⬜ Open | |
| 11.2 | Validate deployment via GitOps | 1d | ⬜ Open | |
| 11.3 | Validate dev/test/prod isolation | 0.5d | ⬜ Open | |
| 11.4 | Validate backup and restore of workload | 1d | ⬜ Open | |

**Dependencies:** Tasks 2, 8, 9, 10 must be complete

---

## TASK 12: Monitoring and Alerting — FUTURE / ADD-ON (Est: 3 days)

| Subtask | Description | Est. | Status | Notes |
|---------|-------------|------|--------|-------|
| 12.1 | Configure persistent storage for monitoring | 0.5d | ⬜ Open | |
| 12.2 | Define retention policies | 0.5d | ⬜ Open | |
| 12.3 | Create custom alert rules | 1d | ⬜ Open | |
| 12.4 | Create dashboards | 1d | ⬜ Open | |

---

## TASK 13: Logging — FUTURE / ADD-ON (Est: 2 days)

| Subtask | Description | Est. | Status | Notes |
|---------|-------------|------|--------|-------|
| 13.1 | Deploy logging stack | 0.5d | ⬜ Open | |
| 13.2 | Configure persistent storage | 0.5d | ⬜ Open | |
| 13.3 | Define retention policies | 0.5d | ⬜ Open | |
| 13.4 | Configure log forwarding | 0.5d | ⬜ Open | |

---

## Overall Progress Summary

| Task | Description | Status | % | Est. Days | Days Remaining |
|------|-------------|--------|---|-----------|----------------|
| 1 | OpenShift Installation | Nearly Complete | 95% | 5 | 0.5 |
| 2 | Dell GPU Server Setup | In Progress | 75% | 4 | 1 |
| 3 | Storage Networking | Nearly Complete | 95% | 3 | 0.5 |
| 4 | NetApp Trident CSI | Nearly Complete | 90% | 3 | 0.5 |
| 5 | Internal Image Registry | Not Started | 0% | 1 | 1 |
| 6 | Ingress and Load Balancing | Not Started | 0% | 3 | 3 |
| 7 | Authentication and RBAC | Not Started | 0% | 4 | 4 |
| 8 | GPU Operator and Scheduling | Blocked on Task 2 | 0% | 2 | 2 |
| 9 | GitOps | Started | 10% | 4 | 3.5 |
| 10 | Backup and DR | Not Started | 0% | 3 | 3 |
| 11 | End-to-End Validation | Not Started | 0% | 4 | 4 |
| 12 | Monitoring (future) | Not Started | 0% | 3 | 3 |
| 13 | Logging (future) | Not Started | 0% | 2 | 2 |

**Total Estimated Days: 41 | Days Remaining: 28.5 (parallelized: ~19) | Working Days to Mar 18: 19**
**Overall Project: ~35% complete**

---

## Key Milestones

| Milestone | Date | Description |
|-----------|------|-------------|
| Engineering Complete | March 18, 2026 | All 13 tasks completed |
| Shakeout Testing | March 19–20, 2026 | 2-day stress test, failure injection, workload validation |
| Bug Fixes / Hardening | March 21–22, 2026 | Resolve any issues found during shakeout |
| Cluster Release | March 23, 2026 | Cluster released for production deployment |

---

## Dependency Tracker

| Dependency | Owner | Status | Impact |
|-----------|-------|--------|--------|
| VLAN 1510 on Leaf-3 | Networking/Gowtham | ✅ Resolved | GPU workers can now join |
| NetApp prod VLAN fix (1800/1802→1793/1797) | Deonna Thornton | ✅ Resolved | VLANs corrected to 1793/1797 |
| SVM management LIFs | Deonna Thornton | ✅ Resolved | Need to get IPs and update Trident backends |
| SVM service accounts | Deonna Thornton | ✅ Resolved | Need to get creds and update Trident secrets |
| NFS export policies | Deonna Thornton | ✅ Resolved | Configured |
| Okta IdP decision | Manager | ⬜ Pending | Optional — does not block Task 7 |
| Bitbucket Stash repo | Haj | ⬜ Pending | Blocks Task 9 push |
| Red Hat subscription | Haj | ⬜ Pending | Trial expires ~April 12 |
