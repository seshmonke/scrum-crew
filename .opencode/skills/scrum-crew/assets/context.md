# Карта спринта

> **Context:** `status: active` · `updated: YYYY-MM-DD` · `owner: SM` ·
> `sprint: NN` · `task: —` · `change: —` ·
> links: [state](state.json) · [board](board.json) ·
> [INDEX](../docs/tasks/INDEX.md)

## Сейчас

- Phase: INIT / PLANNING / READY / BUILDING / BLOCKED / REVIEW / RETRO /
  CLOSED
- Sprint: NN
- Goal: одна наблюдаемая фраза
- Next gate: …
- WIP: N (потолок 6; цель 1–2)
- Active tasks: NN.1, NN.2
- Blocked: …

## Начни здесь (5–6 ссылок)

На Init ссылки: state → board → `docs/concept/product.md` →
`docs/tasks/INDEX.md` → `docs/quality/dod.md` → `openspec/config.yaml`.
Sprint/brief/change появляются в Planning.

1. [state.json](state.json) — phase, sprint, cycle, stop.
2. [board.json](board.json) — задачи, owner, PR, статус.
3. [sprint.md](sprints/NN/sprint.md) — Goal, PBI, trace-таблица, гейты.
4. [brief.md](sprints/NN/tasks/NN.1/brief.md) — задача, AC, owns, evidence.
5. [change](../openspec/changes/NN-…/proposal.md) — что меняется; или
   `No spec change: <причина>`.
6. [DoD](../docs/quality/dod.md) — что считается Done.

## Вопрос → файл

| Вопрос | Файл |
|---|---|
| Где я и какая фаза? | [state.json](state.json) |
| Какая задача, owner, PR? | [board.json](board.json), [brief](sprints/NN/tasks/NN.1/brief.md) |
| Что меняется? | [change](../openspec/changes/NN-…/proposal.md) |
| Где evidence? | `sprints/NN/tasks/NN.1/evidence/`, `report.md` |
| Что было раньше? | `sprints/`, `openspec/changes/archive/` |
| Что считается Done? | [DoD](../docs/quality/dod.md) |
| Почему так решили? | `docs/stack/adr/`, `design.md` |

## Что не читать

- `events.jsonl` как нарратив — только `tail`/`grep` по событию.
- Весь репозиторий «на всякий случай».
- `/tmp`, чат и логи сессий как источник истины.
- Чужие task-папки, старые спринты и закрытые changes без причины.
- Копии метрик/размеров/API — читай источник.

## Правила карты

- Пишет только SM/оркестратор на границах фаз.
- Только ссылки и снимок; факты — в host-файлах.
- Устаревшая фаза, несовпадение с `state.json`/`board.json` или битая
  ссылка — провал гейта.
- При конфликте источник (`state.json`, `board.json`, `sprint.md`) важнее
  карты; карта правится сразу.
- Смена активной задачи — обновить `Active tasks` и ссылку на brief.

## Свежесть

- `status: active` — карта текущего спринта.
- После `CLOSED` — `status: done`; карта указывает на итоговый `sprint.md`.
- `superseded` — только если карта заменена новой; дать ссылку.
- `updated` меняется при каждом обновлении на границе фазы.
