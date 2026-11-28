# Scrum: правила и артефакты

Источник: Scrum Guide 2020. Церемонии — в `references/cycle.md`.

## Три accountability

- **Product Owner** — ценность, порядок бэклога, Sprint Goal, приёмка.
- **Scrum Master** — процесс, препятствия, ритм, доска.
- **Developers** — код, тесты, дизайн, инфраструктура, проверка.

Остальные роли — специализации внутри Developers или внешний контур.
Отдельных бэклогов у них нет.

## Пять событий

Sprint, Planning, Daily, Review, Retro — цели, таймбоксы и шаги в
`references/cycle.md`.

## Три артефакта

| Артефакт | Обязательство |
|---|---|
| Product Backlog | Product Goal |
| Sprint Backlog | Sprint Goal |
| Increment | Definition of Done |

Sprint Backlog = Goal (why) + PBI (what) + план (how).

## Правила спринта

- Длина фиксирована; не растягиваем.
- Изменения, угрожающие Goal, не вносим.
- Качество не снижается.
- Scope можно уточнять с PO; Goal — нет.
- Sprint отменяет только PO (или владелец).
- План обновляется ежедневно; Goal стабилен.
- Не сделанное возвращается в бэклог.

## Ready / Done

Ready/Done — `docs/quality/dod.md`; DoR/DoD OpenSpec — `references/openspec.md`.

## Ритм

Цикл 60–90 мин, спринт 4–6 циклов, дейлик 10 мин на границе цикла. Дейлик
имеет смысл, только если появился проверяемый шаг.

## Метрики

DORA, flow, quality и economy — `references/audit.md`. Story points и
velocity — не цель.

## Антипаттерны

- Sprint 0 / hardening sprint.
- Отдельная QA-очередь.
- Компонентные команды и репозиторий на роль.
- Дейлик как статус-отчёт.
- Ретро на 100 пунктов.
- «Потом починим качество».
- Автор ревьюит себя.
- Гигантский PR.
- Параллельный мерж.
- Синтетический пользователь как приёмщик.
- Velocity как KPI.
