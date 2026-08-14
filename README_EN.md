<div align="center">

# 🚀 Project: Starfighter — Web / Yandex Games

**A WebAssembly/HTML5 browser port of the libre Project: Starfighter game for Yandex Games**

[![WebAssembly build](https://github.com/kalandos240/projectStarfighterWeb/actions/workflows/web-build-readable.yml/badge.svg)](https://github.com/kalandos240/projectStarfighterWeb/actions/workflows/web-build-readable.yml)
[![Russian localization audit](https://github.com/kalandos240/projectStarfighterWeb/actions/workflows/i18n-audit.yml/badge.svg)](https://github.com/kalandos240/projectStarfighterWeb/actions/workflows/i18n-audit.yml)
![WebAssembly](https://img.shields.io/badge/WebAssembly-Emscripten-654FF0?logo=webassembly&logoColor=white)
![Platform](https://img.shields.io/badge/platform-Yandex%20Games-FFCC00)
![License](https://img.shields.io/badge/license-GPL--3.0--or--later-blue)

[Русский](README.md) · **English** · [Documentation](docs/README.md) · [Upstream project](https://github.com/pr-starfighter/starfighter)

</div>

---

## About

This repository contains a browser port of **Project: Starfighter**, the classic space shoot ’em up originally created by Parallel Realities. The modern libre version is maintained by the [`pr-starfighter/starfighter`](https://github.com/pr-starfighter/starfighter) project.

The goal of this repository is to preserve the original gameplay and libre assets while adapting the SDL2 codebase for browser execution and publication on **Yandex Games**.

The port is built with **Emscripten** into WebAssembly and launches directly from `index.html`. The release does not require a dedicated game server.

> This repository is an independent web port and is not an official project of Yandex or the upstream Project: Starfighter maintainers.

## ✨ Implemented features

- 🎮 original Project: Starfighter gameplay based on the C/SDL2 codebase;
- 🌐 WebAssembly/HTML5 build via Emscripten;
- 📦 standalone release with `index.html` at the archive root;
- 🇷🇺 Russian localization for the active game content;
- 🖥️ browser-adapted keyboard and mouse controls;
- 💾 local persistence through IDBFS;
- ☁️ backup and restore through Yandex Player Data;
- 🟨 Yandex Games SDK integration;
- ⏯️ correct `LoadingAPI` and `GameplayAPI` lifecycle handling;
- 📢 fullscreen advertisements only at safe mission boundaries;
- 🔇 game-loop and audio pause handling while the platform or an ad is paused;
- 🧪 automated Chromium smoke testing through a real gameplay path;
- 📏 automated ZIP structure and release-size validation;
- ⚖️ preserved licensing and attribution for libre game assets.

## 🎯 Port status

The port is currently a **Yandex Games release candidate**. The main CI pipeline builds the real WebAssembly release and drives the browser from the title screen through the menus and into actual mission gameplay.

The latest verified CI build completed successfully on **August 14, 2026**. The badges at the top of this README show the current build state.

Before a public release, the generated ZIP still needs final verification inside the real Yandex Games environment for SDK availability, authenticated Player Data, advertisements, and platform moderation.

## 🕹️ Browser controls

| Action | Controls |
|---|---|
| Move | `WASD` or arrow keys |
| Primary fire | `Space` or left mouse button |
| Secondary weapon | `Ctrl` or right mouse button |
| Switch weapon | `E` or `Shift` |
| Pause | `Esc` |

The loading screen also displays the web control scheme before gameplay starts.

## 📦 Yandex Games release

CI produces `starfighter-yandexgames.zip`. The release keeps `index.html` directly at the archive root while the game assets and WebAssembly payload are embedded into the page.

Main release layout:

```text
starfighter-yandexgames.zip
├── index.html
├── COPYING
├── LICENSES
├── CREDITS.txt
└── IPA_FONT_LICENSE.txt
```

This minimizes fragile runtime dependencies and allows the game to launch directly through `index.html`.

## 🏗️ Port architecture

```text
projectStarfighterWeb/
├── .github/workflows/     # CI build, runtime QA and localization audit
├── docs/                  # porting and Yandex Games documentation
├── scripts/               # reproducible source patches and QA scripts
├── web/                   # web shell, Yandex bridge, i18n and build script
├── UPSTREAM_COMMIT        # pinned upstream revision
├── README.md              # Russian README
└── README_EN.md           # English README
```

### Key components

| Component | Purpose |
|---|---|
| `web/shell.html` | Emscripten shell, canvas, loading UI and web bridge |
| `web/platform-pre-release.txt` | Yandex lifecycle, IDBFS and cloud-save bridge |
| `web/web_i18n.c.txt` | browser-side Russian translation catalog |
| `scripts/patch_web_release.py.txt` | primary browser adaptations for upstream sources |
| `scripts/patch_web_controls.py.txt` | keyboard and mouse mapping for the web build |
| `scripts/patch_ads.py.txt` | mission-boundary advertisement integration |
| `scripts/cdp-smoke.js.txt` | end-to-end Chromium runtime testing |
| `web/build.sh` | local release build entry point |

## 🔧 Build pipeline

The canonical release build is defined in:

[`web-build-readable.yml`](.github/workflows/web-build-readable.yml)

The pipeline:

1. checks out this repository and the exact pinned upstream revision;
2. audits Russian localization coverage;
3. installs Emscripten;
4. applies the browser/Yandex source patches;
5. stages runtime-only assets;
6. builds the WebAssembly release;
7. runs the Chromium smoke test;
8. verifies SDK lifecycle, persistence and advertising behavior;
9. validates archive structure and release size;
10. uploads the finished ZIP as a GitHub Actions artifact.

For local builds:

```bash
bash web/build.sh
```

A reproducible local build requires an Emscripten environment and the dependencies installed by CI.

## 📚 Documentation

- [`docs/PORTING.md`](docs/PORTING.md) — port architecture and implementation notes;
- [`docs/YANDEX.md`](docs/YANDEX.md) — Yandex Games SDK integration;
- [`docs/MODERATION.md`](docs/MODERATION.md) — release and moderation checks;
- [`docs/README.md`](docs/README.md) — bilingual documentation index.

## 🔗 Upstream

This repository does not keep a separately modified copy of the full upstream source tree. Instead, CI fetches one exact upstream revision and applies the browser-specific patches from this repository in a reproducible way.

- **Upstream:** [`pr-starfighter/starfighter`](https://github.com/pr-starfighter/starfighter)
- **Pinned commit:** `315d0456723e19a153dbc5ef37d5cfb27b4cb36c`
- **Pin file:** [`UPSTREAM_COMMIT`](UPSTREAM_COMMIT)

## ⚖️ Licensing

Project: Starfighter source code is distributed under **GNU GPL v3 or later**. Graphics, music, sound and font assets use their respective libre licenses documented by the upstream project in `LICENSES`.

The release archive preserves the required license and attribution files. This repository also records the exact upstream revision and publishes the source/patches needed to reproduce the modified browser build.

## ❤️ Credits

Thanks to:

- **Parallel Realities** for the original Project: Starfighter;
- the **pr-starfighter** contributors for maintaining a fully libre version of the game;
- the creators of the libre graphics, music, sound and font assets credited by the upstream project.

---

<div align="center">

**Project: Starfighter → WebAssembly → Yandex Games**

[Русская версия](README.md) · [Technical documentation](docs/README.md)

</div>
