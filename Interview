#!/usr/bin/env bash
# dedicate-varlog.sh
# Safely dedicate a block device to /var/log, migrate logs, and persist in /etc/fstab.
# Usage:
#   sudo ./dedicate-varlog.sh /dev/sdX                # use existing filesystem (ext4/xfs), no mkfs
#   sudo ./dedicate-varlog.sh /dev/sdX --mkfs ext4   # create filesystem before use (ext4 or xfs)
# Options:
#   --mkfs <fstype>     Format the device (explicit opt-in; never done by default)
#   --label <LABEL>     Optional filesystem label
#   --opts "<mntopts>"  Mount options (default: nodev,noexec,nosuid)
#   --dry-run           Print what would happen; do not change the system
# Notes:
#   - Original /var/log is preserved at /var/log.bak.<timestamp>
#   - No deletions are performed.
set -euo pipefail

DRY_RUN=0

if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
  echo "Please run as root (sudo)." >&2; exit 1
fi

DEV="${1:-}"
if [[ -z "${DEV}" ]]; then
  echo "Usage: $0 /dev/sdX [--mkfs ext4|xfs] [--label NAME] [--opts \"nodev,noexec,nosuid,...\"] [--dry-run]"; exit 1
fi

shift || true

# Defaults
DO_MKFS=0
FSTYPE=""
LABEL=""
MNTOPTS="nodev,noexec,nosuid"
MOUNTPOINT="/var/log"
BACKUP="/var/log.bak.$(date +%Y%m%d-%H%M%S)"

while (( "$#" )); do
  case "$1" in
    --mkfs) DO_MKFS=1; FSTYPE="${2:-}"; shift 2;;
    --label) LABEL="${2:-}"; shift 2;;
    --opts) MNTOPTS="${2:-}"; shift 2;;
    --dry-run) DRY_RUN=1; shift;;
    *) echo "Unknown option: $1" >&2; exit 1;;
  esac
done

run() {
  if [[ $DRY_RUN -eq 1 ]]; then
    echo "[DRY-RUN] $*"
  else
    eval "$@"
  fi
}

require() { command -v "$1" >/dev/null 2>&1 || { echo "Missing '$1'." >&2; exit 1; }; }
require rsync; require blkid; require mount; require grep; require sed; require logger || true

# Safety checks
if [[ ! -b "${DEV}" ]]; then
  echo "Device ${DEV} is not a block device. Aborting." >&2; exit 1
fi
if mount | grep -qE " on ${MOUNTPOINT} "; then
  echo "${MOUNTPOINT} is already a separate mount. Exiting."; exit 0
fi
if mount | grep -qE "^${DEV} "; then
  echo "Device ${DEV} is already mounted elsewhere. Aborting."; exit 1
fi

# Filesystem handling
if [[ $DO_MKFS -eq 1 ]]; then
  [[ "${FSTYPE}" =~ ^(ext4|xfs)$ ]] || { echo "Supported mkfs types: ext4, xfs" >&2; exit 1; }
  echo "About to format ${DEV} as ${FSTYPE}."
  if [[ $DRY_RUN -eq 0 ]]; then
    read -r -p "Type 'YES' to proceed: " ACK
    [[ "${ACK}" == "YES" ]] || { echo "Aborted."; exit 1; }
  fi
  if [[ "${FSTYPE}" == "ext4" ]]; then
    run mkfs.ext4 -F ${LABEL:+-L "$LABEL"} "${DEV}"
  else
    run mkfs.xfs -f ${LABEL:+-L "$LABEL"} "${DEV}"
  fi
fi

# Ensure the device has a filesystem
if ! blkid "${DEV}" >/dev/null 2>&1; then
  echo "Device ${DEV} has no recognizable filesystem. Re-run with --mkfs ext4 (or xfs)." >&2
  exit 1
fi

UUID="$(blkid -s UUID -o value "${DEV}")"
TYPE="$(blkid -s TYPE -o value "${DEV}")"
[[ -n "${UUID}" && -n "${TYPE}" ]] || { echo "Could not read UUID/TYPE for ${DEV}." >&2; exit 1; }

echo "Device: ${DEV}  UUID: ${UUID}  TYPE: ${TYPE}"
echo "Mount options: ${MNTOPTS}"

# Quiet rsyslog if present (do not fail if missing)
RSYS_PRESENT=0
if systemctl list-unit-files 2>/dev/null | grep -q '^rsyslog\.service'; then
  RSYS_PRESENT=1
  echo "Stopping rsyslog..."
  run "systemctl stop rsyslog || { systemctl mask rsyslog; systemctl stop rsyslog; }"
fi

# Prepare mountpoint & migrate data
run "mkdir -p '${MOUNTPOINT}'"
echo "Rsync current logs to temporary backup dir..."
run "mkdir -p '${BACKUP}'"
run "rsync -aHAX --numeric-ids --sparse --one-file-system '${MOUNTPOINT}/' '${BACKUP}/'"

# Mount device to a staging dir, copy data in, then switch over atomically
STAGE="$(mktemp -d /mnt/varlog-XXXX)"
run "mount -t '${TYPE}' -o '${MNTOPTS}' '${DEV}' '${STAGE}'"
echo "Copying logs into the new filesystem..."
run "rsync -aHAX --numeric-ids --sparse --one-file-system '${BACKUP}/' '${STAGE}/'"
echo "Mounting ${DEV} on ${MOUNTPOINT}..."
run "umount '${STAGE}'"
run "rmdir '${STAGE}' || true"
run "mount -t '${TYPE}' -o '${MNTOPTS}' '${DEV}' '${MOUNTPOINT}'"

# Persist in /etc/fstab (idempotent)
FSTAB_LINE="UUID=${UUID}  ${MOUNTPOINT}  ${TYPE}  ${MNTOPTS}  0  2"
if ! grep -q "UUID=${UUID}.*${MOUNTPOINT}" /etc/fstab; then
  run "printf '%s\n' \"${FSTAB_LINE}\" >> /etc/fstab"
  echo "Would add to /etc/fstab: ${FSTAB_LINE}"
else
  echo "/etc/fstab already contains an entry for UUID=${UUID} at ${MOUNTPOINT}"
fi

# Verify mount -a
run mount -a

# Unmask/restart rsyslog if present
if [[ $RSYS_PRESENT -eq 1 ]]; then
  run systemctl unmask rsyslog
  run systemctl restart rsyslog
fi

# Quick functional test
if command -v logger >/dev/null 2>&1; then
  run "logger 'TEST: dedicated /var/log mount is working (device ${DEV})'"
fi

SYSLOG_FILE=""
if [[ -f /var/log/syslog ]]; then SYSLOG_FILE=/var/log/syslog; fi
if [[ -z "${SYSLOG_FILE}" && -f /var/log/messages ]]; then SYSLOG_FILE=/var/log/messages; fi
echo
echo "==== Verification ===="
run "mount | grep ' ${MOUNTPOINT} ' || true"
run "df -h '${MOUNTPOINT}' || true"
run "ls -l '${MOUNTPOINT}' | head || true"
if [[ -n "${SYSLOG_FILE}" ]]; then
  run "tail -n3 '${SYSLOG_FILE}' || true"
fi
echo "Logrotate (dry-run):"
run "logrotate -d /etc/logrotate.conf || true"

echo
echo "Done. Original logs are preserved at: ${BACKUP}"
echo "If you ever need to roll back:"
echo "  1) systemctl stop rsyslog || { systemctl mask rsyslog; systemctl stop rsyslog; }"
echo "  2) umount ${MOUNTPOINT}"
echo "  3) remove the fstab line with UUID=${UUID} ${MOUNTPOINT}"
echo "  4) rsync -aHAX ${BACKUP}/ ${MOUNTPOINT}/"
echo "  5) systemctl unmask rsyslog; systemctl restart rsyslog"
