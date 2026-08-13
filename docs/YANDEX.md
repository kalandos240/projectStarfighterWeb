# Yandex Games integration notes

The web build is intended for upload to Yandex Games as an archive hosted by Yandex.

## SDK

Use the current relative SDK path in the uploaded game:

```html
<script src="/sdk.js"></script>
```

Initialize with `YaGames.init()` only after the SDK script is loaded.

## Loading marker

Call `ysdk.features.LoadingAPI.ready()` only when the game has finished loading and the player can actually interact with it.

## Gameplay markers

Call `ysdk.features.GameplayAPI.start()` when active mission gameplay starts/resumes and `GameplayAPI.stop()` when gameplay is paused/stopped, including menus and advertising transitions.

## Platform pause/resume

Subscribe to `game_api_pause` and `game_api_resume`. The C/WASM bridge must pause/resume game simulation and audio consistently with these events.

## Saves

The native `saveXX.sav` system will be adapted to browser persistence. Yandex Player Data will be used as a cloud copy of the player's progress once the save bridge is implemented.

Official documentation:

- https://yandex.ru/dev/games/doc/ru/sdk/sdk-about
- https://yandex.ru/dev/games/doc/ru/sdk/sdk-game-events
- https://yandex.ru/dev/games/doc/ru/sdk/sdk-events
- https://yandex.ru/dev/games/doc/ru/sdk/sdk-player
