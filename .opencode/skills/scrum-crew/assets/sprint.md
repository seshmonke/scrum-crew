# Спринт NN: короткое описание

> **Context:** `status: active` · `updated: YYYY-MM-DD` · `owner: SM` ·
> `sprint: NN` · `task: —` · `change: —` ·
> links: [README](../../README.md) · [board](../../board.json) · [INDEX](../../../docs/tasks/INDEX.md)

Цель: одна фраза — что должно быть верно к завершению спринта.

## Продуктовый вклад

Почему это важно, для кого, как измерим.

## Задачи

- [ ] NN.1. Один проверяемый итог.
      Brief: [tasks/NN.1/brief.md](tasks/NN.1/brief.md)
      Change: `openspec/changes/NN-…` или `No spec change: <причина>`
      Tier: T0 / T1 / T2
      AC: …
      Owner: …
      owns: …
      Evidence: [tasks/NN.1/evidence/](tasks/NN.1/evidence/)

## Трассировка

Статус — производная от `board.json` (`proposed … done`); расхождение —
провал гейта.

| Task | Brief | Change | PR | Review | Evidence | Status |
|---|---|---|---|---|---|---|
| NN.1 | [brief](tasks/NN.1/brief.md) | `NN-…` / `No spec change` | #… | [review](../../reviews/NN-NN.1.md) | [evidence](tasks/NN.1/evidence/) | in_review |
| NN.2 | … | … | … | … | … | … |

## Проверка владельцем

- [ ] Что показать и как прогнать руками.

## Анализ перед стартом

По каждой задаче: почему разумна, что проверить до кода, источники.

## Quality gates

| Гейт | Волна | Статус | Evidence |
|---|---|---|---|
| TDD/ATDD | 1 | | |
| contract/property/threat/runbook | 1 | | |
| SLO-дизайн/логи | 1 | | |
| mutation | nightly сейчас; блокирует после Q1.0–Q1.6 | | |
| SAST | ручной/исключение сейчас; блокирует после Q1.0–Q1.6 | | |
| alert/RUM | owner-исключение сейчас; блокирует после Q1.0–Q1.6 | | |
| field RUM | до публичного запуска | | |
| trunk-based/flags/perf | 2 | | |
| IaC/progressive/debt/postmortem | 3 | | |
| context map fresh / links live | каждая фаза | | |

## Debt budget

- План: …; факт: …; P3 с owner/сроком: …

## Риски и зависимости

- Риск. Owner. Что делаем.

## Ход фаз

| Фаза | Гейт | Команда | Exit | Commit |
|---|---|---|---|---|
| Planning | … | … | … | … |

## Итоги и ретро

Заполняется при закрытии. Ссылки: `daily.md`, `review.md`, `retro.md`,
`tasks/<id>/report.md`, `tasks/<id>/handoff.md`.
