#!/usr/bin/env bash
# Usage: ./run_cleanup.sh hosts.txt
# Optional: set SSH_KEY=/path/to/key if needed

set -u

if [ $# -ne 1 ]; then
  echo "Usage: $0 <hosts_file>"
  exit 1
fi

HOSTS_FILE="$1"
if [ ! -f "$HOSTS_FILE" ]; then
  echo "Hosts file not found: $HOSTS_FILE"
  exit 1
fi

SSH_OPTS="-o BatchMode=yes -o ConnectTimeout=10 -o StrictHostKeyChecking=no"
[ -n "${SSH_KEY:-}" ] && SSH_OPTS="$SSH_OPTS -i $SSH_KEY"

ok=0
fail=0

while IFS= read -r host; do
  # skip blanks/comments
  [ -z "$host" ] && continue
  [[ "$host" =~ ^# ]] && continue

  echo "=== $host ==="
  ssh $SSH_OPTS deploy@"$host" \
    'sudo rm -f /etc/apt/apt.conf.d/80Proxy && sudo systemctl restart landscape-client' \
    && { echo "OK"; ok=$((ok+1)); } \
    || { echo "FAIL"; fail=$((fail+1)); }
done < "$HOSTS_FILE"

echo "-----"
echo "Done. OK: $ok  FAIL: $fail"
