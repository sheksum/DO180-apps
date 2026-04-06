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
