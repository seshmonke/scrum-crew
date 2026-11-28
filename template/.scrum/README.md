# Карта проекта

> **Context:** `status: active` · `updated: YYYY-MM-DD` · `owner: SM` ·
> `sprint: —` · `task: —` · `change: —` ·
> links: [state](state.json) · [board](board.json) · [INDEX](../docs/tasks/INDEX.md)

Карта входа для агентов. Пишет только SM/оркестратор на границах фаз.
Снимок и ссылки; факты — в host-файлах.

## Сейчас

- Phase: INIT
- Sprint: —
- Goal: не определён; сначала Init
- Next gate: Product Goal / сценарий / метрика / non-goals
- WIP: 0
- Active tasks: —
- Blocked: —

## Начни здесь (Init)

1. [state.json](state.json) — phase, sprint, cycle, stop.
2. [board.json](board.json) — задачи, owner, PR.
3. [product.md](../docs/concept/product.md) — Goal, пользователь, сценарий,
   метрика, non-goals.
4. [INDEX.md](../docs/tasks/INDEX.md) — направление и бэклог.
5. [dod.md](../docs/quality/dod.md) — что считается Done.
6. [openspec/config.yaml](../openspec/config.yaml) — конфигурация OpenSpec.

## Когда начнётся спринт

Заменить ссылки на канонические 5–6:

1. `state.json` — фаза, спринт, цикл, stop.
2. `board.json` — задачи, owner, PR, статус.
3. `sprints/NN/sprint.md` — Goal, PBI, trace-таблица.
4. `sprints/NN/tasks/<id>/brief.md` — задача, AC, owns, evidence.
5. `openspec/changes/<id>/proposal.md` — что меняется; или
   `No spec change: <причина>`.
6. `docs/quality/dod.md` — Done.

## Вопрос → файл

| Вопрос | Файл |
|---|---|
| Где я и какая фаза? | [state.json](state.json) |
| Какая задача, owner, PR? | [board.json](board.json) |
| Что меняется? | `openspec/changes/<id>/` |
| Где evidence? | `sprints/NN/tasks/<id>/evidence/` |
| Что считается Done? | [dod.md](../docs/quality/dod.md) |
| Почему так решили? | `docs/stack/adr/`, `design.md` |

## Что не читать

- `events.jsonl` как нарратив — только `tail`/`grep` по событию.
- Весь репозиторий «на всякий случай».
- `/tmp`, чат и логи сессий как источник истины.
- Чужие task-папки и старые спринты без причины.
- Копии метрик/размеров/API — читай источник.

## Правила карты

- Пишет только SM/оркестратор на границах фаз.
- Обновляется при каждой смене phase/sprint/active task.
- Устаревшая фаза, несовпадение с `state.json`/`board.json` или битая
  ссылка — провал гейта.
- При конфликте источник важнее карты; карта правится сразу.
- Шаблон и подробности —
  `.opencode/skills/scrum-crew/references/context.md`.
