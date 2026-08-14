#!/usr/bin/env bash
set -euo pipefail

PORT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE_ROOT="${1:-$PORT_ROOT/upstream}"
OUT="$PORT_ROOT/dist"
ASSETS="$PORT_ROOT/runtime-assets"

if [ ! -d "$SOURCE_ROOT/src" ]; then
  echo "Missing pinned Starfighter source tree: $SOURCE_ROOT/src" >&2
  echo "Checkout pr-starfighter/starfighter at 315d0456723e19a153dbc5ef37d5cfb27b4cb36c into $PORT_ROOT/upstream" >&2
  exit 1
fi

if [ "$(cd "$SOURCE_ROOT" && pwd)" != "$PORT_ROOT/upstream" ]; then
  echo "Release patch scripts expect the source checkout at $PORT_ROOT/upstream" >&2
  exit 1
fi

for dir in data gfx music sound; do
  test -d "$SOURCE_ROOT/$dir" || { echo "Missing runtime directory: $SOURCE_ROOT/$dir" >&2; exit 1; }
done

rm -rf "$OUT" "$ASSETS"
mkdir -p "$OUT" "$ASSETS/data" "$ASSETS/gfx" "$ASSETS/sound" "$ASSETS/music"

cd "$PORT_ROOT"
python3 scripts/patch_hardcoded_ui.py.txt
python3 scripts/audit_i18n.py.txt --strict --strict-ui
python3 scripts/patch_web_release.py.txt
python3 scripts/patch_menu_marker.py.txt

cp "$SOURCE_ROOT/data/credits.txt" "$ASSETS/data/"
find "$SOURCE_ROOT/gfx" -maxdepth 1 -type f \( -name '*.png' -o -name '*.jpg' \) -exec cp {} "$ASSETS/gfx/" \;
find "$SOURCE_ROOT/sound" -maxdepth 1 -type f -name '*.ogg' -exec cp {} "$ASSETS/sound/" \;
find "$SOURCE_ROOT/music" -maxdepth 1 -type f -name '*.ogg' -exec cp {} "$ASSETS/music/" \;

test "$(find "$ASSETS/music" -type f -name '*.ogg' | wc -l)" -eq 12
test -s "$ASSETS/data/credits.txt"
test ! -e "$ASSETS/data/TakaoPGothic.ttf"
test ! -e "$ASSETS/music/sources"

mapfile -t SOURCES < <(find "$SOURCE_ROOT/src" -maxdepth 1 -name '*.c' -print | sort)

emcc "${SOURCES[@]}" \
  -I"$SOURCE_ROOT/src" \
  -DVERSION='"2.5-web1"' \
  -DDATADIR='"/"' \
  -DNOFONT \
  -O2 \
  -sUSE_SDL=2 \
  -sUSE_SDL_IMAGE=2 \
  -sSDL2_IMAGE_FORMATS='["png","jpg"]' \
  -sUSE_SDL_MIXER=2 \
  -sSDL2_MIXER_FORMATS='["ogg"]' \
  -sASYNCIFY \
  -sALLOW_MEMORY_GROWTH=1 \
  -sFORCE_FILESYSTEM=1 \
  -sEXIT_RUNTIME=0 \
  -sSINGLE_FILE=1 \
  -sSINGLE_FILE_BINARY_ENCODE=0 \
  -sEXPORTED_FUNCTIONS='["_main","_save"]' \
  -lidbfs.js \
  --pre-js "$PORT_ROOT/web/platform-pre-release.txt" \
  --embed-file "$ASSETS/data@/data" \
  --embed-file "$ASSETS/gfx@/gfx" \
  --embed-file "$ASSETS/sound@/sound" \
  --embed-file "$ASSETS/music@/music" \
  --shell-file "$PORT_ROOT/web/shell.html" \
  -o "$OUT/index.html"

cp "$SOURCE_ROOT/COPYING" "$SOURCE_ROOT/LICENSES" "$OUT/"

test -s "$OUT/index.html"
python3 - <<'PY'
from pathlib import Path
root = Path('dist')
release = [p for p in root.rglob('*') if p.is_file() and not p.name.startswith('runtime-') and p.name != 'i18n-audit.txt']
assert root / 'index.html' in release
bad = [p.relative_to(root).as_posix() for p in release if ' ' in p.relative_to(root).as_posix() or any(ord(c) > 127 for c in p.relative_to(root).as_posix())]
total = sum(p.stat().st_size for p in release)
print(f'Uncompressed release bytes: {total}')
assert not bad, bad
assert total < 100_000_000, total
PY

rm -f "$PORT_ROOT/starfighter-yandexgames.zip"
(
  cd "$OUT"
  zip -9 -r "$PORT_ROOT/starfighter-yandexgames.zip" . -x 'runtime-*' -x 'i18n-audit.txt'
)

echo "Web build created in $OUT"
echo "Yandex archive created at $PORT_ROOT/starfighter-yandexgames.zip"
