#!/usr/bin/env bash
# run_cleanup.sh
# Usage: ./run_cleanup.sh hosts.txt

HOSTS_FILE="$1"
if [ -z "$HOSTS_FILE" ] || [ ! -f "$HOSTS_FILE" ]; then
  echo "Usage: $0 <hosts_file>"
  exit 1
fi

ok=0
fail=0

while IFS= read -r host; do
  [ -z "$host" ] && continue
  [[ "$host" =~ ^# ]] && continue

  echo "=== $host ==="
  ssh -o BatchMode=yes -o ConnectTimeout=10 deploy@"$host" '
    sudo rm -f /etc/apt/apt.conf.d/80Proxy
    if command -v systemctl >/dev/null 2>&1; then
      sudo systemctl restart landscape-client 2>/dev/null || true
    else
      sudo service landscape-client restart 2>/dev/null || true
    fi
  ' \
  && { echo "OK"; ok=$((ok+1)); } \
  || { echo "FAIL"; fail=$((fail+1)); }
done < "$HOSTS_FILE"

echo "-----"
echo "Done. OK: $ok  FAIL: $fail"
