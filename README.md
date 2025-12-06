cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: vault-auth-sa
  namespace: vault-poc
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: vault-tokenreviewer
rules:
- apiGroups: ["authentication.k8s.io"]
  resources: ["tokenreviews"]
  verbs: ["create"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: vault-tokenreviewer-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: vault-tokenreviewer
subjects:
- kind: ServiceAccount
  name: vault-auth-sa
  namespace: vault-poc
EOF


apiVersion: external-secrets.io/v1beta1
kind: ClusterSecretStore
metadata:
  name: vault-backend
spec:
  provider:
    vault:
      server: "https://plnx-vault.calix.local:8200"
      path: "secret/data"      # KV V2 path
      version: "v2"
      auth:
        tokenSecretRef:
          name: vault-token
          namespace: vault-poc
          key: token
      caBundle: |
        -----BEGIN CERTIFICATE-----
        <paste your Vault self-signed certificate here>
        -----END CERTIFICATE-----
