# Project: Starfighter — Web / Yandex Games

[![WebAssembly build](https://github.com/kalandos240/projectStarfighterWeb/actions/workflows/web-build-readable.yml/badge.svg)](https://github.com/kalandos240/projectStarfighterWeb/actions/workflows/web-build-readable.yml)
[![Russian localization audit](https://github.com/kalandos240/projectStarfighterWeb/actions/workflows/i18n-audit.yml/badge.svg)](https://github.com/kalandos240/projectStarfighterWeb/actions/workflows/i18n-audit.yml)

Browser/WebAssembly port of **Project: Starfighter** for **Yandex Games**.

This repository preserves the original libre game and gameplay while adapting the SDL2 desktop codebase to WebAssembly, browser persistence, Russian localization and the Yandex Games SDK.

## Upstream

- Project: [pr-starfighter/starfighter](https://github.com/pr-starfighter/starfighter)
- Pinned upstream commit: `315d0456723e19a153dbc5ef37d5cfb27b4cb36c`
- CI fetches that exact upstream revision for every release build.
- Browser-specific changes are applied reproducibly from the patch and bridge files in this repository.

## Release status

The web port is code-complete as a Yandex Games release candidate and is continuously tested in Chromium.

Validated automatically:

- Emscripten/WebAssembly build of the original C/SDL2 game.
- SDL2 rendering, SDL2_image graphics and SDL2_mixer OGG music/sound.
- Direct `file://index.html` startup, matching the standalone archive deployment model.
- Original title sequence, main menu, new-game flow, difficulty selection and entry into real mission gameplay.
- Browser-native UTF-8/Cyrillic rendering with compact web-specific briefing labels.
- Complete Russian coverage of the active upstream gettext catalog: **0 missing translatable entries** in the strict POT audit.
- Legacy `-oldscript` dialogue is not exposed by the browser build; the active web campaign uses the audited localized script.
- Yandex SDK loading from `/sdk.js`.
- `LoadingAPI.ready()` after the game becomes interactive.
- `GameplayAPI.start()` / `GameplayAPI.stop()` around real mission gameplay.
- Gameplay markup is stopped while the platform is paused or a fullscreen ad is open and resumed only when appropriate.
- `game_api_pause` / `game_api_resume` handling with game-loop and audio pause support.
- IDBFS local persistence across a full page reload.
- Yandex Player Data cloud backup/restore for Starfighter save slots, with timestamp conflict protection.
- Fullscreen interstitial hook at mission boundaries only, never during active combat.
- Release payload validation: `index.html` in archive root, ASCII paths without spaces and uncompressed size below 100 MB.
- Runtime-only asset staging: unused font data and `music/sources` project files are excluded from the shipped game.
- GPL and asset attribution notices included in the release archive.

A validated release build currently packages **5 files**, approximately **34.9 MB compressed** and **48.0 MB uncompressed**.

## Browser controls

| Action | Controls |
|---|---|
| Move | `WASD` or arrow keys |
| Primary fire | `Space` or left mouse button |
| Secondary weapon | `Ctrl` or right mouse button |
| Switch weapon | `E` or `Shift` |
| Pause | `Esc` |

The loading screen also shows the web control scheme before gameplay starts.

## Build pipeline

`.github/workflows/web-build-readable.yml` is the canonical release build. It:

1. Checks out this repository and the exact pinned upstream revision.
2. Runs the strict Russian localization audit against upstream `pr-starfighter.pot`.
3. Installs Emscripten.
4. Applies the browser/Yandex source patches.
5. Stages only runtime graphics, sound, music and credits data.
6. Builds a single-file `dist/index.html` WebAssembly release.
7. Runs headless Chromium through title → menu → new game → difficulty → real mission gameplay.
8. Verifies Yandex GameplayAPI pause/resume semantics, Player Data cloud-save writes and fullscreen-ad lifecycle with a deterministic SDK test double.
9. Persists an IDBFS marker, reloads the page and verifies it survived.
10. Validates archive paths and the uncompressed Yandex payload limit.
11. Packages `starfighter-yandexgames.zip` and uploads the release plus QA diagnostics as a workflow artifact.

The fast `.github/workflows/i18n-audit.yml` workflow separately prevents untranslated upstream catalog entries from being introduced without waiting for a full WebAssembly build.

## Port architecture

- `web/shell.html` — Emscripten page shell, responsive 4:3 canvas, loading/control hint and mission-boundary ad helper.
- `web/platform-pre-release.txt` — production Yandex lifecycle, GameplayAPI, IDBFS and cloud-save bridge.
- `web/web_i18n.c.txt` and `web/i18n-*.inc` — browser Russian translation catalog.
- `web/web_ngettext.c.txt` — browser Russian plural/quantity strings.
- `scripts/audit_i18n.py.txt` — strict comparison against the pinned upstream gettext POT catalog.
- `scripts/patch_web_release.py.txt` — browser/Yandex adaptations applied to the pinned upstream C source.
- `scripts/patch_browser_text.py.txt` — Pango-free Canvas UTF-8/Cyrillic renderer used by the WebAssembly build.
- `scripts/patch_web_controls.py.txt` — web keyboard/mouse control mapping.
- `scripts/patch_ads.py.txt` — mission-boundary advertisement hook.
- `scripts/cdp-smoke.js.txt` — end-to-end Chromium runtime and platform-integration QA.
- `web/build.sh` — local release build matching the CI pipeline.
- `docs/` — implementation and Yandex integration notes.

The current browser build uses Emscripten `ASYNCIFY` as a compatibility layer for the original blocking SDL loops. This preserves the original game flow while allowing browser scheduling and platform pause handling.

## Release archive

The Yandex upload ZIP contains only:

- `index.html`
- `COPYING`
- `LICENSES`
- `CREDITS.txt`
- `IPA_FONT_LICENSE.txt`

Runtime game assets and WebAssembly code are embedded into `index.html`, so there are no fragile external runtime paths apart from the platform-provided `/sdk.js`.

## What still requires the real Yandex environment

CI can validate the integration contract and browser runtime, but it cannot impersonate Yandex moderation. Before public release, the generated ZIP still needs to be uploaded to the Yandex Games console and exercised in its real test environment for SDK availability, ads, authenticated Player Data and final moderation behavior.

## Licensing

Project: Starfighter code is distributed under **GNU GPL v3 or later**. Individual graphics, music, sound and font assets use several libre licenses documented by upstream in `LICENSES`.

This web port keeps the upstream licensing notices, identifies the exact source revision used to build the game, and publishes the browser-specific source/patches required to reproduce the modified build.
