# Yandex Games integration

The release build is packaged as a standalone archive for hosting by Yandex Games.

## SDK

The Emscripten shell loads the platform-provided SDK from:

```html
<script src="/sdk.js"></script>
```

The production bridge initializes it with `YaGames.init()` and keeps a local browser fallback when the SDK is unavailable during direct-file QA.

## Loading lifecycle

`ysdk.features.LoadingAPI.ready()` is sent only after the Starfighter title/runtime setup is complete and the player can interact with the game. A guard prevents duplicate ready calls if SDK initialization and game initialization complete in a different order.

## Gameplay lifecycle

The browser bridge tracks two pieces of state:

- whether real mission gameplay is desired;
- whether the Yandex platform currently has the game paused.

`GameplayAPI.start()` is reported only while a mission is actively playable and the platform is not paused. `GameplayAPI.stop()` is reported for native pause, platform pause, mission exit and fullscreen advertising. The CI smoke test verifies the start → platform pause/stop → resume/start sequence.

## Platform pause/resume

The bridge subscribes to:

- `game_api_pause`
- `game_api_resume`

The C game loop waits while the platform is paused and pauses SDL_mixer music/channels during that interval. GameplayAPI reporting follows the same pause state.

## Local saves

The original Starfighter save format is retained. The browser build stores files under:

```text
/home/web_user/.config/starfighter
```

That directory is mounted as IDBFS with automatic persistence. CI writes a marker, reloads the whole page and verifies that the marker survives.

## Yandex Player Data cloud saves

The production bridge mirrors the native Starfighter save slots to Player Data under the versioned key:

```text
starfighterCloudSaveV1
```

The payload contains native `save00.sav` through `save05.sav` when present, the Starfighter config file and an `updatedAt` timestamp. Cloud writes are debounced and use `setData(..., true)`.

On startup, local IDBFS data is loaded first. Cloud data is applied only when it is newer than the local progress timestamp. A startup guard prevents a slow cloud response from overwriting a session that has already begun.

## Advertising

Fullscreen advertising is requested only through the mission-boundary hook. It is not shown during active combat. The helper:

- waits at least 60 seconds from session start;
- applies a 120-second interstitial cooldown;
- pauses the platform/gameplay state while the ad is open;
- restores focus and platform state on close/error.

The CI test double verifies the open/close lifecycle and confirms GameplayAPI remains stopped between missions.

## Release package validation

The canonical workflow rejects a release when:

- `index.html` is not at archive root;
- a release path contains spaces or non-ASCII characters;
- the uncompressed payload reaches 100,000,000 bytes.

Only runtime assets are staged. The unused desktop TTF and `music/sources` project files are not embedded in the shipped browser build.

The release archive also keeps upstream license/attribution notices alongside `index.html`.
