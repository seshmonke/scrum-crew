# Карта спринта 99 (dry-run)

> **Dry-run example.** Показывает, что увидит новый агент в середине
> спринта. Не связан с реальным state/board проекта.

> **Context:** `status: active` · `updated: 2026-11-28` · `owner: SM` ·
> `sprint: 99` · `task: 99.1` · `change: No spec change: docs/example` ·
> links: [state](../../state.json) · [board](../../board.json) ·
> [sprint](sprint.md)

## Сейчас

- Phase: BUILDING
- Sprint: 99
- Goal: показать путь нового агента по карте входа
- Next gate: REVIEW
- WIP: 1
- Active tasks: 99.1
- Blocked: —

## Начни здесь (5–6 ссылок)

1. [state.json](../../state.json) — phase, sprint, cycle, stop.
2. [board.json](../../board.json) — задача, owner, PR, статус.
3. [sprint.md](sprint.md) — Goal, задача, trace-таблица.
4. [brief.md](tasks/99.1/brief.md) — objective, AC, owns, evidence.
5. `No spec change: docs/example` — поведение не меняется.
6. [DoD (шаблон)](../../../template/docs/quality/dod.md) — что считается
   Done.

## Путь нового агента

1. Этот README: phase, sprint, task, next gate.
2. [brief](tasks/99.1/brief.md): objective, AC, owns, evidence.
3. `No spec change: docs/example` — что меняется (ничего).
4. [evidence](tasks/99.1/evidence/) и [review](../../reviews/99-99.1.md) —
   доказательства и вердикт.

Ответ на «где я, какая задача, где evidence, что меняется» — три ссылки:
README → brief → `No spec change`; evidence — внутри brief/report.

## Вопрос → файл

| Вопрос | Файл |
|---|---|
| Где я и какая фаза? | [state.json](../../state.json) |
| Какая задача, owner, PR? | [board.json](../../board.json), [brief](tasks/99.1/brief.md) |
| Что меняется? | `No spec change: docs/example` |
| Где evidence? | [tasks/99.1/evidence/](tasks/99.1/evidence/) |
| Где review? | [reviews/99-99.1.md](../../reviews/99-99.1.md) |
| Что считается Done? | [DoD (шаблон)](../../../template/docs/quality/dod.md) |

## Что не читать

- `events.jsonl` как нарратив — только `tail`/`grep` по событию.
- Весь репозиторий «на всякий случай».
- `/tmp`, чат и логи сессий как источник истины.
- Чужие task-папки и старые спринты без причины.
- Копии метрик/размеров/API — читай источник.
