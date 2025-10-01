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


=========


#!/usr/bin/env bash
# Usage:
#   SSH_KEY=~/.ssh/deploy_key ./push-existing-sources-lockdown.sh hosts.txt
#
# Behavior:
#   - Detect distro (xenial/bionic/focal/jammy/noble)
#   - Push matching landscape-ubuntu-<codename>-onprem.list
#   - Remove ALL other files in /etc/apt/sources.list.d/ except those starting with "landscape"
#   - Run apt-get update
#   - Log results locally to push-sources.log

set -euo pipefail

HOSTS_FILE="${1:-}"
LOGFILE="push-sources.log"

[ -f "$HOSTS_FILE" ] || { echo "Usage: $0 <hosts_file>"; exit 1; }
SRC_DIR="./sources-files"
[ -d "$SRC_DIR" ] || { echo "Missing $SRC_DIR"; exit 1; }

UPDATE="${UPDATE:-yes}"

SSH_OPTS="-n -o BatchMode=yes -o ConnectTimeout=10 -o StrictHostKeyChecking=no"
[ -n "${SSH_KEY:-}" ] && SSH_OPTS="$SSH_OPTS -i $SSH_KEY"

ok=0; fail=0
echo "===== Run started $(date) =====" | tee -a "$LOGFILE"

while IFS= read -r host || [[ -n "$host" ]]; do
  host="${host%%$'\r'*}"
  [ -z "$host" ] && continue
  [[ "$host" =~ ^# ]] && continue

  echo "=== $host ===" | tee -a "$LOGFILE"

  codename=$(ssh $SSH_OPTS "deploy@$host" '
    c="";
    if [ -r /etc/os-release ]; then . /etc/os-release; c="${VERSION_CODENAME:-}"; fi
    if [ -z "$c" ] && command -v lsb_release >/dev/null 2>&1; then c=$(lsb_release -cs 2>/dev/null || true); fi
    echo "$c"
  ' 2>/dev/null || true)
  codename=$(echo "$codename" | tr '[:upper:]' '[:lower:]')

  case "$codename" in
    xenial|bionic|focal|jammy|noble) ;;
    *) echo "  FAIL: unknown codename '$codename'" | tee -a "$LOGFILE"; fail=$((fail+1)); continue ;;
  esac

  src_file="$SRC_DIR/landscape-ubuntu-${codename}-onprem.list"
  if [ ! -f "$src_file" ]; then
    echo "  FAIL: no local file for $codename" | tee -a "$LOGFILE"
    fail=$((fail+1)); continue
  fi

  if scp $SSH_OPTS "$src_file" "deploy@$host:/tmp/landscape.list" >/dev/null 2>&1 && \
     ssh $SSH_OPTS "deploy@$host" "
       sudo mv /tmp/landscape.list /etc/apt/sources.list.d/landscape-ubuntu-${codename}-onprem.list &&
       sudo chmod 0644 /etc/apt/sources.list.d/landscape-ubuntu-${codename}-onprem.list &&
       sudo find /etc/apt/sources.list.d -maxdepth 1 -type f ! -name 'landscape*' -exec rm -f {} +
     "; then
    echo "  Installed + cleaned old files" | tee -a "$LOGFILE"
  else
    echo "  FAIL: copy/install step" | tee -a "$LOGFILE"
    fail=$((fail+1)); continue
  fi

  if [ "$UPDATE" = "yes" ]; then
    if ssh $SSH_OPTS "deploy@$host" 'sudo apt-get update -y >/dev/null 2>&1'; then
      echo "  apt-get update OK" | tee -a "$LOGFILE"
    else
      echo "  WARN: apt-get update failed" | tee -a "$LOGFILE"
    fi
  fi

  ok=$((ok+1))
done < "$HOSTS_FILE"

echo "-----" | tee -a "$LOGFILE"
echo "Run finished: OK=$ok FAIL=$fail ($(date))" | tee -a "$LOGFILE"
