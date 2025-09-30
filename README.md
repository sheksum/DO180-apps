#!/usr/bin/env bash
# Usage: SSH_KEY=~/.ssh/deploy_key ./fanout_cleanup.sh hosts.txt

set -euo pipefail
HOSTS_FILE="${1:-}"
[ -f "$HOSTS_FILE" ] || { echo "Usage: $0 <hosts_file>"; exit 1; }

SSH_OPTS="-n -o BatchMode=yes -o ConnectTimeout=10 -o StrictHostKeyChecking=no"
[ -n "${SSH_KEY:-}" ] && SSH_OPTS="$SSH_OPTS -i $SSH_KEY"

ok=0; fail=0

while IFS= read -r host || [[ -n "$host" ]]; do
  host="${host%%$'\r'*}"            # strip CR if file has Windows line endings
  [ -z "$host" ] && continue
  [[ "$host" =~ ^# ]] && continue

  echo "=== $host ==="
  if ssh $SSH_OPTS "deploy@$host" \
      'sudo rm -f /etc/apt/apt.conf.d/80Proxy &&
       sudo systemctl restart landscape-client 2>/dev/null || true'; then
    echo "OK";   ok=$((ok+1))
  else
    echo "FAIL"; fail=$((fail+1))
  fi
done < "$HOSTS_FILE"

echo "-----"
echo "Done. OK: $ok  FAIL: $fail"
