#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
firmware="${FIRMWARE_UF2:-$repo_root/dist/agar_mini_ble-klink-zmk.uf2}"
volume_name="${BOOTLOADER_VOLUME:-KLINK-BOOT}"
volume="/Volumes/$volume_name"

if [ ! -f "$firmware" ]; then
  echo "Firmware not found: $firmware" >&2
  echo "Run: mise run build" >&2
  exit 1
fi

echo "Waiting for $volume..."

while true; do
  if [ -d "$volume" ]; then
    ts="$(date +%Y%m%d-%H%M%S)"
    backup_dir="$HOME/Downloads/$volume_name-firmware-backup-$ts"

    mkdir -p "$backup_dir"
    echo "Found $volume"
    echo "Backing up exposed bootloader files to $backup_dir"

    find "$volume" -maxdepth 1 -type f -print -exec cp -X -p {} "$backup_dir/" \; || true

    echo "Backup contents:"
    ls -la "$backup_dir"

    echo "Writing firmware: $firmware"
    cp -X "$firmware" "$volume/$(basename "$firmware")"
    sync

    echo "Firmware copied successfully. Bootloader may auto-eject now."
    exit 0
  fi

  sleep 2
done

