# Project: Starfighter — Web / Yandex Games

[![WebAssembly build](https://github.com/kalandos240/projectStarfighterWeb/actions/workflows/web-build-readable.yml/badge.svg)](https://github.com/kalandos240/projectStarfighterWeb/actions/workflows/web-build-readable.yml)

Browser/WebAssembly port of **Project: Starfighter** for **Yandex Games**.

The goal of this repository is to preserve the original libre game and gameplay while adapting the SDL2 desktop codebase to the browser, persistent web storage, and the Yandex Games SDK.

## Upstream

- Project: [pr-starfighter/starfighter](https://github.com/pr-starfighter/starfighter)
- Pinned upstream commit: `315d0456723e19a153dbc5ef37d5cfb27b4cb36c`
- The upstream source is fetched at the exact pinned revision during CI builds.
- Browser-specific changes are applied as reproducible patch scripts from this repository.

## Current web-port status

Working and continuously tested:

- Emscripten/WebAssembly build of the original C/SDL2 game.
- SDL2 rendering, SDL2_image assets, SDL2_mixer music and OGG sound.
- Original title animation and main menu in Chromium.
- Real keyboard input through the browser into the SDL2 event path.
- Yandex Games SDK loading from `/sdk.js`.
- `LoadingAPI.ready()` lifecycle integration.
- `GameplayAPI.start()` / `GameplayAPI.stop()` around actual mission gameplay.
- `game_api_pause` / `game_api_resume` handling with game-loop and audio pause support.
- Browser persistence using IDBFS.
- Yandex Player Data cloud backup/restore for Starfighter save slots.
- Conflict-safe cloud restore: late network responses cannot overwrite an already-running session.
- Fullscreen Yandex interstitial hook only at mission boundaries, never during active combat.
- Automatic GitHub Actions build, Chromium runtime smoke test, ZIP packaging, and artifact upload.

The current release archive is roughly **37 MiB compressed** and about **42.7 MB unpacked**, comfortably below the Yandex Games package limit.

## Build pipeline

`.github/workflows/web-build-readable.yml` is the canonical build definition. It:

1. Checks out this repository.
2. Checks out the pinned upstream Starfighter revision.
3. Installs Emscripten.
4. Applies the browser/Yandex patches from `scripts/`.
5. Builds the original game and runtime assets into `dist/`.
6. Starts the build in headless Chromium and verifies the first rendered frame and keyboard navigation to the real main menu.
7. Packages `starfighter-yandexgames.zip`.

The resulting Yandex archive contains `index.html`, WebAssembly/runtime files, and the upstream `COPYING` and `LICENSES` notices.

## Port architecture

- `web/shell.html` — Emscripten page shell and canvas integration.
- `web/platform-pre-release.txt` — production Yandex lifecycle, storage and cloud-save bridge.
- `scripts/patch_web_release.py.txt` — browser adaptations applied to the pinned upstream C source at build time.
- `scripts/patch_menu_marker.py.txt` — browser QA marker and small upstream cleanups.
- `scripts/patch_ads.py.txt` — mission-boundary Yandex advertisement hook.
- `scripts/cdp-smoke.js.txt` — Chromium DevTools runtime/input smoke test.
- `docs/` — implementation and Yandex integration notes.

## Remaining work before release

- Enable the prepared Pango-free Unicode/SDL_ttf path and add a Russian localization.
- Expand automated gameplay QA beyond the main menu into complete mission transitions.
- Test cloud saves and advertising inside the real Yandex Games test environment.
- Final moderation pass, metadata, screenshots, icon/cover, and release ZIP validation.

The current browser build uses Emscripten `ASYNCIFY` as a compatibility layer for the original blocking SDL game loops. Replacing it with a native browser state machine is an optimization task, not a blocker for the current functional port.

## Licensing

Project: Starfighter code is distributed under **GNU GPL v3 or later**. Individual graphics, music, sound and font assets use several libre licenses documented by upstream in `LICENSES`.

This web port keeps the upstream licensing notices, identifies the exact source revision used to build the game, and publishes the browser-specific source/patches required to reproduce the modified build.
