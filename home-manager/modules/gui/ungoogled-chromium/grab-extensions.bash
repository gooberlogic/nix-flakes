#!/usr/bin/env bash
# AI slop script to automatically download Chrome extension .crx files from ungoogled-chromium.nix

set -euo pipefail

NIX_FILE="../ungoogled-chromium.nix"
OUT_DIR="./crx"
rm -rf "$OUT_DIR" # DANGER!
mkdir -p "$OUT_DIR"

echo "🔍 Extracting extension IDs from $NIX_FILE..."

EXT_IDS=$(grep -oP '"[a-p]{32}"' "$NIX_FILE" | tr -d '"')

echo "⬇️  Downloading extensions..."
for EXT_ID in $EXT_IDS; do
  echo "📦 Downloading $EXT_ID..."

    CRX_URL="https://clients2.google.com/service/update2/crx?response=redirect&prodversion=120.0&acceptformat=crx2,crx3&x=id%3D${EXT_ID}%26installsource%3Dondemand%26uc"

  curl -Ls -o "${OUT_DIR}/${EXT_ID}.crx" "$CRX_URL"
done

echo "✅ Done. All extensions saved in $OUT_DIR"

