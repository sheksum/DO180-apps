#!/usr/bin/env bash
# cleanup-80Proxy-and-restart-landscape.sh
# Idempotently remove apt proxy file and restart landscape-client

set -euo pipefail

LOG="/var/log/landscape-proxy-cleanup.log"
APT_PROXY="/etc/apt/apt.conf.d/80Proxy"
SERVICE_NAME="landscape-client"

log() { echo "[$(date -Is)] $*" | tee -a "$LOG"; }

log "Starting cleanup on host: $(hostname -f 2>/dev/null || hostname)"

# 1) Remove the apt proxy file if present
if [[ -f "$APT_PROXY" ]]; then
  rm -f "$APT_PROXY"
  log "Removed $APT_PROXY"
else
  log "No $APT_PROXY found (already clean)"
fi

# 2) Restart landscape-client (supports systemd and upstart/service)
restart_ok=false

if command -v systemctl >/dev/null 2>&1; then
  if systemctl list-unit-files | grep -q "^${SERVICE_NAME}\.service"; then
    log "Restarting via systemctl..."
    if systemctl try-restart "${SERVICE_NAME}.service"; then
      restart_ok=true
    fi
  fi
fi

if ! $restart_ok; then
  if command -v service >/dev/null 2>&1; then
    if service "$SERVICE_NAME" status >/dev/null 2>&1 || service "$SERVICE_NAME" restart >/dev/null 2>&1; then
      log "Restarting via service..."
      service "$SERVICE_NAME" restart
      restart_ok=true
    fi
  fi
fi

# One more gentle fallback using systemctl without unit-file check
if ! $restart_ok && command -v systemctl >/dev/null 2>&1; then
  log "Fallback: systemctl restart ${SERVICE_NAME} (no unit-file check)"
  if systemctl restart "$SERVICE_NAME" >/dev/null 2>&1; then
    restart_ok=true
  fi
fi

if $restart_ok; then
  log "Successfully restarted ${SERVICE_NAME}"
else
  log "WARNING: Could not restart ${SERVICE_NAME}. Is it installed/enabled?"
  # don’t hard-fail the job—exit 0 so Landscape continues on all hosts
fi
log "Done."
exit 0
