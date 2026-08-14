# 📚 Документация / Documentation

[← На главную / Back to repository](../README.md) · [English README](../README_EN.md)

Этот каталог содержит техническую документацию браузерного порта **Project: Starfighter** для Яндекс.Игр.

This directory contains the technical documentation for the **Project: Starfighter** browser port targeting Yandex Games.

---

## 🇷🇺 Русский

### Разделы

| Документ | Описание |
|---|---|
| [`PORTING.md`](PORTING.md) | Архитектура порта, Emscripten/WebAssembly и изменения относительно desktop-версии |
| [`YANDEX.md`](YANDEX.md) | Интеграция Yandex Games SDK, lifecycle, сохранения и реклама |
| [`MODERATION.md`](MODERATION.md) | Релизные проверки и заметки для подготовки к модерации Яндекс.Игр |

### Быстрая навигация

Если нужно понять **как устроен сам порт**, начинайте с [`PORTING.md`](PORTING.md).

Если задача связана с **SDK Яндекс.Игр, паузами, рекламой или облачными сохранениями**, смотрите [`YANDEX.md`](YANDEX.md).

Перед загрузкой ZIP в консоль Яндекс.Игр используйте [`MODERATION.md`](MODERATION.md) как технический чек-лист вместе с актуальными требованиями платформы.

---

## 🇬🇧 English

### Sections

| Document | Description |
|---|---|
| [`PORTING.md`](PORTING.md) | Port architecture, Emscripten/WebAssembly and desktop-to-browser adaptations |
| [`YANDEX.md`](YANDEX.md) | Yandex Games SDK lifecycle, persistence and advertising integration |
| [`MODERATION.md`](MODERATION.md) | Release checks and notes for Yandex Games moderation preparation |

### Quick navigation

Start with [`PORTING.md`](PORTING.md) to understand **how the browser port is structured**.

Use [`YANDEX.md`](YANDEX.md) for **Yandex Games SDK, pause/resume behavior, advertisements and cloud saves**.

Before uploading a ZIP to the Yandex Games console, use [`MODERATION.md`](MODERATION.md) as a technical checklist together with the platform's current official requirements.

---

> The implementation is tied to the upstream revision recorded in [`../UPSTREAM_COMMIT`](../UPSTREAM_COMMIT). Build behavior should always be verified against the current CI workflows in [`../.github/workflows/`](../.github/workflows/).
