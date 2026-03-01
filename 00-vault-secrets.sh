#!/bin/bash
# Run on plnx-vault (10.172.249.106) as root
# VAULT_SKIP_VERIFY=true must be set

# Generate unique passwords per environment
DEV_PASS=$(openssl rand -base64 24)
TEST_PASS=$(openssl rand -base64 24)
PROD_PASS=$(openssl rand -base64 24)

echo "=== MinIO Credentials ==="
echo "Dev:  minioadmin / $DEV_PASS"
echo "Test: minioadmin / $TEST_PASS"
echo "Prod: minioadmin / $PROD_PASS"
echo "========================="
echo "Save these somewhere safe before continuing."
echo ""
read -p "Press Enter to write to Vault..."

vault kv put pai/dev/minio-credentials \
  MINIO_ROOT_USER=minioadmin \
  MINIO_ROOT_PASSWORD="$DEV_PASS"

vault kv put pai/test/minio-credentials \
  MINIO_ROOT_USER=minioadmin \
  MINIO_ROOT_PASSWORD="$TEST_PASS"

vault kv put pai/prod/minio-credentials \
  MINIO_ROOT_USER=minioadmin \
  MINIO_ROOT_PASSWORD="$PROD_PASS"

echo ""
echo "Verifying..."
vault kv get pai/dev/minio-credentials
vault kv get pai/test/minio-credentials
vault kv get pai/prod/minio-credentials
