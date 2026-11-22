#!/usr/bin/env bash
# Builds src/main/webapp/css/app.css with the Tailwind CSS standalone CLI (no Node.js needed).
# Usage: scripts/build-css.sh [--watch]
set -euo pipefail

TAILWIND_VERSION="v4.1.13"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TOOLS_DIR="$ROOT/.tools"
BIN="$TOOLS_DIR/tailwindcss-$TAILWIND_VERSION"

case "$(uname -s)-$(uname -m)" in
  Linux-x86_64)  ASSET="tailwindcss-linux-x64" ;;
  Linux-aarch64) ASSET="tailwindcss-linux-arm64" ;;
  Darwin-x86_64) ASSET="tailwindcss-macos-x64" ;;
  Darwin-arm64)  ASSET="tailwindcss-macos-arm64" ;;
  MINGW*|MSYS*|CYGWIN*) ASSET="tailwindcss-windows-x64.exe" ;;
  *) echo "Unsupported platform: $(uname -s)-$(uname -m)" >&2; exit 1 ;;
esac

if [[ ! -x "$BIN" ]]; then
  mkdir -p "$TOOLS_DIR"
  echo "Downloading Tailwind CSS $TAILWIND_VERSION ($ASSET)..."
  curl -fsSL -o "$BIN" "https://github.com/tailwindlabs/tailwindcss/releases/download/$TAILWIND_VERSION/$ASSET"
  chmod +x "$BIN"
fi

ARGS=(-i "$ROOT/frontend/tailwind/input.css" -o "$ROOT/src/main/webapp/css/app.css")
if [[ "${1:-}" == "--watch" ]]; then
  ARGS+=(--watch)
else
  ARGS+=(--minify)
fi

cd "$ROOT"
exec "$BIN" "${ARGS[@]}"
