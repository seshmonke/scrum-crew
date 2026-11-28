# Карта спринта 99 (dry-run)

> **Dry-run example.** Это не активный спринт продукта. Папка показывает
> форму карты и task workspace; установщик её не копирует. Не использовать
> для реального планирования.

> **Context:** `status: active` · `updated: 2026-11-28` · `owner: SM` ·
> `sprint: 99` · `task: 99.1` · `change: No spec change: docs/example` ·
> links: [state](state.json) · [board](board.json) ·
> [sprint](sprints/99/sprint.md)

## Сейчас

- Phase: BUILDING
- Sprint: 99
- Goal: показать путь нового агента по карте входа
- Next gate: REVIEW
- WIP: 1 (потолок 6)
- Active tasks: 99.1
- Blocked: —

## Начни здесь (5–6 ссылок)

1. [state.json](state.json) — phase, sprint, cycle, stop.
2. [board.json](board.json) — задача, owner, PR, статус.
3. [sprint.md](sprints/99/sprint.md) — Goal, задача, trace-таблица.
4. [brief.md](sprints/99/tasks/99.1/brief.md) — objective, AC, owns,
   evidence.
5. `No spec change: docs/example` — поведение не меняется.
6. [DoD (шаблон)](../template/docs/quality/dod.md) — что считается Done;
   в проекте — `docs/quality/dod.md`.

## Вопрос → файл

| Вопрос | Файл |
|---|---|
| Где я и какая фаза? | [state.json](state.json) |
| Какая задача, owner, PR? | [board.json](board.json), [brief](sprints/99/tasks/99.1/brief.md) |
| Что меняется? | `No spec change: docs/example` |
| Где evidence? | [tasks/99.1/evidence/](sprints/99/tasks/99.1/evidence/) |
| Что считается Done? | [DoD (шаблон)](../template/docs/quality/dod.md) |

## Что не читать

- `events.jsonl` как нарратив — только `tail`/`grep` по событию.
- Весь репозиторий «на всякий случай».
- `/tmp`, чат и логи сессий как источник истины.
- Чужие task-папки и старые спринты без причины.
- Копии метрик/размеров/API — читай источник.

## Правила карты

- Пишет только SM/оркестратор на границах фаз.
- Только ссылки и снимок; факты — в host-файлах.
- Устаревшая фаза, несовпадение с `state.json`/`board.json` или битая
  ссылка — провал гейта.
- При конфликте источник важнее карты; карта правится сразу.
