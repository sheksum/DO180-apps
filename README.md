#!/usr/bin/env bash
# dedicate-varlog.sh
# Dedicate a device to /var/log, migrate logs, and persist in /etc/fstab.
# rsyslog handling: MASK rsyslog.service -> STOP -> migrate -> UNMASK -> RESTART.

set -euo pipefail

DRY_RUN=0
DO_MKFS=0
FSTYPE=""
LABEL=""
MNTOPTS="nodev,noexec,nosuid"
MOUNTPOINT="/var/log"
BACKUP="/var/log.bak.$(date +%Y%m%d-%H%M%S)"
AUTO=0
PICK_LARGEST=0
DEV="${1:-}"

# If first arg is a flag, clear DEV
[[ "${DEV:-}" =~ ^-- ]] && DEV=""

shift || true
while (( "$#" )); do
  case "$1" in
    --mkfs)    DO_MKFS=1; FSTYPE="${2:-}"; shift 2;;
    --label)   LABEL="${2:-}"; shift 2;;
    --opts)    MNTOPTS="${2:-}"; shift 2;;
    --dry-run) DRY_RUN=1; shift;;
    --auto)    AUTO=1; shift;;
    --largest) PICK_LARGEST=1; shift;;
    *) echo "Unknown option: $1" >&2; exit 1;;
  esac
done

[[ ${EUID:-$(id -u)} -eq 0 ]] || { echo "Please run as root (sudo)."; exit 1; }

run(){ if [[ $DRY_RUN -eq 1 ]]; then echo "[DRY-RUN] $*"; else eval "$@"; fi; }
require(){ command -v "$1" >/dev/null 2>&1 || { echo "Missing '$1'." >&2; exit 1; }; }
require rsync; require blkid; require mount; require grep; require sed; command -v logger >/dev/null 2>&1 || true

rescan_scsi(){
  echo "Rescanning SCSI hosts..."
  for host in /sys/class/scsi_host/host*; do [[ -e "$host/scan" ]] && run "echo '- - -' > '$host/scan'"; done
}

list_unmounted_disks(){ lsblk -bdpno NAME,SIZE,TYPE,MOUNTPOINT | awk '$3=="disk"{print $0}'; }
pick_device(){
  local candidates; mapfile -t candidates < <(list_unmounted_disks | awk '$4==""{print $0}')
  (( ${#candidates[@]} )) || { echo ""; return 0; }
  if (( PICK_LARGEST )); then printf '%s\n' "${candidates[@]}" | sort -k2,2n | tail -n1 | awk '{print $1}'
  else printf '%s\n' "${candidates[@]}" | tail -n1 | awk '{print $1}'; fi
}

if [[ -z "${DEV}" && $AUTO -eq 0 ]]; then
  cat <<USAGE
Usage:
  sudo $0 /dev/sdX [--mkfs ext4|xfs] [--label NAME] [--opts "nodev,noexec,nosuid"] [--dry-run]
  sudo $0 --auto [--largest] [--mkfs ext4|xfs] [--label NAME] [--opts "..."] [--dry-run]
USAGE
  exit 1
fi

rescan_scsi

if [[ $AUTO -eq 1 && -z "${DEV}" ]]; then
  echo "Detecting unmounted disks..."
  list_unmounted_disks | awk '{printf "  %-20s %12d %-6s %s\n",$1,$2,$3,$4}'
  DEV="$(pick_device || true)"; [[ -n "$DEV" ]] || { echo "No unmounted disks found." >&2; exit 1; }
  echo "Auto-selected: $DEV"
fi

[[ -b "${DEV}" ]] || { echo "Device ${DEV} is not a block device." >&2; exit 1; }
mount | grep -qE " on ${MOUNTPOINT} " && { echo "${MOUNTPOINT} already mounted. Exit."; exit 0; }
mount | grep -qE "^${DEV} " && { echo "Device ${DEV} already mounted elsewhere."; exit 1; }

# Optional mkfs
if [[ $DO_MKFS -eq 1 ]]; then
  [[ "$FSTYPE" =~ ^(ext4|xfs)$ ]] || { echo "Supported mkfs: ext4, xfs"; exit 1; }
  echo "About to format ${DEV} as ${FSTYPE}."
  if [[ $DRY_RUN -eq 0 ]]; then read -r -p "Type 'YES' to proceed: " ACK; [[ "$ACK" == "YES" ]] || { echo "Aborted."; exit 1; }; fi
  [[ "$FSTYPE" == "ext4" ]] && run mkfs.ext4 -F ${LABEL:+-L "$LABEL"} "${DEV}" || run mkfs.xfs -f ${LABEL:+-L "$LABEL"} "${DEV}"
fi

# Must have filesystem now
blkid "${DEV}" >/dev/null 2>&1 || { echo "No filesystem on ${DEV}. Use --mkfs ext4|xfs."; exit 1; }
UUID="$(blkid -s UUID -o value "${DEV}")"; TYPE="$(blkid -s TYPE -o value "${DEV}")"
echo "Device: ${DEV}  UUID: ${UUID}  TYPE: ${TYPE}"
echo "Mount options: ${MNTOPTS}"

# --- rsyslog.service: MASK -> STOP (no socket handling by request) ---
if systemctl list-unit-files 2>/dev/null | grep -q '^rsyslog\.service'; then
  echo "Masking rsyslog.service..."
  run "systemctl mask rsyslog.service || true"
  echo "Stopping rsyslog.service..."
  run "systemctl stop rsyslog.service || true"
fi

# Backup & migrate
run "mkdir -p '${MOUNTPOINT}'"
echo "Backing up existing logs to ${BACKUP} ..."
run "mkdir -p '${BACKUP}'"
run "rsync -aHAX --numeric-ids --sparse --one-file-system '${MOUNTPOINT}/' '${BACKUP}/'"

# Stage mount, copy, switch
STAGE="$(mktemp -d /mnt/varlog-XXXX)"
run "mount -t '${TYPE}' -o '${MNTOPTS}' '${DEV}' '${STAGE}'"
echo "Copying logs into the new filesystem..."
run "rsync -aHAX --numeric-ids --sparse --one-file-system '${BACKUP}/' '${STAGE}/'"
echo "Mounting ${DEV} on ${MOUNTPOINT}..."
run "umount '${STAGE}'"
run "rmdir '${STAGE}' || true"
run "mount -t '${TYPE}' -o '${MNTOPTS}' '${DEV}' '${MOUNTPOINT}'"

# fstab (idempotent)
FSTAB_LINE="UUID=${UUID}  ${MOUNTPOINT}  ${TYPE}  ${MNTOPTS}  0  2"
grep -q "UUID=${UUID}.*${MOUNTPOINT}" /etc/fstab || { run "printf '%s\n' \"${FSTAB_LINE}\" >> /etc/fstab"; echo "Added to /etc/fstab: ${FSTAB_LINE}"; }

# Ensure mounts active
run mount -a

# Bring rsyslog back
if systemctl list-unit-files 2>/dev/null | grep -q '^rsyslog\.service'; then
  echo "Unmasking and restarting rsyslog.service..."
  run "systemctl unmask rsyslog.service || true"
  run "systemctl restart rsyslog.service || true"
  run "systemctl show -p MainPID --value rsyslog || true"
fi

# Smoke test & summary
command -v logger >/dev/null 2>&1 && run "logger 'TEST: dedicated /var/log mount is working (device ${DEV})'"
SYSLOG_FILE=""; [[ -f /var/log/syslog ]] && SYSLOG_FILE=/var/log/syslog; [[ -z "$SYSLOG_FILE" && -f /var/log/messages ]] && SYSLOG_FILE=/var/log/messages

echo; echo "==== Verification ===="
run "mount | grep ' ${MOUNTPOINT} ' || true"
run "df -h '${MOUNTPOINT}' || true"
run "ls -l '${MOUNTPOINT}' | head || true"
[[ -n "$SYSLOG_FILE" ]] && run "tail -n3 '${SYSLOG_FILE}' || true"
echo "Logrotate (dry-run):"; run "logrotate -d /etc/logrotate.conf || true"

echo
echo "Done. Original logs are preserved at: ${BACKUP}"
echo "Rollback:"
echo "  1) systemctl mask rsyslog.service; systemctl stop rsyslog.service"
echo "  2) umount ${MOUNTPOINT}; sed -i '\\|UUID=${UUID} .* ${MOUNTPOINT}|d' /etc/fstab"
echo "  3) rsync -aHAX ${BACKUP}/ ${MOUNTPOINT}/"
echo "  4) systemctl unmask rsyslog.service; systemctl restart rsyslog.service"
