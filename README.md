# Project: Starfighter — Web / Yandex Games port

This repository contains the browser/WebAssembly porting work for **Project: Starfighter** targeting Yandex Games.

Upstream project: `pr-starfighter/starfighter`

Pinned upstream commit: `315d0456723e19a153dbc5ef37d5cfb27b4cb36c`

## Current status

- Yandex-aware Emscripten HTML shell added.
- Initial Emscripten build script added.
- GitHub Actions WebAssembly build scaffold added.
- Upstream source import is in progress using Git tree objects.

## Porting goals

- Preserve original gameplay and assets from the libre Project: Starfighter codebase.
- Build with Emscripten/WebAssembly.
- Replace desktop-only main-loop and filesystem assumptions with browser-compatible implementations.
- Integrate Yandex Games SDK lifecycle, pause/resume and loading markers.
- Add browser persistence and Yandex cloud-save integration.
- Keep all upstream licensing and attribution requirements intact.

## Licensing

Project: Starfighter code is GPLv3-or-later. Individual assets use several libre licenses; their upstream attribution and license notices must remain intact in the final port.
