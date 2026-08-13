# Web porting plan

Pinned upstream commit: `315d0456723e19a153dbc5ef37d5cfb27b4cb36c`.

## Work stages

1. Import the current libre upstream source tree and runtime assets with all license and attribution files intact.
2. Add an Emscripten/WebAssembly target for SDL2, SDL2_image, SDL2_mixer and SDL2_ttf.
3. Remove Pango from the web target by replacing its Unicode line-breaking use with a small UTF-8-aware wrapper.
4. Convert native blocking title/intermission/mission loops to a browser-safe frame-driven state machine.
5. Replace desktop config/save paths with browser persistence while keeping the Starfighter save format where practical.
6. Mirror saves to Yandex Games Player Data after SDK initialization.
7. Handle LoadingAPI, GameplayAPI and platform pause/resume events through the JavaScript bridge.
8. Add and test a Russian localization.
9. Produce a root-level `index.html` release package and run full QA/moderation checks.

## Status

- [x] Repository initialized
- [x] Upstream revision pinned
- [ ] Upstream source/assets imported
- [ ] First native build reproduced
- [ ] First WebAssembly build
- [ ] Main loop converted
- [ ] Browser persistence working
- [ ] Yandex cloud saves connected
- [ ] Russian localization
- [ ] Release QA
