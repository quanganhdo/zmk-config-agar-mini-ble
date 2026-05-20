#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$repo_root"

if [ ! -d .venv ]; then
  python -m venv .venv
fi

source .venv/bin/activate
python -m pip install --upgrade pip wheel west

if [ ! -d .west ]; then
  west init -l config
fi

west update
west zephyr-export
python -m pip install \
  "setuptools<81" \
  -r zephyr/scripts/requirements.txt \
  -r zmk/app/scripts/requirements.txt

echo "West workspace and Python dependencies are ready"
