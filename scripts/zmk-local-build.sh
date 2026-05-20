#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$repo_root"

if [ ! -d .venv ]; then
  echo ".venv is missing. Run: mise run setup-west" >&2
  exit 1
fi

source .venv/bin/activate

sdk_version="${ZEPHYR_SDK_VERSION:-0.17.0}"
export ZEPHYR_SDK_INSTALL_DIR="${ZEPHYR_SDK_INSTALL_DIR:-$HOME/.local/zephyr-sdk-$sdk_version}"

if [ ! -x "$ZEPHYR_SDK_INSTALL_DIR/arm-zephyr-eabi/bin/arm-zephyr-eabi-gcc" ]; then
  echo "Zephyr SDK missing at $ZEPHYR_SDK_INSTALL_DIR. Run: mise run setup-sdk" >&2
  exit 1
fi

west build \
  -p always \
  -s zmk/app \
  -d build/agar_mini_ble-klink \
  -b klink \
  -S studio-rpc-usb-uart \
  -- \
  -DSHIELD=agar_mini_ble \
  -DZMK_CONFIG="$repo_root/config" \
  -DCONFIG_ZMK_STUDIO=y

mkdir -p dist
cp -p build/agar_mini_ble-klink/zephyr/zmk.uf2 dist/agar_mini_ble-klink-zmk.uf2

echo "Built dist/agar_mini_ble-klink-zmk.uf2"

