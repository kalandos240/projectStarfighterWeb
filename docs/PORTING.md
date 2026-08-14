# Web port implementation status

Pinned upstream commit: `315d0456723e19a153dbc5ef37d5cfb27b4cb36c`.

The browser build is produced reproducibly from the pinned upstream source plus the web/Yandex bridge and patch scripts in this repository. The upstream tree does not need to be copied permanently into the port repository; CI checks it out at the exact pinned revision.

## Implemented

- [x] Upstream revision pinned and fetched reproducibly in CI
- [x] Emscripten/WebAssembly build of the original C/SDL2 game
- [x] SDL2_image graphics and SDL2_mixer OGG audio
- [x] Browser-safe execution of the original blocking loops using Emscripten `ASYNCIFY`
- [x] Pango-free browser UTF-8/Cyrillic renderer
- [x] Responsive 4:3 browser canvas
- [x] Web control mapping: WASD, mouse fire, Space/Ctrl, E/Shift and Esc pause
- [x] Desktop-only Quit item removed from the web menu
- [x] IDBFS persistence using the original Starfighter save-file format
- [x] Persistence verified across a full Chromium page reload
- [x] Yandex Player Data cloud backup/restore with timestamp conflict protection
- [x] LoadingAPI integration
- [x] GameplayAPI integration around real mission gameplay
- [x] Platform pause/resume handling with audio/game-loop suspension
- [x] Fullscreen advertisement lifecycle at mission boundaries
- [x] Complete Russian coverage of the active upstream gettext catalog with a strict CI audit
- [x] Browser-specific quantity/plural translations
- [x] Runtime-only asset staging; unused desktop font and music source projects excluded
- [x] Upstream GPL and asset attribution notices included in the release
- [x] Direct `file://index.html` Chromium smoke test through title, menu, difficulty and real mission gameplay
- [x] Automated GameplayAPI, cloud-write and ad-lifecycle semantics test
- [x] Yandex archive path/root/size validation
- [x] Root-level standalone release ZIP generation

## Runtime architecture

The original Starfighter code uses blocking title, intermission, cutscene and game loops. The web release currently preserves those loops with `-sASYNCIFY`, allowing SDL delays and platform pause waits to yield back to the browser. A full conversion to an explicit frame-driven state machine would be an architectural optimization, not a requirement for the current functional port.

The production JavaScript bridge is responsible for:

- Yandex SDK initialization;
- loading/gameplay lifecycle markers;
- platform pause state;
- IDBFS startup synchronization;
- Player Data cloud backup/restore;
- mission-boundary advertising.

Browser-specific C changes are applied reproducibly during the build rather than maintained as a divergent fork of the complete upstream source tree.

## Localization

The build compares the port's Russian table against the pinned upstream `locale/pr-starfighter.pot`. The strict audit fails when a translatable active-campaign entry is missing. The legacy `-oldscript` desktop command-line path is not exposed by the web build.

## Release QA boundary

The repository's automated suite validates the standalone browser runtime and Yandex integration contract with deterministic platform test doubles. The remaining release step is external to this codebase: upload the generated ZIP into the actual Yandex Games console, exercise authenticated SDK/advertising/Player Data behavior in that environment, and submit it for platform moderation.
