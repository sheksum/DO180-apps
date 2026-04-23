# kindo-ai Cluster — Architecture Reference

*TTM on-prem (vSphere) · RKE2 v1.34.4 · Drafted April 2026*

---

## 1. Purpose and audience

This document describes the architecture of the `kindo-ai` Kubernetes cluster in enough detail that someone new to the platform can orient themselves in about 30 minutes of reading. It is not a runbook — it does not tell you how to do operational tasks. It is a reference for "what is here, how is it wired, and why."

**Audience:** members of the ITLinux team (who own the cluster), Vation (while under contract), Kindo support engineers when escalating issues, and anyone auditing or reviewing the platform.

**Status of this document:** many sections contain explicit `TBC` (to be confirmed) placeholders for information that lives inside vendor-managed secrets or in the heads of the Vation team. These are intentionally marked as gaps to be closed during knowledge transfer.

**Cluster purpose:** internal TTM users run AI-assisted code-generation workloads through the Kindo platform, which is deployed on this cluster along with its supporting services and an AI inference stack. The platform is pre-production at time of writing, with no formal SLA and no on-call rotation.

**Change control:** changes require approval from Jim Himes.

---

## 2. VM topology and inventory

The cluster runs on 11 vSphere VMs on the `10.200.248.0/24` network. Nine are in-cluster Kubernetes nodes; two are supporting VMs running Docker containers outside the cluster.

### Kubernetes nodes

| Hostname | IP | Role | Notes |
|---|---|---|---|
| aamslc4kbc01 | 10.200.248.21 | Control plane + etcd | Stacked etcd, tainted NoSchedule |
| aamslc4kbc02 | 10.200.248.22 | Control plane + etcd | Stacked etcd, tainted NoSchedule |
| aamslc4kbc03 | 10.200.248.23 | Control plane + etcd | Stacked etcd, tainted NoSchedule |
| aamslc4kbw01 | 10.200.248.41 | General worker | RKE2 v1.34.4 |
| aamslc4kbw02 | 10.200.248.42 | General worker | RKE2 v1.34.4 |
| aamslc4kbw03 | 10.200.248.43 | General worker | RKE2 v1.34.4 |
| aamslc4kbw04 | 10.200.248.44 | General worker | RKE2 v1.34.5 (version drift) |
| aamslc4kbw05 | 10.200.248.45 | General worker | RKE2 v1.34.5 (version drift) |
| aamslc4kbg01 | 10.200.248.61 | GPU worker | 8× NVIDIA H200-NVL, tainted `nvidia.com/gpu=true:NoSchedule` |

All nodes run RHEL 9.7. All nodes are registered directly with the cluster and managed by the same RKE2 install.

### Supporting VMs (outside the cluster)

| Hostname | IP | Role | What runs there |
|---|---|---|---|
| aamslc4hap01 | 10.200.248.30 | API load balancer + object store | `haproxy-ttm:latest` and `minio/minio:latest` as Docker containers |
| aamslc4kbr01 | 10.200.248.81 | Rancher management | Rancher v2.13.2 as a Docker install |

Additionally, an NFS file server at `aamslc4nfs01.ttmtech.local:/srv/nfs` is mounted on every worker at `/mnt/nfs-backups` (1 TB capacity, currently ~7 GB used, not referenced by any Kubernetes resource).

**TBC:** whether HAProxy and Rancher VMs reside on the same ESXi host (single failure domain) or different hosts, and whether vSphere DRS anti-affinity rules prevent the three control-plane VMs from co-residing.

---

## 3. Network architecture

### DNS

External hostnames (`*.ttmtech.com` and `*.kbai.ttmtech.com`) resolve through corporate DNS to the HAProxy VM at `10.200.248.30`. The most significant hostnames:

| Hostname | Target | Purpose |
|---|---|---|
| api.kbai.ttmtech.local | 10.200.248.30 (HAProxy) | Kubernetes API server (for workers + kubectl) |
| api.kbai.ttmtech.com | 10.200.248.30 | Kindo API (workload ingress) |
| app.kbai.ttmtech.com | 10.200.248.30 | Kindo frontend (Next.js) |
| athena.ttmtech.com | 10.200.248.30 | Kindo frontend (alias) |
| rancher.kbai.ttmtech.com | 10.200.248.81 (Rancher VM) | Rancher management UI |
| s3.kbai.ttmtech.com | 10.200.248.30 | MinIO S3 API |
| minio-console.ttmtech.com | 10.200.248.30 | MinIO web console |
| pgweb.kbai.ttmtech.com | 10.200.248.30 | pgweb (⚠ no TLS, no auth) |
| sso.kbai.ttmtech.com, sso-api, sso-app, sso-auth | 10.200.248.30 | SSOReady endpoints |
| zuva.ttmtech.com | 10.200.248.30 | Zuva/AITK ingress (via Istio gateway) |

**TBC:** whether any CDN, WAF, or corporate proxy sits between TTM users and these hostnames.

### HAProxy

A single VM (`aamslc4hap01`) runs HAProxy in a Docker container as the external front door for the cluster. The HAProxy configuration lives at `/root/haproxy/haproxy.cfg` on that VM, along with a `Dockerfile`, `dependencies.sh`, and `start.sh` maintained by Vation.

Listen ports:

| Port | Role | Backends |
|---|---|---|
| 6443 | Kubernetes API server | master-0/1/2:6443 (TCP, balance source) |
| 9345 | RKE2 supervisor (node registration) | master-0/1/2:9345 |
| 80 | HTTP ingress | worker-0/1/2:80 |
| 443 | HTTPS ingress | worker-0/1/2:443 |
| 8404 | HAProxy stats UI (no auth) | n/a — serves directly |

The worker backends in `haproxy.cfg` reference `worker-0`, `worker-1`, `worker-2`, and `worker-gpu-0` through `worker-gpu-7`. Only `aamslc4kbw01–03` (aliased as `worker-0..2`) and `aamslc4kbg01` (aliased as `worker-gpu-0`) exist on the network. `aamslc4kbw04` and `aamslc4kbw05` are not listed as backends despite running ingress-nginx. The HAProxy stats page persistently shows 8 backends failing as a result.

HAProxy itself is a single VM with no keepalived pair, no VIP, and no secondary HAProxy peer.

### Ingress

Inside the cluster, `rke2-ingress-nginx-controller` runs as a DaemonSet on general workers (`kbw01`–`kbw05`). It does not run on the GPU node (correctly excluded by the `nvidia.com/gpu` taint).

Authentication for ingresses varies:
- Two namespaces use `oauth2-proxy` for ingress-level auth (`aitk-console`, `field-discovery`)
- Other ingresses handle auth at the application layer or have no auth (notably `pgweb`)

### Certificates

cert-manager is deployed but no `Issuer` or `ClusterIssuer` exists. Six `Certificate` resources are in a perpetual not-ready state.

TLS is currently provided by a **DigiCert-issued wildcard certificate** (`*.ttmtech.com`) that has been manually imported as a Kubernetes Secret named `wildcard-tls` into six namespaces: `aitk-console`, `dex`, `field-discovery`, `istio-system`, `kube-system`, `nango`.

- Issued by DigiCert Global G2 TLS RSA SHA256 2020 CA1
- Subject: `O=TTM Technologies, Inc., CN=*.ttmtech.com`
- Valid: Jan 28, 2026 → **Aug 30, 2026**

Renewal is a manual process of procuring a new certificate from DigiCert and redeploying it to each namespace.

Rancher itself serves TLS using RKE2's built-in `dynamiclistener` self-signed CA, valid until 2036. This is unrelated to the wildcard above.

### CNI

The cluster uses **Canal** (Calico networking + Flannel) as the CNI, installed automatically by RKE2 at `/var/lib/rancher/rke2/server/manifests/rke2-canal.yaml`. Canal supports NetworkPolicy enforcement cluster-wide.

---

## 4. RKE2 control plane

### Topology

Three stacked etcd + control-plane server nodes (`aamslc4kbc01–03`), each running etcd, kube-apiserver, kube-controller-manager, kube-scheduler, kube-proxy, and the RKE2 cloud-controller-manager. Quorum tolerance: one node loss.

Config file: `/etc/rancher/rke2/config.yaml` on each server node (managed by Vation).

Key configuration:

```yaml
token: <redacted>
tls-san:
  - api.kbai.ttmtech.local
  - master-0.kbai.ttmtech.local
  - master-1.kbai.ttmtech.local
  - master-2.kbai.ttmtech.local
node-taint:
  - "node-role.kubernetes.io/control-plane=true:NoSchedule"

# etcd backups (local)
etcd-snapshot-schedule-cron: "0 * * * *"
etcd-snapshot-retention: 100

# etcd backups (S3/MinIO) — currently failing
etcd-s3: true
etcd-s3-endpoint: "minio.kbai.ttmtech.local:9000"
etcd-s3-bucket: "rke2-etcd-backups"

# audit logging
kube-apiserver-arg:
  - "audit-policy-file=/etc/kubernetes/audit/policy.yaml"
  - "audit-log-path=/var/log/kubernetes/audit/audit.log"
  - "audit-log-maxage=7"
  - "audit-log-maxbackup=3"
  - "audit-log-maxsize=100"
```

### etcd

Three-node etcd, stacked (co-located with control-plane). Hourly snapshots to `/var/lib/rancher/rke2/server/db/snapshots/` with retention of 100 (~22 GB on disk at steady state).

S3 offsite snapshots are configured to ship to `minio.kbai.ttmtech.local:9000` in bucket `rke2-etcd-backups`, but the bucket has never been created. Snapshots have never succeeded offsite.

### Audit logging

Custom audit policy at `/etc/kubernetes/audit/policy.yaml`. The policy logs:
- Secrets, ConfigMaps, and RBAC changes at `RequestResponse` level
- Pod exec/attach/portforward at `RequestResponse` level
- Everything else at `Metadata` level
- Health checks and system-component reads are omitted

Logs rotate to `/var/log/kubernetes/audit/` with max 100MB per file, 3 backups, 7 days retention.

### Secrets encryption at rest

Enabled via `--encryption-provider-config=/var/lib/rancher/rke2/server/cred/encryption-config.json` with `--encryption-provider-config-automatic-reload=true`. Secrets in etcd are encrypted.

### Pod Security Admission

A PSA config file exists at `/etc/rancher/rke2/rke2-pss.yaml` but is configured with `defaults.enforce: "privileged"` — the most permissive level. No namespace-level enforce labels override this. Effectively, no pod-security enforcement is active cluster-wide.

### CIS profile

The RKE2 `profile: cis` flag is not set in `config.yaml`. As a result, several CIS controls that would be applied automatically are not in place: etcd does not run as a dedicated etcd user (no `etcd` host user exists on the nodes), system-namespace NetworkPolicies are not auto-applied, and file permissions on agent manifests are at default (644) rather than CIS-hardened (600).

---

## 5. Node storage layout

Every node has a dedicated LVM layout that isolates concerns onto separate logical volumes. This prevents one class of data from starving another.

### General workers (example: `aamslc4kbw01`)

| Mount | Size | Purpose |
|---|---|---|
| `/` | 10 GB | OS root |
| `/boot` | 1 GB | Boot files |
| `/boot/efi` | 200 MB | EFI system partition |
| `/home` | 10 GB | User home |
| `/tmp` | 10 GB | Temporary files |
| `/var` | 20 GB | System logs and state |
| `/var/log` | 20 GB | Logs |
| `/var/log/audit` | 20 GB | auditd logs |
| `/var/tmp` | 20 GB | Persistent temp |
| `/var/lib/kubelet` | 250 GB | kubelet working dir (pods, volumes, emptyDirs) |
| `/var/lib/rancher` | 150 GB | RKE2 agent data, containerd images |
| `/var/lib/docker` | 100 GB | Unused (RKE2 uses containerd); vestigial |
| `/var/lib/longhorn` | 2 TB | Longhorn replica data |
| `/mnt/nfs-backups` | 1 TB | NFS mount (unused) |

Volume groups: `rootvg` (OS), `docker_vg`, `kubelet_vg` (which also holds `longhorn_lv`), `rancher_vg`.

### GPU worker (`aamslc4kbg01`)

| Mount | Size | Notes |
|---|---|---|
| `/` | 10 GB | OS root |
| `/var` | 170 GB | Larger than worker equivalents |
| `/var/lib/kubelet` | 200 GB | |
| `/var/lib/rancher` | 200 GB | |
| `/var/lib/longhorn` | 1 TB | Used for both Longhorn replicas and manually-created `/var/lib/longhorn/models/*` directories holding LLM weights (not Longhorn-managed) |

Single volume group `gpu_vg` holds kubelet, rancher, and longhorn LVs.

---

## 6. NetworkPolicy model

Canal supports NetworkPolicy cluster-wide. Current coverage is minimal:

- **`sandbox` namespace** has a well-designed `default-deny-egress` policy plus ~115 per-sandbox `allow-egress-sandbox-<hash>` policies, created dynamically as sandboxes are provisioned. This is the reference pattern for the cluster.
- **`kafka` namespace** has operator-created NetworkPolicies generated by Strimzi (three auto-generated policies).
- **`rabbitmq-system`** has operator-created NetworkPolicies from the RabbitMQ cluster operator.
- **`cattle-fleet-system`** has a `default-allow-all` policy (opposite of a guardrail).
- **`kube-system`** has a `coredns-allow-all` policy for DNS traffic from the monitoring stack.
- **All other 54 namespaces** have zero NetworkPolicies. Default-allow applies.

**TBC:** what triggers creation/destruction of sandbox namespaces and their per-sandbox policies. Related: persistent `VolumeFailedDelete` events suggest sandbox cleanup is partially stuck.

---

## 7. Storage services

### Longhorn

Longhorn is installed in the `longhorn` namespace (not `longhorn-system` — the latter exists but is empty). It is the default StorageClass for the cluster.

Configuration:

| Setting | Value | Notes |
|---|---|---|
| default-replica-count | 3 | |
| replica-soft-anti-affinity | false | Strict anti-affinity — replicas must spread across nodes |
| replica-zone-soft-anti-affinity | true | |
| node-drain-policy | block-if-contains-last-replica | Prevents draining a node that hosts the only remaining replica |
| snapshot-data-integrity | fast-check | Weekly integrity checks enabled |
| backup-target | (empty) | ⚠ No backup destination configured |
| recurring jobs | none | ⚠ No scheduled backup or snapshot jobs |

Volume inventory at time of review: 143 Longhorn volumes total, 37 bound to PVCs. Of 143 volumes: 135 healthy, 4 degraded, 4 in unknown state.

PVCs by namespace:
- `sandbox` — 18
- `kindo-deps` — 13 (Postgres, RabbitMQ, Redis, MinIO)
- `qdrant` — 3
- `aitk-zuva` — 2 (both Zuva Postgres instances)
- `speaches` — 1 (model cache)

Longhorn UI is exposed at the in-cluster Service `longhorn/longhorn-frontend`. As of review completion, it was closed from external access.

### MinIO (in-cluster)

The `kindo-deps/minio-*` pods form the **main MinIO instance** for application use. Deployed via the MinIO operator in the `minio-operator` namespace, with a 4-pod tenant (`minio-pool-0-0` through `-3`). This MinIO handles:

- Kindo application object storage (file uploads, audit log archives, generated artifacts)
- Backups from the `kindo-deps/postgres` CNPG cluster (S3 barman destination)

Accessed via:
- `minio.kindo-deps.svc.cluster.local` (internal)
- `s3.kbai.ttmtech.com` (external S3 API)
- `minio-console.ttmtech.com` (external web console)

### MinIO (HAProxy VM)

A **separate** MinIO instance runs as a Docker container on `aamslc4hap01`. This is a single-instance, non-HA MinIO, intended as the etcd S3 backup destination per the RKE2 config. It has never been used because the required bucket has never been created.

The two MinIO deployments are not related and serve different purposes. This distinction is important during troubleshooting — "the MinIO" is ambiguous.

### NFS share

`aamslc4nfs01.ttmtech.local:/srv/nfs` is mounted on every worker at `/mnt/nfs-backups` with capacity 1 TB. Not referenced by any Kubernetes resource. Available as a DR destination for future etcd or Longhorn backup wiring.

---

## 8. Data services

### PostgreSQL (CloudNativePG)

Two independent CNPG clusters:

**`kindo-deps/postgres`**
- 3 instances (primary + 2 replicas, managed by CloudNativePG)
- Backup: barman-object-store → `s3://postgres-backups/cloudnative-pg/kindo-database` (in-cluster MinIO)
- ScheduledBackup every ~3 minutes
- This is the canonical reference implementation for stateful HA in the cluster

**`aitk-zuva/zuva-postgres`**
- 2 instances
- No backup configured (`backup=NONE`)
- Uses Longhorn PVCs for storage (50 GB each)

Also present but separately managed:
- `aitk-zuva/pgbouncer-extract` — PgBouncer pooler in front of Zuva Postgres

### Redis

Deployed in `kindo-deps` using the Redis operator:
- Three Redis replicas (`redis-0`, `redis-1`, `redis-2`)
- Three Redis Sentinel nodes for failover orchestration
- Multiple services exposed: `redis`, `redis-master`, `redis-replica`, `redis-headless`, `redis-sentinel-sentinel`, etc.

This is proper Redis HA with Sentinel-driven failover.

### RabbitMQ

Three-node RabbitMQ cluster in `kindo-deps`, deployed via the RabbitMQ Cluster Operator (operator itself in `rabbitmq-system`).

Used by:
- Kindo's `api` service (`RABBITMQ_URL` env var)
- Kindo's `external-sync-files` (`RABBITMQ_CONTENT_PROCESSING_QUEUE` env var)
- Other Kindo services for async messaging

### Kafka (Strimzi)

Three-node Kafka cluster in `kafka` namespace, deployed via the Strimzi operator (operator in same namespace):
- Three brokers (`aitk-kafka-cluster-kafka-0/1/2`)
- Three ZooKeeper nodes (`aitk-kafka-cluster-zookeeper-0/1/2`)
- Entity operator for topic/user management

Replication config is correct for HA: `replication.factor=3`, `min.insync.replicas=2`.

**However, storage is `type: ephemeral`** — broker data lives in pod-local `emptyDir` and does not survive pod restart. A cluster-wide restart (all three brokers restarting near-simultaneously) would result in total topic data loss.

Kafka is used by the Zuva pipeline (`aitk-extract-*`, `aitk-ocr-*`, `aitk-mlc-*`, `aitk-usage-*`, `aitk-sfs-*` listeners).

### Qdrant

Three-replica Qdrant deployment in the `qdrant` namespace, used as a vector database for Kindo's semantic search / RAG features. Longhorn-backed PVCs.

---

## 9. Identity and authentication

### Human user authentication

The path from "TTM user wants to log into Kindo" runs through several components:

1. **Active Directory** — source of truth for TTM user identities
2. **ADFS** — SAML identity provider fronting AD
3. **Rancher** — identity provider for cluster administrative access (Rancher UI, kubeconfig generation)
4. **Dex** — OIDC provider used by Kindo applications
5. **SSOReady** — the `ssoready` namespace runs four services (admin, api, app, auth) providing SSO-as-a-service for Kindo

**TBC:** the exact sequencing and which components authenticate which user flows. This should be confirmed with Vation during KT.

Two Rancher cluster-role bindings grant `cluster-admin`:
- `globaladmin-u-tkgqh2nzao` → group `activedirectory_group://CN=AAMHIL-SG-Rancher-AI_Access,...` (direct AD)
- `globaladmin-u-qramgckz4l` → group `adfs_group://TTMTECH\AAMHIL-SG-Rancher-AI_Access` (ADFS)

All members of the `AAMHIL-SG-Rancher-AI_Access` group have full cluster-admin via both bindings. Five individual users also have direct cluster-admin role bindings.

### Ingress-level authentication (oauth2-proxy)

Two namespaces front their ingresses with `oauth2-proxy` for authentication:
- `aitk-console/console-app-ingress` → `oauth2-proxy.aitk-console.svc.cluster.local:4180`
- `field-discovery/fields-app-ingress` → `oauth2-proxy.field-discovery.svc.cluster.local:4180`

Other customer-facing ingresses (notably `api/api-main`, `next/next`, and `pgweb/kindo-pgweb`) do not use oauth2-proxy.

### Authorization (Cerbos)

Kindo's `api` service calls Cerbos (`cerbos.cerbos.svc.cluster.local`) for authorization decisions on user actions. Cerbos is stateless, policy-driven, and runs as a single replica (vendor supports horizontal scaling).

---

## 10. Observability

### Metrics (Prometheus)

Rancher-deployed monitoring stack in `cattle-monitoring-system`:

| Component | Replicas | Notes |
|---|---|---|
| Prometheus | 1 | 10-day retention, no remote_write, no persistent storage resize config |
| Alertmanager | 1 | Receiver is `null` — no notifications go anywhere |
| Grafana | 1 | |
| prometheus-adapter | 1 | HPA metric source |
| kube-state-metrics | 1 | |
| node-exporter | DaemonSet (9 pods) | One per node |
| Operator | 1 | |

30 `PrometheusRule` alert rules are defined across the cluster, but with `receiver: "null"` none produce notifications.

### Logs

`fluent-bit` DaemonSet in `logging` namespace (9 pods, one per node) ships container logs.

**TBC:** destination of shipped logs. Possibilities include an external ELK/OpenSearch cluster, Loki, or a SIEM. To be confirmed during KT.

### Audit logs

Two separate audit streams:

1. **Kubernetes audit logs** — written to `/var/log/kubernetes/audit/audit.log` on control-plane nodes (file-based; see section 4).
2. **Kindo application audit logs** — handled by the `audit-log-exporter` service in the `audit-log-exporter` namespace. Kindo-built image (`registry.kindo.ai/kindo-docker/audit-log-exporter`). The destination is configured in the `audit-log-exporter-env` Secret. **TBC:** specific destination and protocol (env vars suggest a syslog target per Kindo's documented deployment pattern, but the running config has not been confirmed).

### Tracing

OpenTelemetry is configured across Kindo services (`OTEL_EXPORTER_OTLP_ENDPOINT`, `OTEL_SERVICE_NAME`, etc. present in env). **TBC:** the OTLP collector destination.

### GPU metrics

`nvidia-dcgm-exporter` runs in the `gpu-operator` namespace on GPU nodes, exposing Prometheus metrics on port 9400.

---

## 11. Kindo application layer

Kindo is deployed across approximately 10 namespaces, plus the Zuva/AITK product (separate subsection below).

### Core Kindo services

| Service | Namespace | Purpose | Notes |
|---|---|---|---|
| `api` | api | Main backend API for Kindo | Node.js, single replica today, Kindo docs specify `minReplicas: 3` |
| `next` | next | Kindo web frontend (Next.js) | Single replica today |
| `litellm` | litellm | LLM proxy / gateway | Routes to self-hosted models and external providers. Config in `litellm-config` ConfigMap and `LITELLM_API_KEY_*` secrets. |
| `credits` | credits | Credits / usage tracking service | |
| `hatchet-api`, `hatchet-engine`, `hatchet-frontend` | hatchet | Workflow orchestration engine | Used for async task orchestration |
| `cerbos` | cerbos | Authorization policy engine | |
| `ssoready` (admin/api/app/auth) | ssoready | SSO-as-a-service | Fronts AD/ADFS for Kindo application login |
| `dex` | dex | OIDC identity provider | |
| `nango`, `nango-connect-ui` | nango | Integrations hub for external APIs | **TBC:** which specific integrations are enabled |
| `mcp-unified`, `mcp-sentinelone` | mcp | MCP (Model Context Protocol) servers. `mcp-unified` aggregates multiple tool integrations; `mcp-sentinelone` provides SentinelOne-specific tools for agents. | **TBC:** full list of tools exposed by each |
| `pgweb` | pgweb | PostgreSQL web admin console | ⚠ Exposed on HTTP without authentication |
| `presidio-analyzer`, `presidio-anonymizer` | presidio | PII detection and redaction | |
| `unleash`, `unleash-edge` | unleash | Feature flag service | 2 replicas of `unleash`, 1 of `unleash-edge` |
| `speaches` | speaches | **TBC** — likely text-to-speech (Kindo bundled service) |
| `text-embeddings` | text-embeddings | Text embedding model serving | Backs Kindo RAG features |

### Background workers

| Service | Type | Schedule / purpose |
|---|---|---|
| `external-poller` | CronJob | Runs every 3 hours (`0 0,3,6,9,12,15,18,21 * * *`). Polls external integrations (via Nango) for updates. |
| `external-sync-files`, `external-sync-files-priority` | Deployment | RabbitMQ consumers that process content changes detected by `external-poller`. Env var `RABBITMQ_CONTENT_PROCESSING_QUEUE` confirms queue binding. |
| `task-worker-ts`, `task-worker-ts-large` | Deployment | TypeScript worker pool, 2 replicas each. `WORKER_TYPE` env var differentiates workload. **TBC:** exact task types handled. |
| `audit-log-exporter` | Deployment | Ships Kindo application audit events to an external logging destination. **TBC:** destination and protocol. |
| `field-repo-indexer-ats` | CronJob | Ran most recently 10m before review snapshot. **TBC:** purpose. |
| `prisma-migrations` | Job | Database schema migration job. |

### AITK / Zuva product

The `aitk-zuva` namespace hosts Zuva — a commercial document field-extraction product that TTM has integrated into Kindo. Zuva is used to extract fields from legal and commercial documents (contracts, credit agreements, leases, etc.) — the names of `field-loader-*` jobs indicate the categories of documents Zuva has models for.

The Zuva pipeline is composed of approximately 40 deployments handling different phases. Based on deployment naming:

- **Extract API path** (`aitk-extract-api-deployment`, 2 replicas) — user-facing extraction requests
- **Extract workers** (`aitk-extract-worker-deployment`, 3 replicas; `aitk-extract-overflow-deployment`, 3 replicas target) — do the actual field extraction
- **Extract listeners** (`aitk-extract-fields-listener-deployment`, `aitk-extract-ocr-status-listener-deployment`, etc.) — Kafka consumers reacting to pipeline state changes
- **OCR path** (`aitk-ocr-api-deployment`, `aitk-ocr-controller-deployment`, `aitk-ocr-dc-job-orchestrator-*`, listeners) — OCR processing of uploaded documents
- **MLC path** (`aitk-mlc-api-deployment`, `aitk-mlc-worker-deployment`, listeners) — machine learning classification. **TBC:** exact function of "MLC".
- **SFS path** (`aitk-sfs-api-deployment`, listeners) — **TBC:** exact function of "SFS".
- **Files service** (`aitk-files-deployment`, 5 replicas) — file storage management
- **Normalization** (`aitk-normalization`) — post-processing of extracted fields
- **Usage listeners** (`aitk-usage-*-listener-deployment`, 1 replica each) — billing/usage event consumers
- **Field loaders** (`field-loader-*`, one-off Jobs) — load pre-trained Zuva models for different document categories. ~60+ categories observed.

Zuva uses:
- `zuva-postgres` (2-instance CNPG cluster) for application state
- `pgbouncer-extract` as connection pooler
- Kafka for inter-component messaging
- Redis caches (separate from kindo-deps Redis): `aitk-extract-redis`, `aitk-mlc-redis`, `aitk-extract-status-redis`
- Istio gateway (`istio-ingressgateway`) as ingress (this is the only namespace using Istio, see Section 12)

**TBC:** end-to-end document flow, Kafka topic topology, which services produce and which consume each topic. Recommend this section be fleshed out during KT with Vation, who provisioned the Zuva integration.

---

## 12. Inference layer

The cluster hosts self-hosted LLM inference via vLLM on a single GPU node with 8× NVIDIA H200-NVL.

### GPU node configuration

- vSphere VM: `aamslc4kbg01`
- NVIDIA driver: 580.105.08
- CUDA runtime: 13.0
- MIG strategy: `mixed`
- Current MIG config label: `nvidia.com/mig.config=custom-gpu4-deephat-bge`
- MIG config state: `failed` (since April 5, 2026) — the config references a profile not present in `default-mig-parted-config` ConfigMap
- Allocatable at review time: 7× `nvidia.com/gpu`, 1× `nvidia.com/mig-3g.71gb`, 1× `nvidia.com/mig-4g.71gb`

NVIDIA GPU Operator is deployed in `gpu-operator` namespace with all the standard components: device-plugin, dcgm-exporter, container-toolkit, mig-manager, cuda-validator, node-feature-discovery.

### Models deployed

Each model is its own namespace, its own Deployment, and mounts model weights from `/var/lib/longhorn/<model>-cache` via `hostPath` (not a Longhorn PVC despite the naming — these are plain directories on the GPU node's local disk).

| Model | Namespace | GPU allocation | Priority class | Size on disk |
|---|---|---|---|---|
| llama-4-maverick | llama-4-maverick-inference | Multi-GPU | inference-critical | 399 GB |
| deephat-v2-2h100 | deephat-v2-hf-inference | 2 GPUs (H100 profile) | inference-critical | 57 GB |
| gemma-4-31b-it | gemma4-31b-inference | | (none) | 59 GB |
| codestral-22b | codestral-inference | | (none) | 42 GB |
| devstral-small-2 | devstral-small-2-inference | | (none) | 25 GB |
| text-embeddings | text-embeddings | MIG slice | inference-critical | |

Also present but scaled to 0: `deephat-v2-b200` (likely awaiting B200 hardware). **TBC.**

### Inference routing

Kindo's `api` service routes LLM calls through LiteLLM (`LITELLM_URL` env var). LiteLLM's routing config and model list **TBC** — likely in a Secret.

External model providers (Anthropic, OpenAI, etc.) are also reachable through LiteLLM. **TBC:** specific external providers configured.

### Priority classes

| Class | Value | Usage |
|---|---|---|
| system-node-critical | 2000001000 | Kubernetes default |
| system-cluster-critical | 2000000000 | Kubernetes default |
| longhorn-critical | 1000000000 | Longhorn components |
| inference-critical | 500000000 | High-priority inference workloads (Llama, DeepHat, text-embeddings) |
| sandbox-high | 1000000 | Sandbox workloads (user-initiated) |
| sandbox-warmer | 100 | Pre-warmed sandboxes (Never preempt) |

---

## 13. Known constraints and open questions

### Accepted architectural constraints

- **Single GPU node.** Frontier models (Llama-4-Maverick, DeepHat-v2) require the full 8-GPU NVLink fabric on one VM for tensor-parallel execution. Splitting across nodes breaks the workload. Additional GPU hardware is in procurement to expand capacity.
- **On-prem vSphere.** No cloud-managed services. No availability zones — anti-affinity relies on vSphere DRS at the host level.
- **Pre-production status.** No formal SLA, no on-call rotation. This is expected to change as adoption grows.

### Open questions (TBC during Vation KT)

These should be captured in a separate tracker during knowledge transfer:

1. Does Vation have IaC (Terraform, Ansible) for the cluster? Where does it live? What's the process to propose changes through it?
2. Which vSphere hosts are the 11 VMs placed on? Are anti-affinity rules in place?
3. What's the destination of the `fluent-bit` log shipper?
4. What's the destination of the `audit-log-exporter` audit stream? What protocol?
5. What's the OpenTelemetry OTLP collector destination?
6. What external integrations are configured in Nango?
7. Full list of MCP tools exposed by `mcp-unified` and `mcp-sentinelone`?
8. What task types does `task-worker-ts` handle? Is it a Hatchet worker pool or something else?
9. What's the `field-repo-indexer-ats` CronJob doing?
10. What does `speaches` do exactly? (Name suggests text-to-speech, to be confirmed.)
11. Full end-to-end Zuva document processing flow — which service receives documents, which Kafka topics carry what, where do extracted fields land?
12. What's "MLC" and "SFS" in the Zuva pipeline?
13. LiteLLM full routing config — which models, which external providers, any fallbacks?
14. Which models are "production" (actively used) vs. "evaluation" in the inference layer?
15. Is `deephat-v2-b200` awaiting B200 hardware or deprecated?
16. Rancher admin password — where is it stored, who has access, has it been rotated since install?
17. HAProxy VM — who has sudo on it? Is the haproxy.cfg under version control anywhere?
18. MinIO root credentials (on both HAProxy VM and in-cluster tenant) — where are they stored, how are they rotated?
19. DigiCert wildcard certificate — who holds the renewal relationship with DigiCert? Renewal process before Aug 30, 2026?
20. Is there any cross-cluster relationship with the Hillsborough cluster? Shared IAM, shared registry, shared Flux source-of-truth?

### Known issues documented in the review (for reference)

See the review document dated April 22, 2026 for the full findings list. Summary:

- Management plane (HAProxy, Rancher, MinIO) on single VMs — no redundancy
- `pgweb` SQL console exposed on HTTP with no auth
- Pod Security Admission set to `privileged`
- Longhorn has no backup target configured
- Zuva Postgres has no backup configured
- Alertmanager receiver is `null` — no notifications routed
- cert-manager has no Issuer configured; TLS served by manual wildcard cert expiring Aug 30, 2026
- Kafka on ephemeral storage — cluster-wide restart would lose topic data
- Model weights stored as hostPath, not Longhorn PVCs (no replication)
- External Secrets operator deployed at 0 replicas — partial implementation
- No GitOps pipeline deployed (Flux exists on Hillsborough cluster, could be extended here)
- Worker version drift (v1.34.4 vs v1.34.5)
- NetworkPolicy coverage limited to one namespace

---

*End of architecture reference. This document will need updates after Vation knowledge transfer — the TBCs in Section 13 are the expected starting agenda for those sessions.*
