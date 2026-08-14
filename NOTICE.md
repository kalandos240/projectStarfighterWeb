# Legal notice / Юридическое уведомление

[Русский](#русский) · [English](#english)

## Русский

Этот репозиторий содержит модификации и инструменты сборки для браузерного порта **Project: Starfighter** на WebAssembly/HTML5 с интеграцией **Yandex Games**.

### Происхождение проекта

- Оригинальная игра **Project: Starfighter** была создана Parallel Realities.
- Поддерживаемая свободная версия: [`pr-starfighter/starfighter`](https://github.com/pr-starfighter/starfighter).
- Этот порт воспроизводимо собирается из закреплённой upstream-ревизии:
  `315d0456723e19a153dbc5ef37d5cfb27b4cb36c`.
- Репозиторий с web-портом: [`kalandos240/projectStarfighterWeb`](https://github.com/kalandos240/projectStarfighterWeb).

### Изменения

Данная версия является **модифицированной** версией Project: Starfighter. Изменения включают, в частности:

- сборку исходного C/SDL2-кода в WebAssembly через Emscripten;
- браузерный shell и адаптацию управления;
- UTF-8/кириллический web-рендеринг и русскую локализацию;
- браузерные локальные сохранения;
- интеграцию Yandex Games SDK, Player Data, lifecycle и рекламы;
- CI/CD, автоматические проверки и упаковку браузерного релиза.

Дата данного уведомления о модификации: **14 августа 2026 года**.

### Лицензии

Исходный код Project: Starfighter распространяется на условиях **GNU General Public License version 3 or later (GPL-3.0-or-later)**.

Если для конкретного файла этого порта не указано иное, изменения исходного кода и связанные с ними материалы порта распространяются на условиях, совместимых с **GPL-3.0-or-later**.

Полный текст GNU GPL v3 находится в [`LICENSE`](LICENSE).

Графика, музыка, звуки, шрифты и другие ресурсы могут иметь собственные лицензии и авторов. Их исходный перечень из закреплённой upstream-ревизии находится в [`LICENSES`](LICENSES). Отдельно сохранены [`IPA_FONT_LICENSE.txt`](IPA_FONT_LICENSE.txt) и [`CREDITS.txt`](CREDITS.txt).

Этот порт не переоформляет права на сторонние ресурсы на автора порта: соответствующие авторские права и условия лицензий сохраняются за их первоначальными правообладателями и авторами.

**Yandex Games** является платформой распространения и не является автором или правообладателем Project: Starfighter либо данного порта, если явно не указано иное.

---

## English

This repository contains modifications and build tooling for a **Project: Starfighter** WebAssembly/HTML5 browser port with **Yandex Games** integration.

### Project origin

- The original **Project: Starfighter** game was created by Parallel Realities.
- The maintained libre version is available at [`pr-starfighter/starfighter`](https://github.com/pr-starfighter/starfighter).
- This port is reproducibly built from the pinned upstream revision:
  `315d0456723e19a153dbc5ef37d5cfb27b4cb36c`.
- Web-port repository: [`kalandos240/projectStarfighterWeb`](https://github.com/kalandos240/projectStarfighterWeb).

### Modifications

This is a **modified** version of Project: Starfighter. The changes include, among other things:

- compiling the original C/SDL2 code to WebAssembly with Emscripten;
- a browser shell and browser-specific control adaptations;
- UTF-8/Cyrillic browser rendering and Russian localization;
- browser-local persistence;
- Yandex Games SDK, Player Data, lifecycle and advertisement integration;
- CI/CD, automated validation and browser-release packaging.

Modification notice date: **14 August 2026**.

### Licensing

Project: Starfighter source code is distributed under the **GNU General Public License version 3 or later (GPL-3.0-or-later)**.

Unless a particular file states otherwise, source-code modifications and related porting material in this repository are distributed under terms compatible with **GPL-3.0-or-later**.

The full GNU GPL v3 text is provided in [`LICENSE`](LICENSE).

Graphics, music, sound, fonts and other assets may have separate licenses and authors. The authoritative upstream asset-license manifest from the pinned revision is preserved in [`LICENSES`](LICENSES). [`IPA_FONT_LICENSE.txt`](IPA_FONT_LICENSE.txt) and [`CREDITS.txt`](CREDITS.txt) are also preserved separately.

This port does not reassign third-party asset rights to the port maintainer. Copyright and license terms for those resources remain with their respective original authors and rightsholders.

**Yandex Games** is a distribution platform and is not the author or rightsholder of Project: Starfighter or this port unless explicitly stated otherwise.
