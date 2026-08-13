#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$ROOT/dist"

if [ ! -d "$ROOT/src" ]; then
  echo "Missing src/. Import the upstream Project: Starfighter source tree first." >&2
  exit 1
fi

rm -rf "$OUT"
mkdir -p "$OUT"

mapfile -t SOURCES < <(find "$ROOT/src" -maxdepth 1 -name '*.c' -print | sort)

emcc "${SOURCES[@]}" \
  -O2 \
  -I"$ROOT/src" \
  -sUSE_SDL=2 \
  -sUSE_SDL_IMAGE=2 \
  -sSDL2_IMAGE_FORMATS='["png","jpg"]' \
  -sUSE_SDL_MIXER=2 \
  -sUSE_SDL_TTF=2 \
  -sALLOW_MEMORY_GROWTH=1 \
  -sFORCE_FILESYSTEM=1 \
  -sEXPORTED_RUNTIME_METHODS='["ccall","cwrap"]' \
  --shell-file "$ROOT/web/shell.html" \
  --preload-file "$ROOT/data@/data" \
  --preload-file "$ROOT/gfx@/gfx" \
  --preload-file "$ROOT/music@/music" \
  --preload-file "$ROOT/sound@/sound" \
  -o "$OUT/index.html"

echo "Web build created in $OUT"
