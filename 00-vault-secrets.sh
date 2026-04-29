[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# 
[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# cat 02-control-plane.txt 
================================================
  Control plane configuration and etcd
  Generated: Wed Apr 29 06:14:00 AM PDT 2026
================================================

==== RKE2 config.yaml (server node only; check on each control plane) ====
$ cat /etc/rancher/rke2/config.yaml 2>/dev/null || echo 'not on a server node'
#######################
# First Control Plane #
#######################

token: "<redacted>"
tls-san:
  - api.kbai.viasystems.pri
  - master-0.kbai.viasystems.pri
  - master-1.kbai.viasystems.pri
  - master-2.kbai.viasystems.pri
node-taint:
  - "node-role.kubernetes.io/control-plane=true:NoSchedule"

# etcd backups (local)
etcd-snapshot-schedule-cron: "0 * * * *"
etcd-snapshot-retention: 100

# etcd backups to S3/MinIO (optional)
etcd-s3: true
etcd-s3-endpoint: "minio.kbai.viasystems.pri:9000"
etcd-s3-bucket: "rke2-etcd-backups"
etcd-s3-access-key: "ttmtech"
etcd-s3-secret-key: "<redacted>"
etcd-s3-region: "us-east-1"
etcd-s3-folder: "rke2-etcd-backups"
etcd-s3-insecure: true
etcd-s3-skip-ssl-verify: true

kube-apiserver-arg:
  - "audit-policy-file=/etc/kubernetes/audit/policy.yaml"
  - "audit-log-path=/var/log/kubernetes/audit/audit.log"
  - "audit-log-maxage=7"
  - "audit-log-maxbackup=3"
  - "audit-log-maxsize=100"

==== RKE2 server systemd status ====
$ systemctl status rke2-server 2>/dev/null | head -30 || echo 'not a server node'
● rke2-server.service - Rancher Kubernetes Engine v2 (server)
     Loaded: loaded (/usr/lib/systemd/system/rke2-server.service; enabled; preset: disabled)
     Active: active (running) since Wed 2026-02-25 08:07:44 PST; 2 months 2 days ago
       Docs: https://github.com/rancher/rke2#readme
    Process: 1568 ExecStartPre=/sbin/modprobe br_netfilter (code=exited, status=0/SUCCESS)
    Process: 1584 ExecStartPre=/sbin/modprobe overlay (code=exited, status=0/SUCCESS)
   Main PID: 1594 (rke2)
      Tasks: 230
     Memory: 10.7G (peak: 17.0G)
        CPU: 2d 14h 46min 38.582s
     CGroup: /system.slice/rke2-server.service
             ├─1594 "/usr/bin/rke2 server"
             ├─1958 containerd -c /var/lib/rancher/rke2/agent/etc/containerd/config.toml
             ├─2057 kubelet --volume-plugin-dir=/var/lib/kubelet/volumeplugins --file-check-frequency=5s --sync-frequency=30s --cloud-provider=external --config-dir=/var/lib/rancher/rke2/agent/etc/kubelet.conf.d --containerd=/run/k3s/containerd/containerd.sock --hostname-override=camslc4kbc01.viasystems.pri --kubeconfig=/var/lib/rancher/rke2/agent/kubelet.kubeconfig --node-ip=10.201.248.21 --node-labels= --read-only-port=0
             ├─2173 /var/lib/rancher/rke2/data/v1.34.4-rke2r1-0d52262ea640/bin/containerd-shim-runc-v2 -namespace k8s.io -id 85cb04aa20f62b0f083a4936db37c1078eb556b1c76fcb6d91f2d40ab96ab6ac -address /run/k3s/containerd/containerd.sock
             ├─2244 /var/lib/rancher/rke2/data/v1.34.4-rke2r1-0d52262ea640/bin/containerd-shim-runc-v2 -namespace k8s.io -id 80b562e72f0e62eb12547c894a173e5fca2e63f555f49f9512767244074df73b -address /run/k3s/containerd/containerd.sock
             ├─2308 /var/lib/rancher/rke2/data/v1.34.4-rke2r1-0d52262ea640/bin/containerd-shim-runc-v2 -namespace k8s.io -id 7db1a1b3d238445e27599415fd3a64c717023935235f716b2179859fdd317c89 -address /run/k3s/containerd/containerd.sock
             ├─5355 /var/lib/rancher/rke2/data/v1.34.4-rke2r1-0d52262ea640/bin/containerd-shim-runc-v2 -namespace k8s.io -id adf85c673a753044a3357938b490af0b046cb1f53a9246f92df18d41682817d0 -address /run/k3s/containerd/containerd.sock
             ├─6115 /var/lib/rancher/rke2/data/v1.34.4-rke2r1-0d52262ea640/bin/containerd-shim-runc-v2 -namespace k8s.io -id 0aa795e427b4a7720e550554da9e3c6ad603b33b3f177dcddfe10ca02d64aba2 -address /run/k3s/containerd/containerd.sock
             ├─6721 /var/lib/rancher/rke2/data/v1.34.4-rke2r1-0d52262ea640/bin/containerd-shim-runc-v2 -namespace k8s.io -id 23ed8eb31b7b42f0b9d10a3eb846509f3aa5d776b0f72a2909a6f97eaa0e6804 -address /run/k3s/containerd/containerd.sock
             ├─6836 /var/lib/rancher/rke2/data/v1.34.4-rke2r1-0d52262ea640/bin/containerd-shim-runc-v2 -namespace k8s.io -id 915c87c7ed707803682fcb57501867365b60f14e6a4ad8c8a7ce1430d5aa3ed4 -address /run/k3s/containerd/containerd.sock
             ├─7688 /var/lib/rancher/rke2/data/v1.34.4-rke2r1-0d52262ea640/bin/containerd-shim-runc-v2 -namespace k8s.io -id 42cbd01e8ab5102ad510cc7d2d63b2bc80b4c68b991b31ebe219c87d5783339a -address /run/k3s/containerd/containerd.sock
             └─7984 /var/lib/rancher/rke2/data/v1.34.4-rke2r1-0d52262ea640/bin/containerd-shim-runc-v2 -namespace k8s.io -id 2b25e6ac80f593dbf01d4e7c9c1529a9ef1736ecd9d63ac78f231b4deedab705 -address /run/k3s/containerd/containerd.sock

Apr 29 06:00:09 camslc4kbc01.viasystems.pri rke2[1594]: time="2026-04-29T06:00:09-07:00" level=info msg="Reusing cached S3 client for endpoint=\"http://minio.kbai.viasystems.pri:9000\" bucket=\"rke2-etcd-backups\" folder=\"rke2-etcd-backups\""
Apr 29 06:00:09 camslc4kbc01.viasystems.pri rke2[1594]: time="2026-04-29T06:00:09-07:00" level=info msg="Deleting ETCDSnapshotFile for etcd-snapshot-camslc4kbc01.viasystems.pri-1777107602"
Apr 29 06:00:09 camslc4kbc01.viasystems.pri rke2[1594]: time="2026-04-29T06:00:09-07:00" level=info msg="Deleting ETCDSnapshotFile for etcd-snapshot-camslc4kbc03.viasystems.pri-1777460405"
Apr 29 06:00:09 camslc4kbc01.viasystems.pri rke2[1594]: time="2026-04-29T06:00:09-07:00" level=info msg="Reconciliation of ETCDSnapshotFile resources complete"
Apr 29 06:01:15 camslc4kbc01.viasystems.pri rke2[1594]: time="2026-04-29T06:01:15-07:00" level=info msg="Reconciling ETCDSnapshotFile resources"
Apr 29 06:01:15 camslc4kbc01.viasystems.pri rke2[1594]: time="2026-04-29T06:01:15-07:00" level=info msg="Reusing cached S3 client for endpoint=\"http://minio.kbai.viasystems.pri:9000\" bucket=\"rke2-etcd-backups\" folder=\"rke2-etcd-backups\""

==== Static pod manifests directory ====
$ ls -la /var/lib/rancher/rke2/agent/pod-manifests/ 2>/dev/null
total 40
drwx------ 2 root root  173 Feb 25 08:07 .
drwxr-x--- 7 root root 4096 Feb 25 08:07 ..
-rw-r--r-- 1 root root 3727 Feb 25 08:07 cloud-controller-manager.yaml
-rw-r--r-- 1 root root 3125 Feb 24 05:23 etcd.yaml
-rw-r--r-- 1 root root 9992 Feb 25 08:07 kube-apiserver.yaml
-rw-r--r-- 1 root root 6547 Feb 25 08:07 kube-controller-manager.yaml
-rw-r--r-- 1 root root 2343 Feb 25 08:04 kube-proxy.yaml
-rw-r--r-- 1 root root 3724 Feb 24 05:24 kube-scheduler.yaml

==== Auto-deployed manifests ====
$ ls /var/lib/rancher/rke2/server/manifests/ 2>/dev/null
rke2-canal.yaml
rke2-coredns.yaml
rke2-ingress-nginx.yaml
rke2-metrics-server.yaml
rke2-runtimeclasses.yaml
rke2-snapshot-controller-crd.yaml
rke2-snapshot-controller.yaml
rke2-snapshot-validation-webhook.yaml

==== etcd snapshot directory contents ====
$ ls -lh /var/lib/rancher/rke2/server/db/snapshots/ 2>/dev/null | tail -10
-rw------- 1 root root 1.4G Apr 28 21:00 etcd-snapshot-camslc4kbc01.viasystems.pri-1777435203
-rw------- 1 root root 1.4G Apr 28 22:00 etcd-snapshot-camslc4kbc01.viasystems.pri-1777438802
-rw------- 1 root root 1.4G Apr 28 23:00 etcd-snapshot-camslc4kbc01.viasystems.pri-1777442402
-rw------- 1 root root 1.4G Apr 29 00:00 etcd-snapshot-camslc4kbc01.viasystems.pri-1777446005
-rw------- 1 root root 1.4G Apr 29 01:00 etcd-snapshot-camslc4kbc01.viasystems.pri-1777449604
-rw------- 1 root root 1.4G Apr 29 02:00 etcd-snapshot-camslc4kbc01.viasystems.pri-1777453201
-rw------- 1 root root 1.4G Apr 29 03:00 etcd-snapshot-camslc4kbc01.viasystems.pri-1777456804
-rw------- 1 root root 1.4G Apr 29 04:00 etcd-snapshot-camslc4kbc01.viasystems.pri-1777460403
-rw------- 1 root root 1.4G Apr 29 05:00 etcd-snapshot-camslc4kbc01.viasystems.pri-1777464001
-rw------- 1 root root 1.4G Apr 29 06:00 etcd-snapshot-camslc4kbc01.viasystems.pri-1777467604

==== etcd snapshot count ====
$ ls /var/lib/rancher/rke2/server/db/snapshots/ 2>/dev/null | wc -l
100

==== Recent rke2-server log errors (last 24h) ====
$ journalctl -u rke2-server --since '24 hours ago' 2>/dev/null | grep -iE 'error|fail|warning' | tail -30

==== etcd pod status ====
$ kubectl -n kube-system get pods -l component=etcd -o wide
NAME                               READY   STATUS    RESTARTS   AGE   IP              NODE                          NOMINATED NODE   READINESS GATES
etcd-camslc4kbc01.viasystems.pri   1/1     Running   2          63d   10.201.248.21   camslc4kbc01.viasystems.pri   <none>           <none>
etcd-camslc4kbc02.viasystems.pri   1/1     Running   2          63d   10.201.248.22   camslc4kbc02.viasystems.pri   <none>           <none>
etcd-camslc4kbc03.viasystems.pri   1/1     Running   3          63d   10.201.248.23   camslc4kbc03.viasystems.pri   <none>           <none>

==== kube-apiserver running args (encryption, audit, etc.) ====
$ ps auxww 2>/dev/null | grep kube-apiserver | grep -oE -- '--[a-z-]+(=[^ ]+)?' | sort
--admission-control-config-file=/etc/rancher/rke2/rke2-pss.yaml
--allocate-node-cidrs=true
--allow-privileged=true
--anonymous-auth=false
--api-audiences=https://kubernetes.default.svc.cluster.local,rke2
--audit-log-maxage=7
--audit-log-maxbackup=3
--audit-log-maxsize=100
--audit-log-path=/var/log/kubernetes/audit/audit.log
--audit-policy-file=/etc/kubernetes/audit/policy.yaml
--authentication-kubeconfig=/var/lib/rancher/rke2/server/cred/controller.kubeconfig
--authorization-kubeconfig=/var/lib/rancher/rke2/server/cred/controller.kubeconfig
--authorization-mode=Node,RBAC
--bind-address=0.0.0.0
--bind-address=127.0.0.1
--cert-dir=/var/lib/rancher/rke2/server/tls/temporary-certs
--client-ca-file=/var/lib/rancher/rke2/server/tls/client-ca.crt
--cluster-cidr=10.42.0.0/16
--cluster-signing-kube-apiserver-client-cert-file=/var/lib/rancher/rke2/server/tls/client-ca.nochain.crt
--cluster-signing-kube-apiserver-client-key-file=/var/lib/rancher/rke2/server/tls/client-ca.key
--cluster-signing-kubelet-client-cert-file=/var/lib/rancher/rke2/server/tls/client-ca.nochain.crt
--cluster-signing-kubelet-client-key-file=/var/lib/rancher/rke2/server/tls/client-ca.key
--cluster-signing-kubelet-serving-cert-file=/var/lib/rancher/rke2/server/tls/server-ca.nochain.crt
--cluster-signing-kubelet-serving-key-file=/var/lib/rancher/rke2/server/tls/server-ca.key
--cluster-signing-legacy-unknown-cert-file=/var/lib/rancher/rke2/server/tls/server-ca.nochain.crt
--cluster-signing-legacy-unknown-key-file=/var/lib/rancher/rke2/server/tls/server-ca.key
--configure-cloud-routes=false
--controllers=*,tokencleaner,-service,-route,-cloud-node-lifecycle
--egress-selector-config-file=/var/lib/rancher/rke2/server/etc/egress-selector-config.yaml
--enable-admission-plugins=NodeRestriction
--enable-aggregator-routing=true
--enable-bootstrap-token-auth=true
--encryption-provider-config-automatic-reload=true
--encryption-provider-config=/var/lib/rancher/rke2/server/cred/encryption-config.json
--etcd-cafile=/var/lib/rancher/rke2/server/tls/etcd/server-ca.crt
--etcd-certfile=/var/lib/rancher/rke2/server/tls/etcd/client.crt
--etcd-keyfile=/var/lib/rancher/rke2/server/tls/etcd/client.key
--etcd-servers=https://127.0.0.1:2379
--flex-volume-plugin-dir=/var/lib/kubelet/volumeplugins
--kubeconfig=/var/lib/rancher/rke2/server/cred/controller.kubeconfig
--kubelet-certificate-authority=/var/lib/rancher/rke2/server/tls/server-ca.crt
--kubelet-client-certificate=/var/lib/rancher/rke2/server/tls/client-kube-apiserver.crt
--kubelet-client-key=/var/lib/rancher/rke2/server/tls/client-kube-apiserver.key
--kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
--permit-port-sharing=true
--profiling=false
--profiling=false
--proxy-client-cert-file=/var/lib/rancher/rke2/server/tls/client-auth-proxy.crt
--proxy-client-key-file=/var/lib/rancher/rke2/server/tls/client-auth-proxy.key
--requestheader-allowed-names=system:auth-proxy
--requestheader-client-ca-file=/var/lib/rancher/rke2/server/tls/request-header-ca.crt
--requestheader-extra-headers-prefix=X-Remote-Extra-
--requestheader-group-headers=X-Remote-Group
--requestheader-username-headers=X-Remote-User
--root-ca-file=/var/lib/rancher/rke2/server/tls/server-ca.crt
--secure-port=10257
--secure-port=6443
--service-account-issuer=https://kubernetes.default.svc.cluster.local
--service-account-key-file=/var/lib/rancher/rke2/server/tls/service.key
--service-account-private-key-file=/var/lib/rancher/rke2/server/tls/service.current.key
--service-account-signing-key-file=/var/lib/rancher/rke2/server/tls/service.current.key
--service-cluster-ip-range=10.43.0.0/16
--service-cluster-ip-range=10.43.0.0/16
--service-node-port-range=30000-32767
--storage-backend=etcd3
--terminated-pod-gc-threshold=1000
--tls-cert-file=/var/lib/rancher/rke2/server/tls/kube-controller-manager/kube-controller-manager.crt
--tls-cert-file=/var/lib/rancher/rke2/server/tls/serving-kube-apiserver.crt
--tls-cipher-suites=TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305
--tls-private-key-file=/var/lib/rancher/rke2/server/tls/kube-controller-manager/kube-controller-manager.key
--tls-private-key-file=/var/lib/rancher/rke2/server/tls/serving-kube-apiserver.key
--use-service-account-credentials=true

==== Audit policy file ====
$ cat /etc/kubernetes/audit/policy.yaml 2>/dev/null
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
  # Don't log read-only health checks
  - level: None
    nonResourceURLs:
      - /healthz*
      - /version
      - /readyz
      - /livez

  # Don't log system components checking status
  - level: None
    users:
      - system:kube-proxy
      - system:kube-scheduler
      - system:kube-controller-manager
    verbs: [get, list, watch]

  # Log secrets/configmaps/RBAC at RequestResponse
  - level: RequestResponse
    resources:
      - group: ""
        resources: [secrets, configmaps]
      - group: "rbac.authorization.k8s.io"
        resources: [clusterroles, clusterrolebindings, roles, rolebindings]

  # Log pod exec/attach/portforward
  - level: RequestResponse
    resources:
      - group: ""
        resources: [pods/exec, pods/attach, pods/portforward]

  # Everything else at Metadata level
  - level: Metadata
    omitStages:
      - RequestReceived

==== Audit log directory ====
$ ls -lh /var/log/kubernetes/audit/ 2>/dev/null
total 364M
-rw------- 1 root root 100M Apr 29 04:56 audit-2026-04-29T11-56-29.607.log
-rw------- 1 root root 100M Apr 29 05:28 audit-2026-04-29T12-28-13.223.log
-rw------- 1 root root 100M Apr 29 06:00 audit-2026-04-29T13-00-07.177.log
-rw------- 1 root root  43M Apr 29 06:14 audit.log

[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# 


[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# cat 04-security.txt 
================================================
  Security posture
  Generated: Wed Apr 29 06:14:01 AM PDT 2026
================================================

==== RKE2 CIS profile flag ====
$ grep -i '^profile:' /etc/rancher/rke2/config.yaml 2>/dev/null || echo 'not on a server node or profile not set'
not on a server node or profile not set

==== PSA admission config file ====
$ ls /etc/rancher/rke2/rke2-pss.yaml 2>/dev/null && cat /etc/rancher/rke2/rke2-pss.yaml 2>/dev/null
/etc/rancher/rke2/rke2-pss.yaml
apiVersion: apiserver.config.k8s.io/v1
kind: AdmissionConfiguration
plugins:
- name: PodSecurity
  configuration:
    apiVersion: pod-security.admission.config.k8s.io/v1beta1
    kind: PodSecurityConfiguration
    defaults:
      enforce: "privileged"
      enforce-version: "latest"
    exemptions:
      usernames: []
      runtimeClasses: []
      namespaces: []
==== PSA enforce labels per namespace ====
$ kubectl get ns -o json | jq -r '.items[] | "\(.metadata.name)\tenforce=\(.metadata.labels["pod-security.kubernetes.io/enforce"] // "NONE")\tversion=\(.metadata.labels["pod-security.kubernetes.io/enforce-version"] // "-")"' | column -t
aitk                         enforce=NONE  version=-
api                          enforce=NONE  version=-
audit-log-exporter           enforce=NONE  version=-
cattle-dashboards            enforce=NONE  version=-
cattle-fleet-system          enforce=NONE  version=-
cattle-impersonation-system  enforce=NONE  version=-
cattle-local-user-passwords  enforce=NONE  version=-
cattle-monitoring-system     enforce=NONE  version=-
cattle-system                enforce=NONE  version=-
cerbos                       enforce=NONE  version=-
cert-manager                 enforce=NONE  version=-
cnpg-system                  enforce=NONE  version=-
credits                      enforce=NONE  version=-
deephat-v2-hf-inference      enforce=NONE  version=-
default                      enforce=NONE  version=-
embeddings                   enforce=NONE  version=-
external-poller              enforce=NONE  version=-
external-secrets             enforce=NONE  version=-
external-sync                enforce=NONE  version=-
gemma4-31b-inference         enforce=NONE  version=-
glm-flash-inference          enforce=NONE  version=-
gpu-operator                 enforce=NONE  version=-
hatchet                      enforce=NONE  version=-
istio-system                 enforce=NONE  version=-
kafka                        enforce=NONE  version=-
keda                         enforce=NONE  version=-
kindo-deps                   enforce=NONE  version=-
kindo-system                 enforce=NONE  version=-
kube-node-lease              enforce=NONE  version=-
kube-public                  enforce=NONE  version=-
kube-system                  enforce=NONE  version=-
litellm                      enforce=NONE  version=-
llama-indexer                enforce=NONE  version=-
local                        enforce=NONE  version=-
logging                      enforce=NONE  version=-
longhorn                     enforce=NONE  version=-
longhorn-system              enforce=NONE  version=-
mcp                          enforce=NONE  version=-
minio-operator               enforce=NONE  version=-
nango                        enforce=NONE  version=-
next                         enforce=NONE  version=-
pgweb                        enforce=NONE  version=-
presidio                     enforce=NONE  version=-
prisma-migrations            enforce=NONE  version=-
qdrant                       enforce=NONE  version=-
qwen3-5-inference            enforce=NONE  version=-
rabbitmq-system              enforce=NONE  version=-
redis-operator               enforce=NONE  version=-
sandbox                      enforce=NONE  version=-
speaches                     enforce=NONE  version=-
ssoready                     enforce=NONE  version=-
task-worker-ts               enforce=NONE  version=-
text-embeddings              enforce=NONE  version=-
unleash                      enforce=NONE  version=-
zuva-llm-deps                enforce=NONE  version=-

==== Secrets encryption status (CLI) ====
$ rke2 secrets-encrypt status 2>&1 || /var/lib/rancher/rke2/bin/rke2 secrets-encrypt status 2>&1
Encryption Status: Enabled
Current Rotation Stage: start
Server Encryption Hashes: All hashes match

Active  Key Type  Name
------  --------  ----
 *      AES-CBC   aescbckey


==== Cluster-admin role bindings ====
$ kubectl get clusterrolebinding -o json | jq -r '.items[] | select(.roleRef.name=="cluster-admin") | "\(.metadata.name)\t\(.subjects // [] | map("\(.kind):\(.namespace // \"-\")/\(.name)") | join(" , "))"'
jq: error: syntax error, unexpected INVALID_CHARACTER (Unix shell quoting issues?) at <top-level>, line 1:
.items[] | select(.roleRef.name=="cluster-admin") | "\(.metadata.name)\t\(.subjects // [] | map("\(.kind):\(.namespace // \"-\")/\(.name)") | join(" , "))"                                                                                                                          
jq: 1 compile error

==== Privileged or host-access pods ====
$ kubectl get pods -A -o json | jq -r '.items[] | select((.spec.containers[]?.securityContext.privileged==true) or (.spec.hostNetwork==true) or (.spec.hostPID==true)) | "\(.metadata.namespace)/\(.metadata.name)\tpriv=\([.spec.containers[]?.securityContext.privileged] | any)\thostNet=\(.spec.hostNetwork // false)\thostPID=\(.spec.hostPID // false)"' | sort -u
cattle-monitoring-system/rancher-monitoring-prometheus-node-exporter-9lhfb      priv=false      hostNet=true    hostPID=true
cattle-monitoring-system/rancher-monitoring-prometheus-node-exporter-js8fb      priv=false      hostNet=true    hostPID=true
cattle-monitoring-system/rancher-monitoring-prometheus-node-exporter-lm9fc      priv=false      hostNet=true    hostPID=true
cattle-monitoring-system/rancher-monitoring-prometheus-node-exporter-lxlll      priv=false      hostNet=true    hostPID=true
cattle-monitoring-system/rancher-monitoring-prometheus-node-exporter-pbcwf      priv=false      hostNet=true    hostPID=true
cattle-monitoring-system/rancher-monitoring-prometheus-node-exporter-st7dt      priv=false      hostNet=true    hostPID=true
cattle-monitoring-system/rancher-monitoring-prometheus-node-exporter-vcgrk      priv=false      hostNet=true    hostPID=true
gpu-operator/gpu-feature-discovery-nhpbb        priv=true       hostNet=false   hostPID=false
gpu-operator/nvidia-container-toolkit-daemonset-pr8bp   priv=true       hostNet=false   hostPID=true
gpu-operator/nvidia-cuda-validator-vv2mv        priv=true       hostNet=false   hostPID=false
gpu-operator/nvidia-dcgm-exporter-2qrgc priv=true       hostNet=false   hostPID=false
gpu-operator/nvidia-device-plugin-daemonset-2v86r       priv=true       hostNet=false   hostPID=false
gpu-operator/nvidia-mig-manager-4jbv8   priv=true       hostNet=false   hostPID=true
gpu-operator/nvidia-operator-validator-k2s75    priv=true       hostNet=false   hostPID=false
kube-system/cloud-controller-manager-camslc4kbc01.viasystems.pri        priv=false      hostNet=true    hostPID=false
kube-system/cloud-controller-manager-camslc4kbc02.viasystems.pri        priv=false      hostNet=true    hostPID=false
kube-system/cloud-controller-manager-camslc4kbc03.viasystems.pri        priv=false      hostNet=true    hostPID=false
kube-system/etcd-camslc4kbc01.viasystems.pri    priv=false      hostNet=true    hostPID=false
kube-system/etcd-camslc4kbc02.viasystems.pri    priv=false      hostNet=true    hostPID=false
kube-system/etcd-camslc4kbc03.viasystems.pri    priv=false      hostNet=true    hostPID=false
kube-system/helm-install-rke2-canal-grwbg       priv=false      hostNet=true    hostPID=false
kube-system/helm-install-rke2-coredns-tbqh9     priv=false      hostNet=true    hostPID=false
kube-system/kube-apiserver-camslc4kbc01.viasystems.pri  priv=false      hostNet=true    hostPID=false
kube-system/kube-apiserver-camslc4kbc02.viasystems.pri  priv=false      hostNet=true    hostPID=false
kube-system/kube-apiserver-camslc4kbc03.viasystems.pri  priv=false      hostNet=true    hostPID=false
kube-system/kube-controller-manager-camslc4kbc01.viasystems.pri priv=false      hostNet=true    hostPID=false
kube-system/kube-controller-manager-camslc4kbc02.viasystems.pri priv=false      hostNet=true    hostPID=false
kube-system/kube-controller-manager-camslc4kbc03.viasystems.pri priv=false      hostNet=true    hostPID=false
kube-system/kube-proxy-camslc4kbc01.viasystems.pri      priv=true       hostNet=true    hostPID=false
kube-system/kube-proxy-camslc4kbc02.viasystems.pri      priv=true       hostNet=true    hostPID=false
kube-system/kube-proxy-camslc4kbc03.viasystems.pri      priv=true       hostNet=true    hostPID=false
kube-system/kube-proxy-camslc4kbg01.viasystems.pri      priv=true       hostNet=true    hostPID=false
kube-system/kube-proxy-camslc4kbw01.viasystems.pri      priv=true       hostNet=true    hostPID=false
kube-system/kube-proxy-camslc4kbw02.viasystems.pri      priv=true       hostNet=true    hostPID=false
kube-system/kube-proxy-camslc4kbw03.viasystems.pri      priv=true       hostNet=true    hostPID=false
kube-system/kube-scheduler-camslc4kbc01.viasystems.pri  priv=false      hostNet=true    hostPID=false
kube-system/kube-scheduler-camslc4kbc02.viasystems.pri  priv=false      hostNet=true    hostPID=false
kube-system/kube-scheduler-camslc4kbc03.viasystems.pri  priv=false      hostNet=true    hostPID=false
kube-system/rke2-canal-llkhn    priv=true       hostNet=true    hostPID=false
kube-system/rke2-canal-m88xl    priv=true       hostNet=true    hostPID=false
kube-system/rke2-canal-qb6fm    priv=true       hostNet=true    hostPID=false
kube-system/rke2-canal-rtv7s    priv=true       hostNet=true    hostPID=false
kube-system/rke2-canal-wrjcn    priv=true       hostNet=true    hostPID=false
kube-system/rke2-canal-xnqjq    priv=true       hostNet=true    hostPID=false
kube-system/rke2-canal-zz6bp    priv=true       hostNet=true    hostPID=false
longhorn/engine-image-ei-3154f3aa-s4swp priv=true       hostNet=false   hostPID=false
longhorn/engine-image-ei-3154f3aa-sttsk priv=true       hostNet=false   hostPID=false
longhorn/engine-image-ei-3154f3aa-t6qtq priv=true       hostNet=false   hostPID=false
longhorn/instance-manager-33575ebdf50da2003e02ea172bc450a9      priv=true       hostNet=false   hostPID=false
longhorn/instance-manager-670c869572ea2228381c8829006cd8ab      priv=true       hostNet=false   hostPID=false
longhorn/instance-manager-721133a7267802cac8e17479d1c17c9d      priv=true       hostNet=false   hostPID=false
longhorn/instance-manager-c0f0c4ad28ebcfa590040b298365a3be      priv=true       hostNet=false   hostPID=false
longhorn/longhorn-csi-plugin-9q2ww      priv=true       hostNet=false   hostPID=false
longhorn/longhorn-csi-plugin-s5w9x      priv=true       hostNet=false   hostPID=false
longhorn/longhorn-csi-plugin-vm724      priv=true       hostNet=false   hostPID=false
longhorn/longhorn-manager-2l5xg priv=true       hostNet=false   hostPID=false
longhorn/longhorn-manager-79wfg priv=true       hostNet=false   hostPID=false
longhorn/longhorn-manager-pbkv8 priv=true       hostNet=false   hostPID=false
longhorn/longhorn-manager-vp678 priv=true       hostNet=false   hostPID=false
ssoready/ssoready-admin-7b58d7d7f6-gqdm5        priv=true       hostNet=false   hostPID=false
ssoready/ssoready-api-65fcfdd9f8-plvpt  priv=true       hostNet=false   hostPID=false
ssoready/ssoready-app-5b6cb97448-6bztv  priv=true       hostNet=false   hostPID=false
ssoready/ssoready-auth-66cf8d8cd4-nb69d priv=true       hostNet=false   hostPID=false

==== Pods that don't enforce non-root (user namespaces) ====
$ kubectl get pods -A -o json | jq -r '.items[] | select(.metadata.namespace | test("^(kube-|cattle-|longhorn|gpu-operator)") | not) | select([.spec.containers[]? | (.securityContext.runAsNonRoot == true)] | all | not) | "\(.metadata.namespace)/\(.metadata.name)"' | sort -u | wc -l
64

==== Default ServiceAccount auto-mount on user namespaces ====
$ kubectl get sa default -A -o json | jq -r '.items[] | select((.automountServiceAccountToken // true) == true) | .metadata.namespace' | grep -Ev '^(kube-|cattle-|longhorn|rancher|gpu-operator)' | head
error: a resource cannot be retrieved by name across all namespaces

==== Validating webhooks ====
$ kubectl get validatingwebhookconfiguration
NAME                                                             WEBHOOKS   AGE
cert-manager-webhook                                             1          104d
cnpg-validating-webhook-configuration                            5          104d
istio-validator-1-28-3-istio-system                              1          70d
istiod-default-validator                                         1          70d
keda-admission                                                   3          83d
longhorn-webhook-validator                                       1          104d
rabbitmq-operator-rabbitmq-messaging-topology-operator-webhook   13         104d
rancher-monitoring-admission                                     1          84d
rancher.cattle.io                                                11         84d
rke2-ingress-nginx-admission                                     1          63d

==== Mutating webhooks ====
$ kubectl get mutatingwebhookconfiguration
NAME                                  WEBHOOKS   AGE
cert-manager-webhook                  1          104d
cnpg-mutating-webhook-configuration   4          104d
istio-revision-tag-default            4          70d
istio-sidecar-injector-1-28-3         2          70d
longhorn-webhook-mutator              1          104d
rancher-monitoring-admission          1          84d
rancher.cattle.io                     4          84d

==== Policy engine CRDs (kyverno, gatekeeper, etc.) ====
$ kubectl get crd | grep -Ei 'kyverno|gatekeeper|constraint|policy'
adminnetworkpolicies.policy.networking.k8s.io                     2026-01-14T19:16:18Z
baselineadminnetworkpolicies.policy.networking.k8s.io             2026-01-14T19:16:18Z
policybindings.sts.min.io                                         2026-01-15T12:46:15Z

[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# 


[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# cat 08-observability.txt 
================================================
  Monitoring, logging, tracing
  Generated: Wed Apr 29 06:14:26 AM PDT 2026
================================================

==== cattle-monitoring-system pods ====
$ kubectl -n cattle-monitoring-system get pods 2>/dev/null
NAME                                                     READY   STATUS             RESTARTS            AGE
alertmanager-rancher-monitoring-alertmanager-0           2/2     Running            2 (62d ago)         63d
prometheus-rancher-monitoring-prometheus-0               2/3     CrashLoopBackOff   10021 (4m24s ago)   63d
rancher-monitoring-grafana-6c564cfdb6-wm7m7              3/3     Running            7 (21d ago)         63d
rancher-monitoring-kube-state-metrics-d856c8cbb-74crf    1/1     Running            3 (29d ago)         63d
rancher-monitoring-operator-776765b5d5-5wzlq             1/1     Running            1 (62d ago)         63d
rancher-monitoring-prometheus-adapter-6fb658d549-djxhg   1/1     Running            1 (62d ago)         63d
rancher-monitoring-prometheus-node-exporter-9lhfb        1/1     Running            4 (9d ago)          51d
rancher-monitoring-prometheus-node-exporter-js8fb        1/1     Running            1 (62d ago)         84d
rancher-monitoring-prometheus-node-exporter-lm9fc        1/1     Running            1 (62d ago)         84d
rancher-monitoring-prometheus-node-exporter-lxlll        1/1     Running            1 (62d ago)         84d
rancher-monitoring-prometheus-node-exporter-pbcwf        0/1     Evicted            0                   9m31s
rancher-monitoring-prometheus-node-exporter-st7dt        0/1     Evicted            0                   9m31s
rancher-monitoring-prometheus-node-exporter-vcgrk        1/1     Running            0                   29d

==== Prometheus replica/retention/remoteWrite ====
$ kubectl -n cattle-monitoring-system get prometheus -o json 2>/dev/null | jq -r '.items[] | "replicas=\(.spec.replicas)\tretention=\(.spec.retention)\tretentionSize=\(.spec.retentionSize // "unset")\tremoteWrite=\((.spec.remoteWrite // []) | length)"'
replicas=1      retention=10d   retentionSize=unset     remoteWrite=0

==== Alertmanager replica count ====
$ kubectl -n cattle-monitoring-system get alertmanager -o json 2>/dev/null | jq -r '.items[] | "replicas=\(.spec.replicas)"'
replicas=1

==== Alertmanager configured receivers (decoded) ====
$ kubectl -n cattle-monitoring-system get secret alertmanager-rancher-monitoring-alertmanager -o jsonpath='{.data.alertmanager\.yaml}' 2>/dev/null | base64 -d | grep -iE 'receiver|pagerduty|slack|webhook|opsgenie|email' | head -30
receivers:
  receiver: "null"
    receiver: "null"

==== PrometheusRule count ====
$ kubectl get prometheusrule -A --no-headers 2>/dev/null | wc -l
30

==== ServiceMonitor count by namespace ====
$ kubectl get servicemonitor -A --no-headers 2>/dev/null | awk '{print $1}' | sort | uniq -c
     10 cattle-monitoring-system
      1 gpu-operator

==== Logging namespace pods ====
$ kubectl -n logging get pods 2>/dev/null
NAME               READY   STATUS    RESTARTS         AGE
fluent-bit-79vx2   1/1     Running   1690 (56d ago)   69d
fluent-bit-7chzt   1/1     Running   1 (62d ago)      69d
fluent-bit-bnh27   0/1     Evicted   0                11m
fluent-bit-hm4wj   1/1     Running   0                29d
fluent-bit-kmldg   0/1     Evicted   0                11m
fluent-bit-r4z7j   1/1     Running   1693 (62d ago)   69d
fluent-bit-vqj9w   1/1     Running   1 (9d ago)       26d

==== Logging CRDs ====
$ kubectl get crd 2>/dev/null | grep -Ei 'logging|flow|output|fluent|loki|vector'

==== Audit log exporter ====
$ kubectl get ns audit-log-exporter 2>/dev/null && kubectl -n audit-log-exporter get pods 2>/dev/null
NAME                 STATUS   AGE
audit-log-exporter   Active   104d
NAME                                  READY   STATUS    RESTARTS   AGE
audit-log-exporter-598bc5fc4f-7gppf   1/1     Running   0          11d

==== OpenTelemetry / tracing CRDs ====
$ kubectl get crd 2>/dev/null | grep -Ei 'opentelemetry|jaeger|tempo|trace'

==== Metrics server check ====
$ kubectl top nodes 2>/dev/null | head -15
NAME                          CPU(cores)   CPU(%)   MEMORY(bytes)   MEMORY(%)   
camslc4kbc01.viasystems.pri   1617m        10%      14343Mi         45%         
camslc4kbc02.viasystems.pri   483m         3%       13542Mi         42%         
camslc4kbc03.viasystems.pri   781m         2%       9804Mi          15%         
camslc4kbg01.viasystems.pri   507m         0%       300837Mi        19%         
camslc4kbw01.viasystems.pri   2366m        14%      21743Mi         68%         
camslc4kbw02.viasystems.pri   1551m        9%       17132Mi         53%         
camslc4kbw03.viasystems.pri   2265m        7%       21118Mi         33%         

[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# 
