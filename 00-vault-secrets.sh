# List all issuers in pki_int
vault list pki_int/issuers


[root@plnx-vault ~]# vault list pki_int/issuers
Keys
----
05261746-481f-2842-13de-13a1f17aa98c
28fe332e-56ba-1fd3-d619-49435d6881c8
607ba730-8951-e16d-44e4-e49b853669b0
a4799ae0-b0ed-c853-e1fa-a3135340090a
b402d59f-cf38-651b-81ec-3fd840b36a12
c07ee43a-517b-4404-e4f4-da4f951e1d2e
[root@plnx-vault ~]#


for id in 05261746-481f-2842-13de-13a1f17aa98c 28fe332e-56ba-1fd3-d619-49435d6881c8 607ba730-8951-e16d-44e4-e49b853669b0 a4799ae0-b0ed-c853-e1fa-a3135340090a b402d59f-cf38-651b-81ec-3fd840b36a12 c07ee43a-517b-4404-e4f4-da4f951e1d2e; do
  echo "=== $id ==="
  vault read -field=certificate pki_int/issuer/$id | openssl x509 -noout -subject -issuer
  echo ""
done


[root@plnx-vault ~]#
[root@plnx-vault ~]#
[root@plnx-vault ~]# for id in 05261746-481f-2842-13de-13a1f17aa98c 28fe332e-56ba-1fd3-d619-49435d6881c8 607ba730-8951-e16d-44e4-e49b853669b0 a4799ae0-b0ed-c853-e1fa-a3135340090a b402d59f-cf38-651b-81ec-3fd840b36a12 c07ee43a-517b-4404-e4f4-da4f951e1d2e; do
  echo "=== $id ==="
  vault read -field=certificate pki_int/issuer/$id | openssl x509 -noout -subject -issuer
  echo ""
done
=== 05261746-481f-2842-13de-13a1f17aa98c ===
subject=DC=local, DC=calix, CN=CalixInterCA
issuer=CN=CalixRootCA

=== 28fe332e-56ba-1fd3-d619-49435d6881c8 ===
subject=CN=CalixRootCA
issuer=CN=CalixRootCA

=== 607ba730-8951-e16d-44e4-e49b853669b0 ===
subject=CN=Calix Vault Intermediate CA
issuer=DC=local, DC=calix, CN=CalixEntCA

=== a4799ae0-b0ed-c853-e1fa-a3135340090a ===
subject=CN=Calix OCP-AI Intermediate CA
issuer=CN=OCP-AI Temporary Root CA

=== b402d59f-cf38-651b-81ec-3fd840b36a12 ===
subject=CN=OCP-AI Temporary Root CA
issuer=CN=OCP-AI Temporary Root CA

=== c07ee43a-517b-4404-e4f4-da4f951e1d2e ===
subject=DC=local, DC=calix, CN=CalixEntCA
issuer=DC=local, DC=calix, CN=CalixInterCA

[root@plnx-vault ~]#

# Check which issuer is the new corporate-signed one
vault read pki_int/issuer/<issuer-id> | grep -i "issuer_name\|common_name"

# Do this for each issuer ID to identify old vs new

vault write pki_int/config/issuers default=<new-issuer-id>


vault write pki_int/roles/ocp-ai \
  issuer_ref=<new-issuer-id> \
  allowed_domains="calix.local" \
  allow_subdomains=true \
  allow_wildcard_certificates=true \
  max_ttl="8760h"


  vault delete pki_int/issuer/<old-issuer-id>


  vault list pki_root/issuers


  # Check current ClusterIssuer
oc get clusterissuer vault-issuer -o yaml | grep -A5 caBundle

# Check current SecretStores
oc get secretstore vault-store -n pai-dev -o yaml | grep -A5 caBundle


# Delete existing cert secrets so cert-manager reissues with the new chain
oc get certificates -A
# For each one, delete the secret and cert-manager will reissue
oc delete secret <cert-secret> -n <namespace>



vault write pki_int/issue/ocp-ai \
  common_name="test.dev.ocp-ai.calix.local" \
  ttl="24h"



vault write -format=json pki_int/issue/ocp-ai \
  common_name="test.dev.ocp-ai.calix.local" \
  ttl="24h" | jq -r '.data.certificate' | openssl x509 -text -noout | grep -E "Issuer|Subject|Not After"



[root@plnx-vault ~]# vault write pki_int/config/issuers default=607ba730-8951-e16d-44e4-e49b853669b0
Key                              Value
---                              -----
default                          607ba730-8951-e16d-44e4-e49b853669b0
default_follows_latest_issuer    false
[root@plnx-vault ~]#
[root@plnx-vault ~]#
[root@plnx-vault ~]# vault write -format=json pki_int/issue/ocp-ai   common_name="test.dev.ocp-ai.calix.local"   ttl="24h" | jq -r '.data.certificate' | openssl x509 -text -noout | grep -E "Issuer|Subject|Not After"
        Issuer: CN=Calix Vault Intermediate CA
            Not After : Apr  7 13:37:43 2026 GMT
        Subject: CN=test.dev.ocp-ai.calix.local
        Subject Public Key Info:
            X509v3 Subject Key Identifier:
                CA Issuers - URI:https://plnx-vault.calix.local:8200/v1/pki_int/ca
            X509v3 Subject Alternative Name:
[root@plnx-vault ~]#



  [root@plnx-vault ~]#
[root@plnx-vault ~]# vault write -format=json pki_int/issue/ocp-ai \
  common_name="test.dev.ocp-ai.calix.local" \
  ttl="24h" | jq -r '.data.certificate' | openssl x509 -text -noout | grep -E "Issuer|Subject|Not After"
        Issuer: CN=Calix OCP-AI Intermediate CA
            Not After : Apr  7 13:35:14 2026 GMT
        Subject: CN=test.dev.ocp-ai.calix.local
        Subject Public Key Info:
            X509v3 Subject Key Identifier:
                CA Issuers - URI:https://plnx-vault.calix.local:8200/v1/pki_int/ca
            X509v3 Subject Alternative Name:
[root@plnx-vault ~]#
[root@plnx-vault ~]#
[root@plnx-vault ~]#


cat <<EOF | oc apply -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: test-corporate-cert
  namespace: pai-dev
spec:
  secretName: test-corporate-cert-tls
  issuerRef:
    name: vault-issuer
    kind: ClusterIssuer
  dnsNames:
  - test.dev.ocp-ai.calix.local
  duration: 24h
  renewBefore: 1h
EOF



oc get certificate test-corporate-cert -n pai-dev
oc get secret test-corporate-cert-tls -n pai-dev -o jsonpath='{.data.tls\.crt}' | base64 -d | openssl x509 -text -noout | grep -E "Issuer|Subject"


oc delete certificate test-corporate-cert -n pai-dev
oc delete secret test-corporate-cert-tls -n pai-dev




hsuma@plnx-admin:~$
hsuma@plnx-admin:~$
hsuma@plnx-admin:~$
hsuma@plnx-admin:~$
cat <<EOF | oc apply -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: test-corporate-cert
  namespace: pai-dev
spec:
  secretName: test-corporate-cert-tls
  issuerRef:
    name: vault-issuer
    kind: ClusterIssuer
  dnsNames:
  - test.dev.ocp-ai.calix.local
  duration: 24h
  renewBefore: 1h
EOF
Warning: spec.privateKey.rotationPolicy: In cert-manager >= v1.18.0, the default value changed from `Never` to `Always`.
certificate.cert-manager.io/test-corporate-cert created
hsuma@plnx-admin:~$
hsuma@plnx-admin:~$
hsuma@plnx-admin:~$
oc get certificate test-corporate-cert -n pai-dev
NAME                  READY   SECRET                    AGE
test-corporate-cert   True    test-corporate-cert-tls   9s
hsuma@plnx-admin:~$ oc get secret test-corporate-cert-tls -n pai-dev -o jsonpath='{.data.tls\.crt}' | base64 -d | openssl x509 -text -noout | grep -E "Issuer|Subject"
        Issuer: CN = Calix Vault Intermediate CA
        Subject:
        Subject Public Key Info:
            X509v3 Subject Key Identifier:
                CA Issuers - URI:https://plnx-vault.calix.local:8200/v1/pki_int/ca
            X509v3 Subject Alternative Name: critical
hsuma@plnx-admin:~$

oc get gateway pai-gateway -n openshift-ingress -o yaml | grep -B2 -A5 "https-dev"



hsuma@plnx-admin:~$ oc get gateway pai-gateway -n openshift-ingress -o yaml | grep -B2 -A5 "https-dev"
    argocd.argoproj.io/tracking-id: gateway-api:gateway.networking.k8s.io/Gateway:openshift-ingress/pai-gateway
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"gateway.networking.k8s.io/v1","kind":"Gateway","metadata":{"annotations":{"argocd.argoproj.io/tracking-id":"gateway-api:gateway.networking.k8s.io/Gateway:openshift-ingress/pai-gateway"},"name":"pai-gateway","namespace":"openshift-ingress"},"spec":{"gatewayClassName":"openshift-default","listeners":[{"allowedRoutes":{"namespaces":{"from":"Same"}},"name":"http","port":80,"protocol":"HTTP"},{"allowedRoutes":{"namespaces":{"from":"Selector","selector":{"matchLabels":{"env":"dev"}}}},"hostname":"*.dev.ocp-ai.calix.local","name":"https-dev","port":443,"protocol":"HTTPS","tls":{"certificateRefs":[{"kind":"Secret","name":"wildcard-dev-calixca-tls-secret"}],"mode":"Terminate"}},{"allowedRoutes":{"namespaces":{"from":"Selector","selector":{"matchLabels":{"env":"dev"}}}},"hostname":"agentmesh-dev-ai.calix.local","name":"https-agentmesh-dev","port":443,"protocol":"HTTPS","tls":{"certificateRefs":[{"kind":"Secret","name":"agent-dev-tls-secret"}],"mode":"Terminate"}},{"allowedRoutes":{"namespaces":{"from":"Selector","selector":{"matchLabels":{"env":"test"}}}},"hostname":"*.test.ocp-ai.calix.local","name":"https-test","port":443,"protocol":"HTTPS","tls":{"certificateRefs":[{"kind":"Secret","name":"wildcard-test-tls-secret"}],"mode":"Terminate"}},{"allowedRoutes":{"namespaces":{"from":"Selector","selector":{"matchLabels":{"env":"prod"}}}},"hostname":"*.prod.ocp-ai.calix.local","name":"https-prod","port":443,"protocol":"HTTPS","tls":{"certificateRefs":[{"kind":"Secret","name":"wildcard-prod-calixca-tls-secret"}],"mode":"Terminate"}},{"allowedRoutes":{"namespaces":{"from":"Selector","selector":{"matchLabels":{"env":"prod"}}}},"hostname":"agentmesh-ai.calix.local","name":"https-agentmesh-prod","port":443,"protocol":"HTTPS","tls":{"certificateRefs":[{"kind":"Secret","name":"agent-prod-tls-secret"}],"mode":"Terminate"}}]}}
  creationTimestamp: "2026-02-26T04:51:26Z"
  generation: 10
  labels:
    istio.io/rev: openshift-gateway
  name: pai-gateway
--
            env: dev
    hostname: '*.dev.ocp-ai.calix.local'
    name: https-dev
    port: 443
    protocol: HTTPS
    tls:
      certificateRefs:
      - group: ""
--
      status: "True"
      type: ResolvedRefs
    name: https-dev
    supportedKinds:
    - group: gateway.networking.k8s.io
      kind: HTTPRoute
    - group: gateway.networking.k8s.io
      kind: GRPCRoute
hsuma@plnx-admin:~$


Based on what we confirmed from LDAP, our target is:
707,842 completed certificate requests in ou=ca,ou=requests,o=ipaca — all with requestState: complete, accumulated since June 2018.
We want to delete all of them. Here's the reasoning:

Every single one is complete — no pending, rejected, or in-progress requests in the mix
They're all historical host/service cert requests — RH confirmed those certs auto-reissue on client re-enrollment
None of them need to be preserved for operational continuity
Deleting them is what gets pki-tomcatd startup from 30-60 minutes down to seconds


=====

Start

“Quick update on the MetalLB issue that was preventing customers from accessing TCP services externally.”

What was happening

“VIPs were getting assigned correctly and traffic was reaching the nodes, but the connections were failing before reaching the backend services.”

Root cause

“This wasn’t a MetalLB problem.
The Linux kernel was dropping the traffic due to reverse path filtering — because packets were coming in on one interface and needed to go out another.

On top of that, OVN didn’t have a proper return path for those VLAN subnets, so responses couldn’t make it back to the client.”

What we fixed

“We applied node-level fixes via MachineConfig:

Disabled reverse path filtering
Added the correct internal routing
Added masquerade so return traffic flows back properly

Operator-level settings were already correct.”

Current state

“Everything is working now — all TCP services exposed via MetalLB VIPs are reachable externally.”
