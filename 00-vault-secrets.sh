[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# cat 09-lifecycle.txt 
================================================
  Versioning, drift, GitOps
  Generated: Wed Apr 29 06:14:27 AM PDT 2026
================================================

==== Node version distribution ====
$ kubectl get nodes -o json | jq -r '.items[] | "\(.metadata.name)\t\(.status.nodeInfo.kubeletVersion)\t\(.status.nodeInfo.osImage)\t\(.status.nodeInfo.kernelVersion)"'
camslc4kbc01.viasystems.pri     v1.34.4+rke2r1  Red Hat Enterprise Linux 9.7 (Plow)     5.14.0-611.30.1.el9_7.x86_64
camslc4kbc02.viasystems.pri     v1.34.4+rke2r1  Red Hat Enterprise Linux 9.7 (Plow)     5.14.0-611.30.1.el9_7.x86_64
camslc4kbc03.viasystems.pri     v1.34.4+rke2r1  Red Hat Enterprise Linux 9.7 (Plow)     5.14.0-611.30.1.el9_7.x86_64
camslc4kbg01.viasystems.pri     v1.34.4+rke2r1  Red Hat Enterprise Linux 9.7 (Plow)     5.14.0-611.30.1.el9_7.x86_64
camslc4kbw01.viasystems.pri     v1.34.4+rke2r1  Red Hat Enterprise Linux 9.7 (Plow)     5.14.0-611.30.1.el9_7.x86_64
camslc4kbw02.viasystems.pri     v1.34.4+rke2r1  Red Hat Enterprise Linux 9.7 (Plow)     5.14.0-611.30.1.el9_7.x86_64
camslc4kbw03.viasystems.pri     v1.34.4+rke2r1  Red Hat Enterprise Linux 9.7 (Plow)     5.14.0-611.30.1.el9_7.x86_64

==== cattle-fleet-system presence ====
$ kubectl get ns cattle-fleet-system 2>/dev/null && kubectl -n cattle-fleet-system get pods 2>/dev/null
NAME                  STATUS   AGE
cattle-fleet-system   Active   84d
NAME                         READY   STATUS    RESTARTS      AGE
fleet-agent-b497bff4-qhdkz   1/1     Running   1 (63d ago)   63d

==== Fleet GitRepos ====
$ kubectl get gitrepos.fleet.cattle.io -A 2>/dev/null

==== Fleet Bundles ====
$ kubectl get bundles.fleet.cattle.io -A 2>/dev/null | head

==== Flux CRDs ====
$ kubectl get crd 2>/dev/null | grep -i flux

==== Argo CD CRDs ====
$ kubectl get crd 2>/dev/null | grep -i argoproj

==== System upgrade plans ====
$ kubectl get plans.upgrade.cattle.io -A 2>/dev/null
NAMESPACE       NAME               IMAGE                  CHANNEL   VERSION          COMPLETE   MESSAGE
cattle-system   rke2-master-plan   rancher/rke2-upgrade             v1.34.3+rke2r1   True       
cattle-system   rke2-worker-plan   rancher/rke2-upgrade             v1.34.3+rke2r1   True       

==== Helm releases ====
$ helm list -A 2>/dev/null
NAME                            NAMESPACE                       REVISION        UPDATED                                 STATUS          CHART                                                                                           APP VERSION
api                             api                             9               2026-04-17 07:42:31.067098345 -0700 PDT deployed        api-2026.03.15                                                                                  2026.03.15 
audit-log-exporter              audit-log-exporter              2               2026-04-17 07:42:30.918384706 -0700 PDT deployed        audit-log-exporter-2026.03.15                                                                   2026.03.15 
cerbos                          cerbos                          2               2026-04-17 07:42:31.117413413 -0700 PDT deployed        cerbos-2026.03.15                                                                               2026.03.15 
cert-manager                    cert-manager                    16              2026-02-04 11:51:37.316873931 -0800 PST deployed        cert-manager-v1.19.3                                                                            v1.19.3    
cloudnative-pg                  cnpg-system                     16              2026-02-04 11:51:51.032282001 -0800 PST deployed        cloudnative-pg-0.27.0                                                                           1.28.0     
credits                         credits                         2               2026-04-17 07:42:31.061856182 -0700 PDT deployed        credits-2026.03.15                                                                              2026.03.15 
deephat-v2-hf                   deephat-v2-hf-inference         8               2026-04-20 14:56:53.632701915 -0700 PDT deployed        inference-2026.01.1                                                                             2026.01.1  
external-poller                 external-poller                 2               2026-04-17 07:42:30.924345145 -0700 PDT deployed        external-poller-2026.03.15                                                                      2026.03.15 
external-sync                   external-sync                   2               2026-04-17 07:42:31.05136017 -0700 PDT  deployed        external-sync-2026.03.15                                                                        2026.03.15 
fleet-agent-c-zzqfj             cattle-fleet-system             1               2026-02-03 23:07:57.483886031 +0000 UTC deployed        fleet-agent-c-zzqfj-v0.0.0+s-e5d20cf045c68a82ccdee33aaee1b14bcfe870908517dcc9a90de9e621c12                 
gemma4-31b                      gemma4-31b-inference            5               2026-04-21 19:49:25.264526371 -0700 PDT deployed        inference-2026.01.1                                                                             2026.01.1  
glm-flash                       glm-flash-inference             7               2026-04-19 15:14:56.748089314 -0700 PDT deployed        inference-2026.01.1                                                                             2026.01.1  
gpu-operator                    gpu-operator                    16              2026-02-04 11:51:59.389808786 -0800 PST deployed        gpu-operator-v25.10.1                                                                           v25.10.1   
hatchet                         hatchet                         4               2026-04-17 07:41:43.716685407 -0700 PDT deployed        hatchet-2026.03.15                                                                              2026.03.15 
keda                            keda                            28              2026-02-10 06:21:48.929273932 -0800 PST deployed        keda-2.15.1                                                                                     2.15.1     
kindo-nango-bootstrap           kindo-system                    2               2026-04-21 13:25:02.321946572 -0700 PDT deployed        kindo-nango-bootstrap-2026.03.15                                                                2026.03.15 
kindo-pgweb                     pgweb                           26              2026-01-30 08:29:17.988565445 -0800 PST deployed        pgweb-0.1.9                                                                                     0.14.1     
kindo-secrets                   kindo-system                    13              2026-04-21 20:24:25.245425607 -0700 PDT failed          kindo-secrets-1.0.0                                                                             1.0.0      
litellm                         litellm                         2               2026-04-17 07:42:30.923268967 -0700 PDT deployed        litellm-2026.03.15                                                                              2026.03.15 
longhorn                        longhorn                        9               2026-04-17 07:37:32.497471997 -0700 PDT deployed        longhorn-1.10.1                                                                                 v1.10.1    
mcp-sentinelone                 mcp                             1               2026-04-21 13:49:33.275640797 -0700 PDT deployed        mcp-sentinelone-2026.03.15                                                                      2026.03.15 
mcp-unified                     mcp                             1               2026-04-17 07:42:31.075082378 -0700 PDT deployed        mcp-unified-2026.03.15                                                                          2026.03.15 
minio-operator                  minio-operator                  16              2026-02-04 11:51:53.405901218 -0800 PST deployed        operator-7.1.1                                                                                  v7.1.1     
nango                           nango                           2               2026-04-17 07:42:31.051250556 -0700 PDT deployed        nango-2026.03.15                                                                                2026.03.15 
next                            next                            3               2026-04-17 07:42:31.035523046 -0700 PDT deployed        next-2026.03.15                                                                                 2026.03.15 
presidio                        presidio                        8               2026-04-17 07:41:43.699775031 -0700 PDT deployed        presidio-2026.03.15                                                                             2026.03.15 
prisma-migrations               prisma-migrations               2               2026-04-17 07:41:57.709799313 -0700 PDT deployed        prisma-migrations-2026.03.15                                                                    2026.03.15 
qdrant                          qdrant                          1               2026-04-17 07:41:43.694844624 -0700 PDT deployed        qdrant-2026.03.15                                                                               2026.03.15 
qwen3-5-397b-fp8                qwen3-5-inference               4               2026-04-03 10:57:05.462531398 -0700 PDT deployed        inference-0.1.0                                                                                 nightly    
rabbitmq-operator               rabbitmq-system                 16              2026-02-04 11:51:55.857522626 -0800 PST deployed        rabbitmq-cluster-operator-0.1.5                                                                 2.19.0     
rancher-monitoring              cattle-monitoring-system        1               2026-02-03 18:19:27.742277414 -0800 PST deployed        rancher-monitoring-108.0.2+up77.9.1-rancher.11                                                  v0.85.0    
rancher-monitoring-crd          cattle-monitoring-system        1               2026-02-03 17:39:48.403357272 -0800 PST deployed        rancher-monitoring-crd-108.0.2+up77.9.1-rancher.11                                                         
rancher-webhook                 cattle-system                   2               2026-02-04 01:09:17.767001737 +0000 UTC deployed        rancher-webhook-108.0.2+up0.9.2                                                                 0.9.2      
redis-operator                  redis-operator                  16              2026-02-04 11:51:58.391474187 -0800 PST deployed        redis-operator-0.23.0                                                                           0.23.0     
rke2-canal                      kube-system                     3               2026-02-24 13:58:53.268660601 +0000 UTC deployed        rke2-canal-v3.31.3-build2026020600                                                              v3.31.3    
rke2-coredns                    kube-system                     3               2026-02-24 13:58:53.218712493 +0000 UTC deployed        rke2-coredns-1.45.201                                                                           1.13.1     
rke2-ingress-nginx              kube-system                     2               2026-02-24 14:00:24.611289182 +0000 UTC deployed        rke2-ingress-nginx-4.14.302                                                                     1.14.3     
rke2-metrics-server             kube-system                     3               2026-02-24 14:00:24.704336196 +0000 UTC deployed        rke2-metrics-server-3.13.007                                                                    0.8.0      
rke2-runtimeclasses             kube-system                     3               2026-02-24 14:00:24.696056218 +0000 UTC deployed        rke2-runtimeclasses-0.1.000                                                                     0.1.0      
rke2-snapshot-controller        kube-system                     3               2026-02-24 14:00:24.670553326 +0000 UTC deployed        rke2-snapshot-controller-4.2.001                                                                v8.4.0     
rke2-snapshot-controller-crd    kube-system                     3               2026-02-24 14:00:24.605297028 +0000 UTC deployed        rke2-snapshot-controller-crd-4.2.001                                                            v8.4.0     
sandbox                         sandbox                         2               2026-04-17 07:42:31.03656127 -0700 PDT  deployed        sandbox-2026.03.15                                                                              2026.03.15 
speaches                        speaches                        6               2026-04-17 07:41:43.710306232 -0700 PDT deployed        speaches-2026.03.15                                                                             2026.03.15 
ssoready                        ssoready                        6               2026-04-17 07:42:31.104869482 -0700 PDT deployed        ssoready-2026.03.15                                                                             2026.03.15 
strimzi-kafka                   kafka                           24              2026-02-10 06:21:51.412087982 -0800 PST deployed        strimzi-kafka-operator-0.50.0                                                                   0.50.0     
system-upgrade-controller       cattle-system                   2               2026-02-04 01:09:08.738874719 +0000 UTC deployed        system-upgrade-controller-108.0.0                                                               v0.17.0    
task-worker-ts                  task-worker-ts                  3               2026-04-17 07:42:31.054036739 -0700 PDT deployed        task-worker-ts-2026.03.15                                                                       2026.03.15 
text-embeddings                 text-embeddings                 1               2026-03-02 21:48:10.763317826 -0800 PST deployed        text-embeddings-2026.02.0                                                                       2026.02.0  
unleash                         unleash                         9               2026-04-17 07:57:05.227093598 -0700 PDT deployed        unleash-5.4.3                                                                                   6.7.2      
unleash-edge                    unleash                         8               2026-04-17 08:16:49.301882249 -0700 PDT deployed        unleash-edge-3.0.0                                                                              v19.6.1    

==== Helm releases that are not Deployed ====
$ helm list -A --all 2>/dev/null | awk 'NR>1 && $8 != "deployed"'

==== Image registries in use (sources) ====
$ kubectl get pods -A -o json | jq -r '.items[].spec.containers[].image' | awk -F/ '{if (NF==1) print "docker.io (implicit)"; else print $1}' | sort | uniq -c | sort -rn
     39 longhornio
     37 rancher
     34 registry.kindo.ai
     22 quay.io
     22 index.docker.io
     20 docker.io
      9 ghcr.io
      8 nvcr.io
      7 fluent
      6 registry.k8s.io
      4 vllm
      4 minio
      3 unleashorg
      3 docker.io (implicit)
      1 sosedoff

==== Images using :latest tag ====
$ kubectl get pods -A -o json | jq -r '.items[].spec.containers[] | select(.image | test(":latest\$|^[^:]+\$")) | "\(.image)"' | sort -u
jq: error: Invalid escape at line 1, column 4 (while parsing '"\$"') at <top-level>, line 1:
.items[].spec.containers[] | select(.image | test(":latest\$|^[^:]+\$")) | "\(.image)"                                                          
jq: error: Invalid escape at line 1, column 4 (while parsing '"\$"') at <top-level>, line 1:
.items[].spec.containers[] | select(.image | test(":latest\$|^[^:]+\$")) | "\(.image)"                                                                   
jq: 2 compile errors

==== ImagePullBackOff or ErrImagePull pods ====
$ kubectl get pods -A 2>/dev/null | grep -Ei 'ImagePullBackOff|ErrImagePull|InvalidImageName'
kindo-deps                 redis-sentinel-sentinel-0                                         0/1     ImagePullBackOff   0                   57d

[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# cat 10-workload-inventory.txt 
================================================
  Workload inventory and pattern recognition
  Generated: Wed Apr 29 06:14:30 AM PDT 2026
================================================

==== All running pods, namespace summary ====
$ kubectl get pods -A --no-headers 2>/dev/null | awk '{print $1}' | sort | uniq -c | sort -rn
     39 kube-system
     29 longhorn
     14 kindo-deps
     14 gpu-operator
     13 cattle-monitoring-system
      8 kafka
      7 logging
      7 cattle-system
      4 unleash
      4 task-worker-ts
      4 ssoready
      4 istio-system
      3 qdrant
      3 keda
      3 hatchet
      3 external-poller
      3 cert-manager
      2 rabbitmq-system
      2 presidio
      2 nango
      2 minio-operator
      2 mcp
      2 external-sync
      2 cnpg-system
      1 text-embeddings
      1 speaches
      1 redis-operator
      1 qwen3-5-inference
      1 prisma-migrations
      1 pgweb
      1 next
      1 litellm
      1 glm-flash-inference
      1 gemma4-31b-inference
      1 deephat-v2-hf-inference
      1 credits
      1 cerbos
      1 cattle-fleet-system
      1 audit-log-exporter
      1 api

==== Failed/Pending/CrashLoop pods ====
$ kubectl get pods -A 2>/dev/null | grep -vE 'Running|Completed' | head -30
NAMESPACE                  NAME                                                              READY   STATUS             RESTARTS            AGE
cattle-monitoring-system   prometheus-rancher-monitoring-prometheus-0                        2/3     CrashLoopBackOff   10021 (4m28s ago)   63d
cattle-monitoring-system   rancher-monitoring-prometheus-node-exporter-pbcwf                 0/1     Evicted            0                   9m35s
cattle-monitoring-system   rancher-monitoring-prometheus-node-exporter-st7dt                 0/1     Evicted            0                   9m35s
kindo-deps                 redis-sentinel-sentinel-0                                         0/1     ImagePullBackOff   0                   57d
logging                    fluent-bit-bnh27                                                  0/1     Evicted            0                   11m
logging                    fluent-bit-kmldg                                                  0/1     Evicted            0                   11m

==== Recent warning events (last hour) ====
$ kubectl get events -A --field-selector type=Warning --sort-by=.lastTimestamp 2>/dev/null | tail -30
zuva-llm-deps              3s          Warning   FindingCluster         backup/db-backup-20260328153500                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              3s          Warning   FindingCluster         backup/db-backup-20260328175000                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              3s          Warning   FindingCluster         backup/db-backup-20260424205500                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              3s          Warning   FindingCluster         backup/db-backup-20260419003000                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              3s          Warning   FindingCluster         backup/db-backup-20260323091500                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              3s          Warning   FindingCluster         backup/db-backup-20260322200000                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              3s          Warning   FindingCluster         backup/db-backup-20260323211500                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              3s          Warning   FindingCluster         backup/db-backup-20260416211500                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              3s          Warning   FindingCluster         backup/db-backup-20260329001500                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              3s          Warning   FindingCluster         backup/db-backup-20260401225500                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              3s          Warning   FindingCluster         backup/db-backup-20260423190000                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              3s          Warning   FindingCluster         backup/db-backup-20260327202000                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              3s          Warning   FindingCluster         backup/db-backup-20260404151000                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              3s          Warning   FindingCluster         backup/db-backup-20260404121000                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              3s          Warning   FindingCluster         backup/db-backup-20260415132000                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              3s          Warning   FindingCluster         backup/db-backup-20260330170000                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              3s          Warning   FindingCluster         backup/db-backup-20260322194500                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              3s          Warning   FindingCluster         backup/db-backup-20260420005500                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              3s          Warning   FindingCluster         backup/db-backup-20260403010000                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              3s          Warning   FindingCluster         backup/db-backup-20260322223000                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              2s          Warning   FindingCluster         backup/db-backup-20260325152500                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              2s          Warning   FindingCluster         backup/db-backup-20260426035000                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              2s          Warning   FindingCluster         backup/db-backup-20260323172000                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              2s          Warning   FindingCluster         backup/db-backup-20260328150000                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              2s          Warning   FindingCluster         backup/db-backup-20260320213000                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              2s          Warning   FindingCluster         backup/db-backup-20260405022000                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              2s          Warning   FindingCluster         backup/db-backup-20260330013000                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              2s          Warning   FindingCluster         backup/db-backup-20260413134500                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              2s          Warning   FindingCluster         backup/db-backup-20260322035500                             Unknown cluster postgres, will retry in 30 seconds
zuva-llm-deps              2s          Warning   FindingCluster         backup/db-backup-20260325202000                             Unknown cluster postgres, will retry in 30 seconds

==== Stuck VolumeFailedDelete events check ====
$ kubectl get events -A --sort-by='.lastTimestamp' 2>/dev/null | grep -i 'VolumeFailedDelete' | tail -10
default                    3m16s       Warning   VolumeFailedDelete     persistentvolume/pvc-f35422bb-f7a1-4e78-a4d6-ddc6848437b5                            persistentvolume pvc-f35422bb-f7a1-4e78-a4d6-ddc6848437b5 is still attached to node camslc4kbw03.viasystems.pri
default                    3m14s       Warning   VolumeFailedDelete     persistentvolume/pvc-10ea8f1c-459b-492c-abd9-932e586a47d2                            persistentvolume pvc-10ea8f1c-459b-492c-abd9-932e586a47d2 is still attached to node camslc4kbw03.viasystems.pri
default                    3m13s       Warning   VolumeFailedDelete     persistentvolume/pvc-ee953f15-2488-4dc5-be4d-03525ce643fd                            persistentvolume pvc-ee953f15-2488-4dc5-be4d-03525ce643fd is still attached to node camslc4kbw03.viasystems.pri
default                    68s         Warning   VolumeFailedDelete     persistentvolume/pvc-06624812-163e-415e-9df7-67681ce986c0                            persistentvolume pvc-06624812-163e-415e-9df7-67681ce986c0 is still attached to node camslc4kbw03.viasystems.pri
default                    67s         Warning   VolumeFailedDelete     persistentvolume/pvc-3924ed03-5304-4d19-809f-2b4c4723e950                            persistentvolume pvc-3924ed03-5304-4d19-809f-2b4c4723e950 is still attached to node camslc4kbw03.viasystems.pri
default                    66s         Warning   VolumeFailedDelete     persistentvolume/pvc-fd719779-2ae0-4d57-be53-364b78da2ac1                            persistentvolume pvc-fd719779-2ae0-4d57-be53-364b78da2ac1 is still attached to node camslc4kbw03.viasystems.pri
default                    65s         Warning   VolumeFailedDelete     persistentvolume/pvc-5a125c4a-4b85-4e3a-8acf-cbe7c627f8db                            persistentvolume pvc-5a125c4a-4b85-4e3a-8acf-cbe7c627f8db is still attached to node camslc4kbw03.viasystems.pri
default                    65s         Warning   VolumeFailedDelete     persistentvolume/pvc-ed456d7a-0300-42cc-8587-1cbf108563c5                            persistentvolume pvc-ed456d7a-0300-42cc-8587-1cbf108563c5 is still attached to node camslc4kbw03.viasystems.pri

==== Familiar namespace check (Kindo + AITK + supporting) ====
$ for ns in api next litellm credits cerbos hatchet ssoready dex unleash nango pgweb presidio kindo-deps kindo-system aitk-zuva aitk-console gpu-operator longhorn cattle-monitoring-system external-secrets; do kubectl get ns $ns 2>/dev/null > /dev/null && echo "  PRESENT: $ns" || echo "  ABSENT:  $ns"; done
  PRESENT: api
  PRESENT: next
  PRESENT: litellm
  PRESENT: credits
  PRESENT: cerbos
  PRESENT: hatchet
  PRESENT: ssoready
  ABSENT:  dex
  PRESENT: unleash
  PRESENT: nango
  PRESENT: pgweb
  PRESENT: presidio
  PRESENT: kindo-deps
  PRESENT: kindo-system
  ABSENT:  aitk-zuva
  ABSENT:  aitk-console
  PRESENT: gpu-operator
  PRESENT: longhorn
  PRESENT: cattle-monitoring-system
  PRESENT: external-secrets

==== GPU operator presence ====
$ kubectl get ns gpu-operator 2>/dev/null && kubectl -n gpu-operator get pods 2>/dev/null
NAME           STATUS   AGE
gpu-operator   Active   104d
NAME                                                          READY   STATUS      RESTARTS       AGE
gpu-feature-discovery-nhpbb                                   1/1     Running     753 (9d ago)   103d
gpu-operator-7569f8b499-4xp9f                                 1/1     Running     2 (62d ago)    63d
gpu-operator-node-feature-discovery-gc-55ffc49ccc-66bqf       1/1     Running     1 (62d ago)    63d
gpu-operator-node-feature-discovery-master-6b5787f695-9khdh   1/1     Running     2 (62d ago)    63d
gpu-operator-node-feature-discovery-worker-2j6vn              1/1     Running     2 (62d ago)    103d
gpu-operator-node-feature-discovery-worker-2t95k              1/1     Running     19 (9d ago)    103d
gpu-operator-node-feature-discovery-worker-4j7wb              1/1     Running     3 (62d ago)    103d
gpu-operator-node-feature-discovery-worker-j682b              1/1     Running     1 (62d ago)    103d
nvidia-container-toolkit-daemonset-pr8bp                      1/1     Running     10 (9d ago)    103d
nvidia-cuda-validator-vv2mv                                   0/1     Completed   0              9d
nvidia-dcgm-exporter-2qrgc                                    1/1     Running     10 (9d ago)    103d
nvidia-device-plugin-daemonset-2v86r                          1/1     Running     5 (9d ago)     53d
nvidia-mig-manager-4jbv8                                      1/1     Running     10 (9d ago)    103d
nvidia-operator-validator-k2s75                               1/1     Running     10 (9d ago)    103d

==== GPU node labels ====
$ kubectl get nodes -o json | jq -r '.items[] | select(.metadata.labels["nvidia.com/gpu.present"]=="true") | "\(.metadata.name)\tcount=\(.metadata.labels["nvidia.com/gpu.count"] // "?")\tproduct=\(.metadata.labels["nvidia.com/gpu.product"] // "?")\tmig.state=\(.metadata.labels["nvidia.com/mig.config.state"] // "none")"'
camslc4kbg01.viasystems.pri     count=8 product=NVIDIA-H200-NVL mig.state=success

==== Kafka clusters (Strimzi) ====
$ kubectl get kafka -A 2>/dev/null
NAMESPACE       NAME         READY   WARNINGS   KAFKA VERSION   METADATA VERSION
istio-system    zuva-kafka                                      
kafka           zuva-kafka   True               4.1.1           4.1-IV1
speaches        zuva-kafka                                      
zuva-llm-deps   zuva-kafka                                      

==== RabbitMQ clusters ====
$ kubectl get rabbitmqcluster -A 2>/dev/null
NAMESPACE    NAME       ALLREPLICASREADY   RECONCILESUCCESS   AGE
kindo-deps   rabbitmq   True               True               103d

==== Istio injection labels per namespace ====
$ kubectl get ns -L istio-injection 2>/dev/null | grep -v '^NAME' | awk '$NF != "" {print $1, $NF}'
aitk 83d
api 104d
audit-log-exporter 104d
cattle-dashboards 84d
cattle-fleet-system 84d
cattle-impersonation-system 84d
cattle-local-user-passwords 84d
cattle-monitoring-system 84d
cattle-system 84d
cerbos 104d
cert-manager 104d
cnpg-system 104d
credits 104d
deephat-v2-hf-inference 53d
default 104d
embeddings 104d
external-poller 104d
external-secrets 104d
external-sync 104d
gemma4-31b-inference 12d
glm-flash-inference 32d
gpu-operator 104d
hatchet 57d
istio-system 78d
kafka 83d
keda 83d
kindo-deps 104d
kindo-system 103d
kube-node-lease 104d
kube-public 104d
kube-system 104d
litellm 104d
llama-indexer 104d
local 84d
logging 84d
longhorn 103d
longhorn-system 104d
mcp 57d
minio-operator 104d
nango 57d
next 104d
pgweb 104d
presidio 104d
prisma-migrations 103d
qdrant 103d
qwen3-5-inference 52d
rabbitmq-system 104d
redis-operator 104d
sandbox 57d
speaches 104d
ssoready 104d
task-worker-ts 104d
text-embeddings 57d
unleash 104d
zuva-llm-deps 83d

[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# cat 11-utilization.txt 
================================================
  Resource utilization
  Generated: Wed Apr 29 06:14:48 AM PDT 2026
================================================

==== Node CPU/memory utilization ====
$ kubectl top nodes 2>/dev/null
NAME                          CPU(cores)   CPU(%)   MEMORY(bytes)   MEMORY(%)   
camslc4kbc01.viasystems.pri   1433m        8%       15557Mi         48%         
camslc4kbc02.viasystems.pri   318m         1%       13545Mi         42%         
camslc4kbc03.viasystems.pri   336m         1%       9806Mi          15%         
camslc4kbg01.viasystems.pri   392m         0%       300838Mi        19%         
camslc4kbw01.viasystems.pri   2440m        15%      21730Mi         68%         
camslc4kbw02.viasystems.pri   1620m        10%      17136Mi         53%         
camslc4kbw03.viasystems.pri   2356m        7%       21125Mi         33%         

==== Top memory pods ====
$ kubectl top pods -A --sort-by=memory 2>/dev/null | head -20
NAMESPACE                  NAME                                                              CPU(cores)   MEMORY(bytes)   
qwen3-5-inference          qwen3-5-397b-fp8-5b757d5876-9zcgn                                 15m          153041Mi        
longhorn                   instance-manager-721133a7267802cac8e17479d1c17c9d                 409m         6762Mi          
kube-system                kube-apiserver-camslc4kbc01.viasystems.pri                        571m         6433Mi          
gemma4-31b-inference       gemma-4-31b-it-79c59d87b4-bffg7                                   6m           6114Mi          
glm-flash-inference        glm-47-flash-55699b75d4-hkl5m                                     8m           5964Mi          
longhorn                   instance-manager-c0f0c4ad28ebcfa590040b298365a3be                 93m          5422Mi          
kube-system                kube-apiserver-camslc4kbc02.viasystems.pri                        112m         5278Mi          
longhorn                   instance-manager-33575ebdf50da2003e02ea172bc450a9                 110m         4794Mi          
deephat-v2-hf-inference    deephat-v2-2h100-9976dc744-pxkd7                                  5m           4487Mi          
kindo-deps                 postgres-2026-01-30-3                                             58m          3678Mi          
kube-system                kube-apiserver-camslc4kbc03.viasystems.pri                        423m         3455Mi          
cattle-system              cattle-cluster-agent-688678cfc8-zlcdr                             17m          2888Mi          
cattle-system              cattle-cluster-agent-688678cfc8-58zvt                             42m          1943Mi          
text-embeddings            text-embeddings-ff7748fd7-cfccv                                   3m           1862Mi          
kube-system                etcd-camslc4kbc01.viasystems.pri                                  89m          1382Mi          
kube-system                etcd-camslc4kbc02.viasystems.pri                                  72m          1235Mi          
kafka                      zuva-kafka-brokers-2                                              9m           1212Mi          
kafka                      zuva-kafka-brokers-1                                              7m           1178Mi          
kafka                      zuva-kafka-brokers-0                                              9m           1114Mi          

==== Top CPU pods ====
$ kubectl top pods -A --sort-by=cpu 2>/dev/null | head -20
NAMESPACE                  NAME                                                              CPU(cores)   MEMORY(bytes)   
cnpg-system                cloudnative-pg-54c8747cdb-h6v2h                                   1790m        655Mi           
minio-operator             minio-operator-8479f6867d-xmxqb                                   985m         56Mi            
kube-system                kube-apiserver-camslc4kbc01.viasystems.pri                        571m         6433Mi          
kube-system                kube-apiserver-camslc4kbc03.viasystems.pri                        423m         3455Mi          
longhorn                   instance-manager-721133a7267802cac8e17479d1c17c9d                 409m         6762Mi          
kube-system                kube-apiserver-camslc4kbc02.viasystems.pri                        112m         5278Mi          
longhorn                   instance-manager-33575ebdf50da2003e02ea172bc450a9                 110m         4794Mi          
longhorn                   instance-manager-c0f0c4ad28ebcfa590040b298365a3be                 93m          5422Mi          
kube-system                etcd-camslc4kbc01.viasystems.pri                                  89m          1382Mi          
kube-system                etcd-camslc4kbc02.viasystems.pri                                  72m          1235Mi          
gpu-operator               gpu-feature-discovery-nhpbb                                       71m          136Mi           
longhorn                   longhorn-manager-vp678                                            59m          442Mi           
kindo-deps                 postgres-2026-01-30-3                                             58m          3678Mi          
hatchet                    hatchet-engine-54644c96f9-86drl                                   58m          101Mi           
kube-system                etcd-camslc4kbc03.viasystems.pri                                  52m          608Mi           
cattle-system              cattle-cluster-agent-688678cfc8-58zvt                             42m          1943Mi          
kube-system                kube-controller-manager-camslc4kbc02.viasystems.pri               28m          481Mi           
kube-system                rke2-canal-wrjcn                                                  27m          225Mi           
longhorn                   longhorn-manager-pbkv8                                            23m          385Mi           

==== Node conditions (memory/disk pressure) ====
$ kubectl describe nodes 2>/dev/null | grep -A2 'Conditions' | grep -E 'Pressure|Ready' | head -30

==== Ephemeral storage allocatable per node ====
$ kubectl describe nodes 2>/dev/null | grep -A1 'ephemeral-storage' | head -30
  ephemeral-storage:  153525Mi
  hugepages-1Gi:      0
--
  ephemeral-storage:  152933498761
  hugepages-1Gi:      0
--
  ephemeral-storage  0 (0%)       0 (0%)
  hugepages-1Gi      0 (0%)       0 (0%)
--
  Warning  EvictionThresholdMet  16s (x409604 over 47d)  kubelet  Attempting to reclaim ephemeral-storage

--
  ephemeral-storage:  153525Mi
  hugepages-1Gi:      0
--
  ephemeral-storage:  152933498761
  hugepages-1Gi:      0
--
  ephemeral-storage  0 (0%)       0 (0%)
  hugepages-1Gi      0 (0%)       0 (0%)
--
  Warning  EvictionThresholdMet  2m10s (x409592 over 47d)  kubelet  Attempting to reclaim ephemeral-storage

--
  ephemeral-storage:  153525Mi
  hugepages-1Gi:      0
--
  ephemeral-storage:  152933498761
  hugepages-1Gi:      0
--

[root@camslc4kbc01 rke2-discovery-2026-04-29-0613]# 
