# Project: Starfighter — Web / Yandex Games Port

Browser/WebAssembly port of **Project: Starfighter** for Yandex Games.

> **Status:** active porting work. The repository is not release-ready yet.

## Upstream

This port is based on the libre Project: Starfighter project maintained at:

- `pr-starfighter/starfighter`
- pinned upstream commit: `315d0456723e19a153dbc5ef37d5cfb27b4cb36c`

The upstream project replaced the historical non-free media and documents asset licensing in its `LICENSES` file.

## Port goals

- Compile the original C/SDL2 game to WebAssembly with Emscripten.
- Preserve original gameplay and game content.
- Replace native blocking loops with a browser-safe main loop/state machine.
- Replace desktop save paths with browser persistence and Yandex Games cloud saves.
- Integrate the current Yandex Games SDK (`/sdk.js`).
- Handle platform pause/resume events correctly.
- Add Yandex gameplay/loading markers.
- Add a Russian localization.
- Keep the final unpacked Yandex Games archive below the platform size limit.
- Preserve all upstream copyright notices, source availability, and asset attributions.

## Repository layout

- `web/` — Emscripten HTML shell and Yandex Games JavaScript bridge.
- `scripts/` — web build/import helpers.
- `docs/` — porting notes and implementation status.
- `src/`, `gfx/`, `sound/`, `music/`, `data/`, `locale/` — upstream game sources/assets after import.

## Licensing

The game code is distributed under **GNU GPL v3 or later**. Media and fonts use several compatible/free licenses documented by upstream (including GPL, CC BY, CC BY-SA, CC0/Public Domain and the IPA Font License).

The web port will preserve the upstream `COPYING`, `LICENSES`, attribution information, and corresponding source code required by the applicable licenses.

## Development

The first stage is infrastructure work: import the pinned upstream source tree, make the SDL2 code compile under Emscripten, then convert the native loop and persistence layer for the browser.

See `docs/PORTING.md` for the current technical plan.
