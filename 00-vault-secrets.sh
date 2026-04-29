[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# cat 03-ha-resilience.txt 
================================================
  HA, resilience, replicas, PDBs
  Generated: Wed Apr 29 06:14:00 AM PDT 2026
================================================

==== All deployments cluster-wide ====
$ kubectl get deploy -A
NAMESPACE                  NAME                                                     READY   UP-TO-DATE   AVAILABLE   AGE
api                        api                                                      1/1     1            1           56d
audit-log-exporter         audit-log-exporter                                       1/1     1            1           56d
cattle-fleet-system        fleet-agent                                              1/1     1            1           84d
cattle-monitoring-system   rancher-monitoring-grafana                               1/1     1            1           84d
cattle-monitoring-system   rancher-monitoring-kube-state-metrics                    1/1     1            1           84d
cattle-monitoring-system   rancher-monitoring-operator                              1/1     1            1           84d
cattle-monitoring-system   rancher-monitoring-prometheus-adapter                    1/1     1            1           84d
cattle-system              cattle-cluster-agent                                     2/2     2            2           84d
cattle-system              rancher-webhook                                          1/1     1            1           84d
cattle-system              system-upgrade-controller                                1/1     1            1           84d
cerbos                     cerbos                                                   1/1     1            1           56d
cert-manager               cert-manager                                             1/1     1            1           104d
cert-manager               cert-manager-cainjector                                  1/1     1            1           104d
cert-manager               cert-manager-webhook                                     1/1     1            1           104d
cnpg-system                barman-cloud                                             1/1     1            1           91d
cnpg-system                cloudnative-pg                                           1/1     1            1           104d
credits                    credits                                                  1/1     1            1           56d
deephat-v2-hf-inference    deephat-v2-2h100                                         1/1     1            1           53d
deephat-v2-hf-inference    deephat-v2-b200                                          0/0     0            0           53d
external-sync              external-sync-files                                      1/1     1            1           56d
external-sync              external-sync-files-priority                             1/1     1            1           56d
gemma4-31b-inference       gemma-4-31b-it                                           1/1     1            1           12d
glm-flash-inference        glm-47-flash                                             1/1     1            1           12d
gpu-operator               gpu-operator                                             1/1     1            1           104d
gpu-operator               gpu-operator-node-feature-discovery-gc                   1/1     1            1           104d
gpu-operator               gpu-operator-node-feature-discovery-master               1/1     1            1           104d
hatchet                    hatchet-api                                              1/1     1            1           56d
hatchet                    hatchet-engine                                           1/1     1            1           56d
hatchet                    hatchet-frontend                                         1/1     1            1           56d
istio-system               istio-ingressgateway                                     1/1     1            1           70d
istio-system               istiod-1-28-3                                            3/3     3            3           70d
kafka                      strimzi-cluster-operator                                 1/1     1            1           83d
kafka                      zuva-kafka-entity-operator                               1/1     1            1           83d
keda                       keda-admission-webhooks                                  1/1     1            1           83d
keda                       keda-operator                                            1/1     1            1           83d
keda                       keda-operator-metrics-apiserver                          1/1     1            1           83d
kube-system                rke2-coredns-rke2-coredns                                2/2     2            2           104d
kube-system                rke2-coredns-rke2-coredns-autoscaler                     1/1     1            1           104d
kube-system                rke2-metrics-server                                      1/1     1            1           104d
kube-system                rke2-snapshot-controller                                 1/1     1            1           104d
litellm                    litellm                                                  1/1     1            1           56d
longhorn                   csi-attacher                                             3/3     3            3           103d
longhorn                   csi-provisioner                                          3/3     3            3           103d
longhorn                   csi-resizer                                              3/3     3            3           103d
longhorn                   csi-snapshotter                                          3/3     3            3           103d
longhorn                   longhorn-driver-deployer                                 1/1     1            1           103d
longhorn                   longhorn-ui                                              2/2     2            2           103d
mcp                        mcp-sentinelone                                          1/1     1            1           7d16h
mcp                        mcp-unified                                              1/1     1            1           11d
minio-operator             minio-operator                                           2/2     2            2           104d
nango                      nango                                                    1/1     1            1           56d
nango                      nango-connect-ui                                         1/1     1            1           56d
next                       next                                                     1/1     1            1           56d
pgweb                      kindo-pgweb                                              1/1     1            1           104d
presidio                   presidio-presidio-analyzer                               1/1     1            1           103d
presidio                   presidio-presidio-anonymizer                             1/1     1            1           103d
presidio                   presidio-presidio-image-redactor                         0/0     0            0           103d
qwen3-5-inference          qwen3-5-397b-fp8                                         1/1     1            1           50d
rabbitmq-system            rabbitmq-operator-rabbitmq-cluster-operator              1/1     1            1           104d
rabbitmq-system            rabbitmq-operator-rabbitmq-messaging-topology-operator   1/1     1            1           104d
redis-operator             redis-operator                                           1/1     1            1           104d
speaches                   speaches                                                 1/1     1            1           103d
ssoready                   ssoready-admin                                           1/1     1            1           103d
ssoready                   ssoready-api                                             1/1     1            1           103d
ssoready                   ssoready-app                                             1/1     1            1           103d
ssoready                   ssoready-auth                                            1/1     1            1           103d
task-worker-ts             task-worker-ts                                           2/2     2            2           56d
task-worker-ts             task-worker-ts-large                                     2/2     2            2           56d
text-embeddings            text-embeddings                                          1/1     1            1           57d
unleash                    unleash                                                  2/2     2            2           103d
unleash                    unleash-edge                                             1/1     1            1           103d

==== All statefulsets cluster-wide ====
$ kubectl get sts -A
NAMESPACE                  NAME                                           READY   AGE
cattle-monitoring-system   alertmanager-rancher-monitoring-alertmanager   1/1     84d
cattle-monitoring-system   prometheus-rancher-monitoring-prometheus       0/1     84d
kindo-deps                 minio-pool-0                                   4/4     103d
kindo-deps                 rabbitmq-server                                3/3     103d
kindo-deps                 redis                                          3/3     57d
kindo-deps                 redis-sentinel-sentinel                        0/3     57d
qdrant                     qdrant                                         3/3     11d
unleash                    unleash-postgresql                             1/1     11d

==== All daemonsets cluster-wide ====
$ kubectl get ds -A
NAMESPACE                  NAME                                          DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR                                                          AGE
cattle-monitoring-system   rancher-monitoring-prometheus-node-exporter   7         7         5       7            5           kubernetes.io/os=linux                                                 84d
cattle-monitoring-system   rancher-monitoring-windows-exporter           0         0         0       0            0           kubernetes.io/os=windows                                               84d
gpu-operator               gpu-feature-discovery                         1         1         1       1            1           nvidia.com/gpu.deploy.gpu-feature-discovery=true                       104d
gpu-operator               gpu-operator-node-feature-discovery-worker    4         4         4       4            4           <none>                                                                 104d
gpu-operator               nvidia-container-toolkit-daemonset            1         1         1       1            1           nvidia.com/gpu.deploy.container-toolkit=true                           104d
gpu-operator               nvidia-dcgm-exporter                          1         1         1       1            1           nvidia.com/gpu.deploy.dcgm-exporter=true                               104d
gpu-operator               nvidia-device-plugin-daemonset                1         1         1       1            1           nvidia.com/gpu.deploy.device-plugin=true                               104d
gpu-operator               nvidia-device-plugin-mps-control-daemon       0         0         0       0            0           nvidia.com/gpu.deploy.device-plugin=true,nvidia.com/mps.capable=true   104d
gpu-operator               nvidia-mig-manager                            1         1         1       1            1           nvidia.com/gpu.deploy.mig-manager=true                                 104d
gpu-operator               nvidia-operator-validator                     1         1         1       1            1           nvidia.com/gpu.deploy.operator-validator=true                          104d
kube-system                rke2-canal                                    7         7         7       7            7           kubernetes.io/os=linux                                                 104d
kube-system                rke2-ingress-nginx-controller                 3         3         3       3            3           kubernetes.io/os=linux                                                 63d
logging                    fluent-bit                                    7         7         5       3            5           <none>                                                                 84d
longhorn                   engine-image-ei-3154f3aa                      3         3         3       3            3           <none>                                                                 103d
longhorn                   longhorn-csi-plugin                           3         3         3       3            3           <none>                                                                 103d
longhorn                   longhorn-manager                              4         4         4       4            4           <none>                                                                 103d

==== PodDisruptionBudgets cluster-wide ====
$ kubectl get pdb -A
NAMESPACE            NAME                                                     MIN AVAILABLE   MAX UNAVAILABLE   ALLOWED DISRUPTIONS   AGE
api                  api-pdb                                                  50%             N/A               0                     56d
audit-log-exporter   audit-log-exporter-pdb                                   50%             N/A               0                     56d
credits              credits-pdb                                              50%             N/A               0                     56d
kafka                zuva-kafka-entity-operator                               0               N/A               1                     83d
kafka                zuva-kafka-kafka                                         5               N/A               1                     63d
kindo-deps           postgres-2026-01-30                                      1               N/A               1                     88d
kindo-deps           postgres-2026-01-30-primary                              1               N/A               0                     88d
longhorn             csi-attacher                                             1               N/A               2                     103d
longhorn             csi-provisioner                                          1               N/A               2                     103d
longhorn             instance-manager-25fac3786a00bbda59e8f451513b3eba        1               N/A               0                     53d
longhorn             instance-manager-33575ebdf50da2003e02ea172bc450a9        1               N/A               0                     63d
longhorn             instance-manager-5716524662772595db2a403ceeba78d4        1               N/A               0                     53d
longhorn             instance-manager-622c75f69148290958b6408a097be62b        1               N/A               0                     53d
longhorn             instance-manager-670c869572ea2228381c8829006cd8ab        1               N/A               0                     9d
longhorn             instance-manager-721133a7267802cac8e17479d1c17c9d        1               N/A               0                     103d
longhorn             instance-manager-c0f0c4ad28ebcfa590040b298365a3be        1               N/A               0                     63d
mcp                  mcp-sentinelone-pdb                                      50%             N/A               0                     7d16h
mcp                  mcp-unified-pdb                                          50%             N/A               0                     11d
rabbitmq-system      rabbitmq-operator-rabbitmq-cluster-operator              N/A             1                 1                     104d
rabbitmq-system      rabbitmq-operator-rabbitmq-messaging-topology-operator   N/A             1                 1                     104d
task-worker-ts       task-worker-ts-large-pdb                                 50%             N/A               1                     56d
task-worker-ts       task-worker-ts-pdb                                       50%             N/A               1                     56d

==== HorizontalPodAutoscalers cluster-wide ====
$ kubectl get hpa -A
NAMESPACE        NAME                       REFERENCE                         TARGETS                       MINPODS   MAXPODS   REPLICAS   AGE
istio-system     istio-ingressgateway       Deployment/istio-ingressgateway   cpu: 2%/80%                   1         5         1          70d
istio-system     istiod-1-28-3              Deployment/istiod-1-28-3          cpu: 0%/70%, memory: 5%/75%   3         6         3          70d
task-worker-ts   task-worker-ts-hpa         Deployment/task-worker-ts         cpu: 0%/60%                   2         3         2          56d
task-worker-ts   task-worker-ts-large-hpa   Deployment/task-worker-ts-large   cpu: 0%/60%                   2         3         2          56d

==== PriorityClasses defined ====
$ kubectl get priorityclass
NAME                      VALUE        GLOBAL-DEFAULT   AGE    PREEMPTIONPOLICY
longhorn-critical         1000000000   false            103d   PreemptLowerPriority
sandbox-high              1000000      false            54d    PreemptLowerPriority
sandbox-warmer            100          false            54d    Never
system-cluster-critical   2000000000   false            104d   PreemptLowerPriority
system-node-critical      2000001000   false            104d   PreemptLowerPriority

==== Single-replica deployments (excluding system namespaces) ====
$ kubectl get deploy -A -o json | jq -r '.items[] | select(.spec.replicas==1) | select(.metadata.namespace | test("^(kube-|cattle-|longhorn|gpu-operator)") | not) | "\(.metadata.namespace)/\(.metadata.name)"' 2>/dev/null
api/api
audit-log-exporter/audit-log-exporter
cerbos/cerbos
cert-manager/cert-manager
cert-manager/cert-manager-cainjector
cert-manager/cert-manager-webhook
cnpg-system/barman-cloud
cnpg-system/cloudnative-pg
credits/credits
deephat-v2-hf-inference/deephat-v2-2h100
external-sync/external-sync-files
external-sync/external-sync-files-priority
gemma4-31b-inference/gemma-4-31b-it
glm-flash-inference/glm-47-flash
hatchet/hatchet-api
hatchet/hatchet-engine
hatchet/hatchet-frontend
istio-system/istio-ingressgateway
kafka/strimzi-cluster-operator
kafka/zuva-kafka-entity-operator
keda/keda-admission-webhooks
keda/keda-operator
keda/keda-operator-metrics-apiserver
litellm/litellm
mcp/mcp-sentinelone
mcp/mcp-unified
nango/nango
nango/nango-connect-ui
next/next
pgweb/kindo-pgweb
presidio/presidio-presidio-analyzer
presidio/presidio-presidio-anonymizer
qwen3-5-inference/qwen3-5-397b-fp8
rabbitmq-system/rabbitmq-operator-rabbitmq-cluster-operator
rabbitmq-system/rabbitmq-operator-rabbitmq-messaging-topology-operator
redis-operator/redis-operator
speaches/speaches
ssoready/ssoready-admin
ssoready/ssoready-api
ssoready/ssoready-app
ssoready/ssoready-auth
text-embeddings/text-embeddings
unleash/unleash-edge

==== Multi-replica deployments WITHOUT pod anti-affinity or topology spread ====
$ kubectl get deploy -A -o json | jq -r '.items[] | select((.spec.replicas // 0) > 1) | select(.spec.template.spec.affinity.podAntiAffinity == null and .spec.template.spec.topologySpreadConstraints == null) | select(.metadata.namespace | test("^(kube-|cattle-|longhorn|gpu-operator)") | not) | "\(.metadata.namespace)/\(.metadata.name)"' 2>/dev/null
istio-system/istiod-1-28-3
unleash/unleash

==== Pods missing readiness probes (user namespaces) ====
$ kubectl get pods -A -o json | jq -r '.items[] | select(.metadata.namespace | test("^(kube-|cattle-|longhorn|gpu-operator)") | not) | select(.spec.containers[]?.readinessProbe == null) | "\(.metadata.namespace)/\(.metadata.name)"' 2>/dev/null | sort -u | head -50
cert-manager/cert-manager-67d8c6d78c-vzs7j
cert-manager/cert-manager-cainjector-77dbd66479-4vvgg
external-poller/external-poller-29624040-6624w
external-poller/external-poller-29624220-5w9j9
external-poller/external-poller-29624400-ls55s
kindo-deps/minio-pool-0-0
kindo-deps/minio-pool-0-1
kindo-deps/minio-pool-0-2
kindo-deps/minio-pool-0-3
logging/fluent-bit-79vx2
logging/fluent-bit-7chzt
logging/fluent-bit-bnh27
logging/fluent-bit-hm4wj
logging/fluent-bit-kmldg
logging/fluent-bit-r4z7j
logging/fluent-bit-vqj9w
minio-operator/minio-operator-8479f6867d-xmxqb
minio-operator/minio-operator-8479f6867d-xtd6z
presidio/presidio-presidio-analyzer-857c68996-gwhvm
presidio/presidio-presidio-anonymizer-685876c8c9-4b45v
prisma-migrations/prisma-migrations-rx6h2
ssoready/ssoready-api-65fcfdd9f8-plvpt
ssoready/ssoready-auth-66cf8d8cd4-nb69d
task-worker-ts/task-worker-ts-large-84766fb7d7-w9sj5
task-worker-ts/task-worker-ts-large-84766fb7d7-zfj48

==== Pods missing resource requests/limits (user namespaces) ====
$ kubectl get pods -A -o json | jq -r '.items[] | select(.metadata.namespace | test("^(kube-|cattle-|longhorn|gpu-operator)") | not) | select(.spec.containers[]? | .resources.requests == null or .resources.limits == null) | "\(.metadata.namespace)/\(.metadata.name)"' 2>/dev/null | sort -u | head -50
cert-manager/cert-manager-67d8c6d78c-vzs7j
cert-manager/cert-manager-cainjector-77dbd66479-4vvgg
cert-manager/cert-manager-webhook-78dff5f574-6fmkd
cnpg-system/barman-cloud-548dd8c45d-9zkm8
cnpg-system/cloudnative-pg-54c8747cdb-h6v2h
kafka/zuva-kafka-brokers-0
kafka/zuva-kafka-brokers-1
kafka/zuva-kafka-brokers-2
kafka/zuva-kafka-controllers-3
kafka/zuva-kafka-controllers-4
kafka/zuva-kafka-controllers-5
kafka/zuva-kafka-entity-operator-75f64d9f67-wmghq
kindo-deps/minio-pool-0-0
kindo-deps/minio-pool-0-1
kindo-deps/minio-pool-0-2
kindo-deps/minio-pool-0-3
kindo-deps/redis-sentinel-sentinel-0
minio-operator/minio-operator-8479f6867d-xmxqb
minio-operator/minio-operator-8479f6867d-xtd6z
pgweb/kindo-pgweb-744d5d778-7mg5l
qdrant/qdrant-0
qdrant/qdrant-1
qdrant/qdrant-2
rabbitmq-system/rabbitmq-operator-rabbitmq-cluster-operator-7785c4c45f-2q49r
rabbitmq-system/rabbitmq-operator-rabbitmq-messaging-topology-operator-555jvrwm
unleash/unleash-6d456dd969-4xtqj
unleash/unleash-6d456dd969-l5w8b
unleash/unleash-edge-999bf8f54-rqk9z
unleash/unleash-postgresql-0

==== CoreDNS replica count ====
$ kubectl -n kube-system get deploy rke2-coredns-rke2-coredns -o jsonpath='{.spec.replicas}{"\n"}' 2>/dev/null
2

==== Ingress controller pod placement ====
$ kubectl -n kube-system get pods -l app.kubernetes.io/name=rke2-ingress-nginx -o wide 2>/dev/null
NAME                                  READY   STATUS    RESTARTS   AGE   IP            NODE                          NOMINATED NODE   READINESS GATES
rke2-ingress-nginx-controller-pk4qj   1/1     Running   0          22d   10.42.4.63    camslc4kbw03.viasystems.pri   <none>           <none>
rke2-ingress-nginx-controller-rvgp6   1/1     Running   0          22d   10.42.3.86    camslc4kbw01.viasystems.pri   <none>           <none>
rke2-ingress-nginx-controller-wvzll   1/1     Running   0          22d   10.42.2.244   camslc4kbw02.viasystems.pri   <none>           <none>

[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# 
[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# 
[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# cat 05-network.txt 
================================================
  Network policies and ingress
  Generated: Wed Apr 29 06:14:02 AM PDT 2026
================================================

==== Namespaces with ZERO NetworkPolicies ====
$ for ns in $(kubectl get ns -o name | cut -d/ -f2); do count=$(kubectl -n $ns get netpol --no-headers 2>/dev/null | wc -l); [ "$count" -eq 0 ] && echo "  $ns"; done
  aitk
  api
  audit-log-exporter
  cattle-dashboards
  cattle-impersonation-system
  cattle-local-user-passwords
  cattle-monitoring-system
  cattle-system
  cerbos
  cert-manager
  cnpg-system
  credits
  deephat-v2-hf-inference
  default
  embeddings
  external-poller
  external-secrets
  external-sync
  gemma4-31b-inference
  glm-flash-inference
  gpu-operator
  hatchet
  istio-system
  keda
  kindo-deps
  kindo-system
  kube-node-lease
  kube-public
  litellm
  llama-indexer
  local
  logging
  longhorn
  longhorn-system
  mcp
  minio-operator
  nango
  next
  pgweb
  presidio
  prisma-migrations
  qdrant
  qwen3-5-inference
  redis-operator
  speaches
  ssoready
  task-worker-ts
  text-embeddings
  unleash
  zuva-llm-deps

==== All NetworkPolicies ====
$ kubectl get netpol -A
NAMESPACE             NAME                                                     POD-SELECTOR                                                                                                                                                                               AGE
cattle-fleet-system   default-allow-all                                        <none>                                                                                                                                                                                     84d
kafka                 zuva-kafka-entity-operator                               strimzi.io/cluster=zuva-kafka,strimzi.io/kind=Kafka,strimzi.io/name=zuva-kafka-entity-operator                                                                                             83d
kafka                 zuva-kafka-network-policy-kafka                          strimzi.io/cluster=zuva-kafka,strimzi.io/kind=Kafka,strimzi.io/name=zuva-kafka-kafka                                                                                                       83d
kube-system           rancher-monitoring-coredns-allow-all                     k8s-app=kube-dns                                                                                                                                                                           84d
rabbitmq-system       rabbitmq-operator-rabbitmq-cluster-operator              app.kubernetes.io/component=rabbitmq-operator,app.kubernetes.io/instance=rabbitmq-operator,app.kubernetes.io/name=rabbitmq-cluster-operator,app.kubernetes.io/part-of=rabbitmq             104d
rabbitmq-system       rabbitmq-operator-rabbitmq-messaging-topology-operator   app.kubernetes.io/component=messaging-topology-operator,app.kubernetes.io/instance=rabbitmq-operator,app.kubernetes.io/name=rabbitmq-cluster-operator,app.kubernetes.io/part-of=rabbitmq   104d
sandbox               allow-egress-sandbox-05739dfc                            sandbox.kindo.ai/id-hash=05739dfc                                                                                                                                                          40d
sandbox               allow-egress-sandbox-076c2fa2                            sandbox.kindo.ai/id-hash=076c2fa2                                                                                                                                                          40d
sandbox               allow-egress-sandbox-115723f7                            sandbox.kindo.ai/id-hash=115723f7                                                                                                                                                          41d
sandbox               allow-egress-sandbox-15a52564                            sandbox.kindo.ai/id-hash=15a52564                                                                                                                                                          40d
sandbox               allow-egress-sandbox-18bfb1a4                            sandbox.kindo.ai/id-hash=18bfb1a4                                                                                                                                                          33d
sandbox               allow-egress-sandbox-21ec2955                            sandbox.kindo.ai/id-hash=21ec2955                                                                                                                                                          32d
sandbox               allow-egress-sandbox-26e6ec40                            sandbox.kindo.ai/id-hash=26e6ec40                                                                                                                                                          40d
sandbox               allow-egress-sandbox-2759f545                            sandbox.kindo.ai/id-hash=2759f545                                                                                                                                                          41d
sandbox               allow-egress-sandbox-2be140d9                            sandbox.kindo.ai/id-hash=2be140d9                                                                                                                                                          39d
sandbox               allow-egress-sandbox-34182b11                            sandbox.kindo.ai/id-hash=34182b11                                                                                                                                                          36d
sandbox               allow-egress-sandbox-3df37671                            sandbox.kindo.ai/id-hash=3df37671                                                                                                                                                          38d
sandbox               allow-egress-sandbox-4416e587                            sandbox.kindo.ai/id-hash=4416e587                                                                                                                                                          41d
sandbox               allow-egress-sandbox-46de3c62                            sandbox.kindo.ai/id-hash=46de3c62                                                                                                                                                          37d
sandbox               allow-egress-sandbox-6636f60b                            sandbox.kindo.ai/id-hash=6636f60b                                                                                                                                                          40d
sandbox               allow-egress-sandbox-6caa4b03                            sandbox.kindo.ai/id-hash=6caa4b03                                                                                                                                                          33d
sandbox               allow-egress-sandbox-6e187683                            sandbox.kindo.ai/id-hash=6e187683                                                                                                                                                          54d
sandbox               allow-egress-sandbox-8215ccc4                            sandbox.kindo.ai/id-hash=8215ccc4                                                                                                                                                          40d
sandbox               allow-egress-sandbox-84ad5729                            sandbox.kindo.ai/id-hash=84ad5729                                                                                                                                                          41d
sandbox               allow-egress-sandbox-8921c5c0                            sandbox.kindo.ai/id-hash=8921c5c0                                                                                                                                                          33d
sandbox               allow-egress-sandbox-91870d64                            sandbox.kindo.ai/id-hash=91870d64                                                                                                                                                          40d
sandbox               allow-egress-sandbox-91bd6f9d                            sandbox.kindo.ai/id-hash=91bd6f9d                                                                                                                                                          36d
sandbox               allow-egress-sandbox-92cb867d                            sandbox.kindo.ai/id-hash=92cb867d                                                                                                                                                          26d
sandbox               allow-egress-sandbox-9bd726b8                            sandbox.kindo.ai/id-hash=9bd726b8                                                                                                                                                          33d
sandbox               allow-egress-sandbox-b11eb893                            sandbox.kindo.ai/id-hash=b11eb893                                                                                                                                                          40d
sandbox               allow-egress-sandbox-b88fa783                            sandbox.kindo.ai/id-hash=b88fa783                                                                                                                                                          36d
sandbox               allow-egress-sandbox-b9cb9c6f                            sandbox.kindo.ai/id-hash=b9cb9c6f                                                                                                                                                          27d
sandbox               allow-egress-sandbox-bbec09fd                            sandbox.kindo.ai/id-hash=bbec09fd                                                                                                                                                          40d
sandbox               allow-egress-sandbox-c071b33b                            sandbox.kindo.ai/id-hash=c071b33b                                                                                                                                                          33d
sandbox               allow-egress-sandbox-c93ce184                            sandbox.kindo.ai/id-hash=c93ce184                                                                                                                                                          33d
sandbox               allow-egress-sandbox-cbdd75c8                            sandbox.kindo.ai/id-hash=cbdd75c8                                                                                                                                                          40d
sandbox               allow-egress-sandbox-d2963d3c                            sandbox.kindo.ai/id-hash=d2963d3c                                                                                                                                                          37d
sandbox               allow-egress-sandbox-d80ef066                            sandbox.kindo.ai/id-hash=d80ef066                                                                                                                                                          34d
sandbox               allow-egress-sandbox-db5d5e30                            sandbox.kindo.ai/id-hash=db5d5e30                                                                                                                                                          27d
sandbox               allow-egress-sandbox-dc95d49e                            sandbox.kindo.ai/id-hash=dc95d49e                                                                                                                                                          27d
sandbox               allow-egress-sandbox-e0fcb3ab                            sandbox.kindo.ai/id-hash=e0fcb3ab                                                                                                                                                          27d
sandbox               allow-egress-sandbox-fc459a99                            sandbox.kindo.ai/id-hash=fc459a99                                                                                                                                                          40d
sandbox               allow-egress-sandbox-fce22252                            sandbox.kindo.ai/id-hash=fce22252                                                                                                                                                          40d
sandbox               sandbox-default-deny-egress                              <none>                                                                                                                                                                                     54d

==== All ingresses ====
$ kubectl get ingress -A -o wide
NAMESPACE         NAME               CLASS    HOSTS                               ADDRESS                                     PORTS     AGE
api               api-async          <none>   api-async.kbai.ttm.com              10.201.248.41,10.201.248.42,10.201.248.43   80        56d
api               api-main           <none>   api.kbai.ttm.com                    10.201.248.41,10.201.248.42,10.201.248.43   80        56d
api               api-upload         <none>   api-uploads.kbai.ttm.com            10.201.248.41,10.201.248.42,10.201.248.43   80        56d
kindo-deps        minio-s3           nginx    minio-console.ttm.com               10.201.248.41,10.201.248.42,10.201.248.43   80, 443   30d
longhorn          longhorn-ingress   nginx    longhorn.kbai.ttm.com               10.201.248.41,10.201.248.42,10.201.248.43   80        11d
nango             nango              nginx    integrations-api.kbai.ttm.com       10.201.248.41,10.201.248.42,10.201.248.43   80        7d16h
nango             nango-connect      nginx    integrations-connect.kbai.ttm.com   10.201.248.41,10.201.248.42,10.201.248.43   80        7d16h
next              next               <none>   minerva.ttm.com,app.kbai.ttm.com    10.201.248.41,10.201.248.42,10.201.248.43   80        56d
pgweb             kindo-pgweb        nginx    pgweb.kbai.ttm.com                  10.201.248.41,10.201.248.42,10.201.248.43   80        102d
ssoready          ssoready-admin     nginx    sso.kbai.ttm.com                    10.201.248.41,10.201.248.42,10.201.248.43   80        102d
ssoready          ssoready-api       nginx    sso-api.kbai.ttm.com                10.201.248.41,10.201.248.42,10.201.248.43   80        102d
ssoready          ssoready-app       nginx    sso-app.kbai.ttm.com                10.201.248.41,10.201.248.42,10.201.248.43   80        102d
ssoready          ssoready-auth      nginx    sso-auth.kbai.ttm.com               10.201.248.41,10.201.248.42,10.201.248.43   80        102d
text-embeddings   text-embeddings    nginx    embeddings.kbai.ttm.com             10.201.248.41,10.201.248.42,10.201.248.43   80        57d
unleash           unleash            nginx    unleash.kbai.ttm.com                10.201.248.41,10.201.248.42,10.201.248.43   80, 443   11d
unleash           unleash-edge       nginx    unleash-edge.kbai.ttm.com           10.201.248.41,10.201.248.42,10.201.248.43   80, 443   11d

==== Ingress auth annotations and TLS status ====
$ kubectl get ingress -A -o json | jq -r '.items[] | "\(.metadata.namespace)/\(.metadata.name)\thosts=\([.spec.rules[]?.host] | join(","))\ttls=\((.spec.tls // []) | length)\tauth_url=\(.metadata.annotations["nginx.ingress.kubernetes.io/auth-url"] // "none")"' | column -t
api/api-async                    hosts=api-async.kbai.ttm.com             tls=0  auth_url=none
api/api-main                     hosts=api.kbai.ttm.com                   tls=0  auth_url=none
api/api-upload                   hosts=api-uploads.kbai.ttm.com           tls=0  auth_url=none
kindo-deps/minio-s3              hosts=minio-console.ttm.com              tls=1  auth_url=none
longhorn/longhorn-ingress        hosts=longhorn.kbai.ttm.com              tls=0  auth_url=none
nango/nango                      hosts=integrations-api.kbai.ttm.com      tls=0  auth_url=none
nango/nango-connect              hosts=integrations-connect.kbai.ttm.com  tls=0  auth_url=none
next/next                        hosts=minerva.ttm.com,app.kbai.ttm.com   tls=0  auth_url=none
pgweb/kindo-pgweb                hosts=pgweb.kbai.ttm.com                 tls=0  auth_url=none
ssoready/ssoready-admin          hosts=sso.kbai.ttm.com                   tls=0  auth_url=none
ssoready/ssoready-api            hosts=sso-api.kbai.ttm.com               tls=0  auth_url=none
ssoready/ssoready-app            hosts=sso-app.kbai.ttm.com               tls=0  auth_url=none
ssoready/ssoready-auth           hosts=sso-auth.kbai.ttm.com              tls=0  auth_url=none
text-embeddings/text-embeddings  hosts=embeddings.kbai.ttm.com            tls=0  auth_url=none
unleash/unleash                  hosts=unleash.kbai.ttm.com               tls=1  auth_url=none
unleash/unleash-edge             hosts=unleash-edge.kbai.ttm.com          tls=1  auth_url=none

==== NodePort and LoadBalancer services ====
$ kubectl get svc -A -o json | jq -r '.items[] | select(.spec.type=="NodePort" or .spec.type=="LoadBalancer") | "\(.metadata.namespace)/\(.metadata.name)\ttype=\(.spec.type)"'

==== CNI in use ====
$ kubectl -n kube-system get pods 2>/dev/null | grep -Ei 'canal|cilium|calico|flannel|weave|antrea' | head -5
helm-install-rke2-canal-grwbg                           0/1     Completed   0             63d
rke2-canal-llkhn                                        2/2     Running     2 (62d ago)   63d
rke2-canal-m88xl                                        2/2     Running     6 (26d ago)   63d
rke2-canal-qb6fm                                        2/2     Running     5 (62d ago)   63d
rke2-canal-rtv7s                                        2/2     Running     19 (9d ago)   63d

[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# cat 06-storage.txt 
================================================
  Storage: Longhorn, PVCs, storage classes
  Generated: Wed Apr 29 06:14:06 AM PDT 2026
================================================

==== Storage classes ====
$ kubectl get storageclass -o json | jq -r '.items[] | "\(.metadata.name)\tprovisioner=\(.provisioner)\tdefault=\(.metadata.annotations["storageclass.kubernetes.io/is-default-class"] // "false")"'
longhorn        provisioner=driver.longhorn.io  default=true
longhorn-static provisioner=driver.longhorn.io  default=false

==== Total PVCs by storage class ====
$ kubectl get pvc -A -o json | jq -r '.items[].spec.storageClassName' | sort | uniq -c | sort -rn
     25 longhorn

==== PVCs not Bound ====
$ kubectl get pvc -A -o json | jq -r '.items[] | select(.status.phase != "Bound") | "\(.metadata.namespace)/\(.metadata.name)\t\(.status.phase)"'

==== Longhorn namespace check ====
$ kubectl get ns | grep -i longhorn
longhorn                      Active        103d
longhorn-system               Terminating   104d

==== Longhorn pods ====
$ kubectl -n longhorn get pods 2>/dev/null | head -20 || kubectl -n longhorn-system get pods 2>/dev/null | head -20
NAME                                                READY   STATUS    RESTARTS       AGE
csi-attacher-5857549d6f-b89tc                       1/1     Running   1 (62d ago)    63d
csi-attacher-5857549d6f-m7mxf                       1/1     Running   1 (62d ago)    63d
csi-attacher-5857549d6f-mw5q6                       1/1     Running   2 (62d ago)    63d
csi-provisioner-57fb86978b-5lb9k                    1/1     Running   1 (2d7h ago)   2d7h
csi-provisioner-57fb86978b-wkkdk                    1/1     Running   0              2d7h
csi-provisioner-57fb86978b-wtksp                    1/1     Running   0              2d7h
csi-resizer-547f8b9dc8-9cm8k                        1/1     Running   1 (62d ago)    63d
csi-resizer-547f8b9dc8-bzllh                        1/1     Running   2 (62d ago)    63d
csi-resizer-547f8b9dc8-dhvmh                        1/1     Running   1 (62d ago)    63d
csi-snapshotter-8558df8679-fnp8s                    1/1     Running   3 (29d ago)    63d
csi-snapshotter-8558df8679-hvv6r                    1/1     Running   1 (62d ago)    63d
csi-snapshotter-8558df8679-tlgkq                    1/1     Running   1 (62d ago)    63d
engine-image-ei-3154f3aa-s4swp                      1/1     Running   1 (62d ago)    103d
engine-image-ei-3154f3aa-sttsk                      1/1     Running   1 (62d ago)    103d
engine-image-ei-3154f3aa-t6qtq                      1/1     Running   1 (62d ago)    103d
instance-manager-33575ebdf50da2003e02ea172bc450a9   1/1     Running   0              62d
instance-manager-670c869572ea2228381c8829006cd8ab   1/1     Running   0              9d
instance-manager-721133a7267802cac8e17479d1c17c9d   1/1     Running   0              62d
instance-manager-c0f0c4ad28ebcfa590040b298365a3be   1/1     Running   0              62d

==== Longhorn settings (key items) ====
$ kubectl get settings.longhorn.io -A -o json 2>/dev/null | jq -r '.items[] | select(.metadata.name | test("replica|backup|node|anti-affinity|data-locality|drain")) | "\(.metadata.name) = \(.value)"'
allow-empty-node-selector-volume = true
auto-cleanup-recurring-job-backup-snapshot = true
auto-cleanup-snapshot-after-on-demand-backup-completed = false
auto-cleanup-when-delete-backup = false
backup-compression-method = lz4
backup-concurrent-limit = 2
backup-execution-timeout = 1
concurrent-automatic-engine-upgrade-per-node-limit = 0
concurrent-backing-image-replenish-per-node-limit = 5
concurrent-replica-rebuild-per-node-limit = 5
concurrent-volume-backup-restore-per-node-limit = 5
create-default-disk-labeled-nodes = true
default-backup-block-size = 2
default-data-locality = disabled
default-replica-count = {"v1":"3","v2":"3"}
disable-scheduling-on-cordoned-node = true
engine-replica-timeout = {"v1":"8","v2":"8"}
failed-backup-ttl = 1440
fast-replica-rebuild-enabled = {"v1":"true","v2":"true"}
node-down-pod-deletion-policy = do-nothing
node-drain-policy = block-if-contains-last-replica
offline-replica-rebuilding = {"v1":"false","v2":"false"}
replica-auto-balance = disabled
replica-auto-balance-disk-pressure-percentage = 90
replica-disk-soft-anti-affinity = true
replica-file-sync-http-client-timeout = 30
replica-rebuilding-bandwidth-limit = {"v2":"0"}
replica-replenishment-wait-interval = 600
replica-soft-anti-affinity = false
replica-zone-soft-anti-affinity = true
support-bundle-node-collection-timeout = 30
system-managed-components-node-selector = 

==== Longhorn backup target ====
$ kubectl get backuptarget.longhorn.io -A 2>/dev/null
NAMESPACE         NAME      URL   CREDENTIAL   LASTBACKUPAT   AVAILABLE   LASTSYNCEDAT
longhorn-system   default                      5m0s                       
longhorn          default                      5m0s           false       <no value>

==== Longhorn recurring jobs ====
$ kubectl get recurringjob.longhorn.io -A 2>/dev/null

==== Longhorn volume state summary ====
$ kubectl get volumes.longhorn.io -A -o json 2>/dev/null | jq -r '.items[] | .status.state' | sort | uniq -c
     86 attached

==== Longhorn volume robustness ====
$ kubectl get volumes.longhorn.io -A -o json 2>/dev/null | jq -r '.items[] | .status.robustness' | sort | uniq -c
      1 degraded
     85 healthy

==== hostPath volumes (excluding system namespaces) ====
$ kubectl get pods -A -o json | jq -r '.items[] as $p | $p.spec.volumes[]? | select(.hostPath != null) | "\($p.metadata.namespace)/\($p.metadata.name)\tpath=\(.hostPath.path)"' | grep -viE '^(kube-|cattle-|longhorn|gpu-operator|cnpg-system|minio-operator|rabbitmq-system|redis-operator|logging)' | sort -u
deephat-v2-hf-inference/deephat-v2-2h100-9976dc744-pxkd7        path=/var/lib/longhorn/models/deephat-v2-cache
gemma4-31b-inference/gemma-4-31b-it-79c59d87b4-bffg7    path=/var/lib/longhorn/models/gemma4-cache
glm-flash-inference/glm-47-flash-55699b75d4-hkl5m       path=/var/lib/longhorn/models/glm-flash-cache
qwen3-5-inference/qwen3-5-397b-fp8-5b757d5876-9zcgn     path=/var/lib/longhorn/qwen3-5-cache

==== Uncapped emptyDir volumes by namespace count ====
$ kubectl get pods -A -o json | jq -r '.items[] as $p | $p.spec.volumes[]? | select(.emptyDir != null and .emptyDir.sizeLimit == null) | "\($p.metadata.namespace)"' | grep -viE '^(kube-|cattle-|longhorn|logging)' | sort | uniq -c | sort -rn
     23 kindo-deps
      8 istio-system
      6 qdrant
      3 nango
      1 unleash
      1 qwen3-5-inference
      1 glm-flash-inference
      1 gemma4-31b-inference
      1 deephat-v2-hf-inference
      1 cnpg-system
      1 cerbos

[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# cat 07-backup-dr.txt 
================================================
  Backup and disaster recovery
  Generated: Wed Apr 29 06:14:08 AM PDT 2026
================================================

==== Velero presence ====
$ kubectl get ns velero 2>/dev/null

==== Velero CRDs ====
$ kubectl get crd | grep -i velero

==== Velero backups ====
$ kubectl -n velero get backups,schedules,backupstoragelocations,restores 2>/dev/null

==== VolumeSnapshotClass ====
$ kubectl get volumesnapshotclass 2>/dev/null

==== VolumeSnapshots ====
$ kubectl get volumesnapshot -A 2>/dev/null | head -20

==== CNPG Postgres clusters ====
$ kubectl get cluster.postgresql.cnpg.io -A 2>/dev/null
NAMESPACE    NAME                  AGE   INSTANCES   READY   STATUS                     PRIMARY
kindo-deps   postgres-2026-01-30   88d   3           3       Cluster in healthy state   postgres-2026-01-30-3

==== CNPG cluster backup config ====
$ kubectl get cluster.postgresql.cnpg.io -A -o json 2>/dev/null | jq -r '.items[] | "\(.metadata.namespace)/\(.metadata.name)\tinstances=\(.spec.instances)\tbackup=\(.spec.backup.barmanObjectStore.destinationPath // "NONE")"'
kindo-deps/postgres-2026-01-30  instances=3     backup=NONE

==== CNPG ScheduledBackups ====
$ kubectl get scheduledbackup.postgresql.cnpg.io -A 2>/dev/null
NAMESPACE       NAME        AGE   CLUSTER               LAST BACKUP
kindo-deps      db-backup   91d   postgres-2026-01-30   4m8s
zuva-llm-deps   db-backup   83d   postgres              4m8s

==== CNPG most recent Backups ====
$ kubectl get backup.postgresql.cnpg.io -A 2>/dev/null | tail -10
zuva-llm-deps   db-backup-20260429122500   49m     postgres              plugin               
zuva-llm-deps   db-backup-20260429123000   44m     postgres              plugin               
zuva-llm-deps   db-backup-20260429123500   39m     postgres              plugin               
zuva-llm-deps   db-backup-20260429124000   34m     postgres              plugin               
zuva-llm-deps   db-backup-20260429124500   29m     postgres              plugin               
zuva-llm-deps   db-backup-20260429125000   24m     postgres              plugin               
zuva-llm-deps   db-backup-20260429125500   19m     postgres              plugin               
zuva-llm-deps   db-backup-20260429130000   14m     postgres              plugin               
zuva-llm-deps   db-backup-20260429130500   9m23s   postgres              plugin               
zuva-llm-deps   db-backup-20260429131000   4m23s   postgres              plugin               

==== Cohesity-related resources or annotations (best-effort) ====
$ kubectl get all -A -o json 2>/dev/null | jq -r '.items[]? | select((.metadata.annotations // {}) | tostring | test("cohesity"; "i")) | "\(.kind) \(.metadata.namespace)/\(.metadata.name)"' | head

[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# 
