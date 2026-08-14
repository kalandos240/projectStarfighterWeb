<div align="center">

# 🚀 Project: Starfighter — Web / Yandex Games

**Браузерный WebAssembly/HTML5-порт свободной игры Project: Starfighter для Яндекс.Игр**

[![WebAssembly build](https://github.com/kalandos240/projectStarfighterWeb/actions/workflows/web-build-readable.yml/badge.svg)](https://github.com/kalandos240/projectStarfighterWeb/actions/workflows/web-build-readable.yml)
[![Russian localization audit](https://github.com/kalandos240/projectStarfighterWeb/actions/workflows/i18n-audit.yml/badge.svg)](https://github.com/kalandos240/projectStarfighterWeb/actions/workflows/i18n-audit.yml)
![WebAssembly](https://img.shields.io/badge/WebAssembly-Emscripten-654FF0?logo=webassembly&logoColor=white)
![Platform](https://img.shields.io/badge/platform-Yandex%20Games-FFCC00)
![License](https://img.shields.io/badge/license-GPL--3.0--or--later-blue)

**Русский** · [English](README_EN.md) · [Документация](docs/README.md) · [Оригинальный проект](https://github.com/pr-starfighter/starfighter)

</div>

---

## О проекте

Этот репозиторий содержит браузерный порт **Project: Starfighter** — классического космического shoot ’em up, изначально созданного Parallel Realities. Современная свободная версия игры развивается проектом [`pr-starfighter/starfighter`](https://github.com/pr-starfighter/starfighter).

Цель этого репозитория — сохранить оригинальный игровой процесс и свободные ресурсы, но адаптировать SDL2-версию для запуска в браузере и публикации на **Яндекс.Играх**.

Порт собирается через **Emscripten** в WebAssembly и запускается непосредственно через `index.html`. Релиз не требует собственного игрового сервера.

> Этот репозиторий является отдельным web-портом и не является официальным проектом Яндекса или команды upstream Project: Starfighter.

## ✨ Что уже реализовано

- 🎮 оригинальный игровой процесс Project: Starfighter на базе C/SDL2;
- 🌐 сборка в WebAssembly/HTML5 через Emscripten;
- 📦 автономный релиз с `index.html` в корне архива;
- 🇷🇺 русская локализация активного игрового контента;
- 🖥️ управление с клавиатуры и мыши, адаптированное для браузера;
- 💾 локальные сохранения через IDBFS;
- ☁️ резервное сохранение и восстановление через Yandex Player Data;
- 🟨 интеграция Yandex Games SDK;
- ⏯️ корректная работа `LoadingAPI` и `GameplayAPI`;
- 📢 полноэкранная реклама только на безопасных границах между игровыми этапами;
- 🔇 пауза игрового цикла и звука во время платформенной паузы/рекламы;
- 🧪 автоматический smoke-test реального игрового сценария в Chromium;
- 📏 автоматическая проверка структуры ZIP и ограничения размера релизного пакета;
- ⚖️ сохранение лицензий и атрибуции свободных игровых ресурсов.

## 🎯 Статус порта

Порт находится в состоянии **release candidate для Яндекс.Игр**. Основной CI-пайплайн собирает настоящий WebAssembly-релиз и прогоняет браузерный сценарий от стартового экрана до входа в реальную миссию.

Последняя проверенная сборка CI успешно прошла 14 августа 2026 года. Актуальное состояние всегда видно по бейджам в верхней части README.

Перед публичным релизом остаётся обязательная проверка уже внутри реального окружения Яндекс.Игр: SDK, авторизация игрока, реклама, облачные сохранения и модерация платформы.

## 🕹️ Управление в браузере

| Действие | Управление |
|---|---|
| Движение | `WASD` или стрелки |
| Основной огонь | `Space` или левая кнопка мыши |
| Дополнительное оружие | `Ctrl` или правая кнопка мыши |
| Смена оружия | `E` или `Shift` |
| Пауза | `Esc` |

Схема управления также показывается на загрузочном экране web-версии.

## 📦 Релиз для Яндекс.Игр

CI формирует архив `starfighter-yandexgames.zip`. В релизе `index.html` расположен непосредственно в корне архива, а игровые ресурсы и WebAssembly-код встраиваются в страницу.

Основная структура релизного пакета:

```text
starfighter-yandexgames.zip
├── index.html
├── COPYING
├── LICENSES
├── CREDITS.txt
└── IPA_FONT_LICENSE.txt
```

Такой формат уменьшает количество внешних runtime-зависимостей и позволяет запускать игру напрямую через `index.html`.

## 🏗️ Как устроен порт

```text
projectStarfighterWeb/
├── .github/workflows/     # CI: сборка, тестирование и аудит локализации
├── docs/                  # документация по порту и Яндекс.Играм
├── scripts/               # воспроизводимые патчи и QA-скрипты
├── web/                   # web-shell, Yandex bridge, i18n и build script
├── UPSTREAM_COMMIT        # зафиксированная ревизия оригинального проекта
├── README.md              # русская версия
└── README_EN.md           # English version
```

### Ключевые компоненты

| Компонент | Назначение |
|---|---|
| `web/shell.html` | Emscripten shell, canvas, загрузочный экран и web-интерфейс |
| `web/platform-pre-release.txt` | Yandex SDK lifecycle, IDBFS и облачные сохранения |
| `web/web_i18n.c.txt` | браузерный каталог русской локализации |
| `scripts/patch_web_release.py.txt` | основные браузерные адаптации исходного кода |
| `scripts/patch_web_controls.py.txt` | клавиатура и мышь для web-сборки |
| `scripts/patch_ads.py.txt` | интеграция рекламных пауз между миссиями |
| `scripts/cdp-smoke.js.txt` | end-to-end тестирование в Chromium |
| `web/build.sh` | локальная сборка релизной web-версии |

## 🔧 Сборка

Канонический способ сборки описан в workflow:

[`web-build-readable.yml`](.github/workflows/web-build-readable.yml)

Пайплайн:

1. получает этот репозиторий и зафиксированную upstream-ревизию;
2. проверяет полноту русской локализации;
3. устанавливает Emscripten;
4. применяет web/Yandex-патчи;
5. подготавливает только runtime-ресурсы;
6. собирает WebAssembly-релиз;
7. запускает Chromium smoke-test;
8. проверяет SDK lifecycle, сохранения и рекламу;
9. проверяет структуру и размер релизного архива;
10. публикует готовый ZIP как GitHub Actions artifact.

Для локальной сборки используется:

```bash
bash web/build.sh
```

Для воспроизводимой сборки требуется окружение Emscripten и зависимости, которые устанавливает CI.

## 📚 Документация

- [`docs/PORTING.md`](docs/PORTING.md) — устройство и технические решения web-порта;
- [`docs/YANDEX.md`](docs/YANDEX.md) — интеграция с Yandex Games SDK;
- [`docs/MODERATION.md`](docs/MODERATION.md) — заметки и проверки перед модерацией;
- [`docs/README.md`](docs/README.md) — общий индекс документации на русском и английском.

## 🔗 Upstream

Порт не хранит отдельную изменённую копию всей кодовой базы оригинальной игры. Вместо этого CI получает конкретную зафиксированную upstream-ревизию и воспроизводимо применяет web-патчи из этого репозитория.

- **Upstream:** [`pr-starfighter/starfighter`](https://github.com/pr-starfighter/starfighter)
- **Pinned commit:** `315d0456723e19a153dbc5ef37d5cfb27b4cb36c`
- **Файл фиксации:** [`UPSTREAM_COMMIT`](UPSTREAM_COMMIT)

## ⚖️ Лицензирование

Исходный код Project: Starfighter распространяется на условиях **GNU GPL v3 или более поздней версии**. Графика, музыка, звуки и шрифты имеют собственные свободные лицензии, перечисленные upstream-проектом в `LICENSES`.

Релизный архив сохраняет необходимые файлы лицензий и атрибуции. Этот репозиторий также фиксирует точную upstream-ревизию и содержит исходники/патчи, необходимые для воспроизведения изменённой web-сборки.

## ❤️ Благодарности

Спасибо:

- **Parallel Realities** — за оригинальный Project: Starfighter;
- участникам **pr-starfighter** — за поддерживаемую полностью свободную версию игры;
- авторам свободных графических, музыкальных, звуковых и шрифтовых ресурсов, перечисленным в upstream credits.

---

<div align="center">

**Project: Starfighter → WebAssembly → Yandex Games**

[English README](README_EN.md) · [Техническая документация](docs/README.md)

</div>
