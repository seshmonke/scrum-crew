# Scrum: правила и артефакты

Источник: Scrum Guide 2020. Церемонии — в `references/cycle.md`.

## Три accountability

- **Product Owner** — ценность, порядок бэклога, Sprint Goal, приёмка.
- **Scrum Master** — процесс, препятствия, ритм, доска.
- **Developers** — код, тесты, дизайн, инфраструктура, проверка.

Остальные роли — специализации внутри Developers или внешний контур.
Отдельных бэклогов у них нет.

## Пять событий

| Событие | Цель | Таймбокс |
|---|---|---|
| Sprint | контейнер | 4–6 циклов |
| Planning | зачем, что, как | ≤ 15% |
| Daily | сверить прогресс с Goal | ≤ 10 мин |
| Review | показать инкремент | ≤ 10% |
| Retro | улучшить процесс | ≤ 5% |

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

- Ready: `docs/quality/dod.md`, `references/openspec.md`.
- Done: `docs/quality/dod.md`.
- Коротко: AC + e2e, тесты, typecheck/lint/build, security, a11y, perf,
  observability, docs, OpenSpec archive, rollback, preview, ревью
  не-автора.

## Ритм

```
цикл = 60–90 мин
спринт = 4–6 циклов
дейлик = 10 мин на границе цикла
```

Дейлик имеет смысл, только если между ним и предыдущим появился
проверяемый шаг.

## Метрики

DORA: lead time, deployment frequency, recovery time, change fail rate,
rework rate.
Поток: cycle time, PR size, review latency, trunk red time, WIP, conflict
rate.
Качество: escaped defects, flaky rate, покрытие критических путей.
Экономика: cost per merged task, ceremony %, human interventions.

Story points и velocity — не цель.

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
