#!/usr/bin/env bash
set -euo pipefail

sdk_version="${ZEPHYR_SDK_VERSION:-0.17.0}"
sdk_parent="${ZEPHYR_SDK_PARENT:-$HOME/.local}"
sdk_dir="$sdk_parent/zephyr-sdk-$sdk_version"

if [ -x "$sdk_dir/arm-zephyr-eabi/bin/arm-zephyr-eabi-gcc" ]; then
  echo "Zephyr SDK already installed at $sdk_dir"
  exit 0
fi

case "$(uname -m)" in
  arm64|aarch64) sdk_arch="aarch64" ;;
  x86_64) sdk_arch="x86_64" ;;
  *) echo "Unsupported macOS architecture: $(uname -m)" >&2; exit 1 ;;
esac

archive="zephyr-sdk-$sdk_version""_macos-$sdk_arch.tar.xz"
url="https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v$sdk_version/$archive"
cache_dir="$HOME/.cache/zmk-config-agar-mini-ble"

mkdir -p "$sdk_parent" "$cache_dir"

if [ ! -f "$cache_dir/$archive" ]; then
  echo "Downloading $url"
  curl -L "$url" -o "$cache_dir/$archive"
fi

echo "Extracting $archive to $sdk_parent"
tar -xJf "$cache_dir/$archive" -C "$sdk_parent"

echo "Installing ARM toolchain and host tools"
"$sdk_dir/setup.sh" -t arm-zephyr-eabi -h -c

echo "Zephyr SDK ready at $sdk_dir"

