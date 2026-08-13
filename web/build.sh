#!/usr/bin/env bash
set -euo pipefail

PORT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE_ROOT="${1:-$PORT_ROOT}"
OUT="$PORT_ROOT/dist"

if [ ! -d "$SOURCE_ROOT/src" ]; then
  echo "Missing Starfighter source tree: $SOURCE_ROOT/src" >&2
  exit 1
fi

for dir in data gfx music sound; do
  test -d "$SOURCE_ROOT/$dir" || { echo "Missing runtime directory: $SOURCE_ROOT/$dir" >&2; exit 1; }
done

rm -rf "$OUT"
mkdir -p "$OUT"

mapfile -t SOURCES < <(find "$SOURCE_ROOT/src" -maxdepth 1 -name '*.c' -print | sort)

emcc "${SOURCES[@]}" \
  -O2 \
  -I"$SOURCE_ROOT/src" \
  -DNOFONT \
  -DDATADIR='"/"' \
  -sUSE_SDL=2 \
  -sUSE_SDL_IMAGE=2 \
  -sSDL2_IMAGE_FORMATS='["png","jpg"]' \
  -sUSE_SDL_MIXER=2 \
  -sALLOW_MEMORY_GROWTH=1 \
  -sFORCE_FILESYSTEM=1 \
  -sEXPORTED_RUNTIME_METHODS='["ccall","cwrap"]' \
  --shell-file "$PORT_ROOT/web/shell.html" \
  --preload-file "$SOURCE_ROOT/data@/data" \
  --preload-file "$SOURCE_ROOT/gfx@/gfx" \
  --preload-file "$SOURCE_ROOT/music@/music" \
  --preload-file "$SOURCE_ROOT/sound@/sound" \
  -o "$OUT/index.html"

echo "Web build created in $OUT"
