# Спринт 99: dry-run карты входа

> **Context:** `status: active` · `updated: 2026-11-28` · `owner: SM` ·
> `sprint: 99` · `task: 99.1` · `change: No spec change: docs/example` ·
> links: [README](../../README.md) · [board](../../board.json) ·
> [INDEX (шаблон)](../../../template/docs/tasks/INDEX.md)

Цель: новый агент по карте входа отвечает, где он, какая задача, какая
фаза, где evidence и что меняется, — за ≤ 3 ссылки.

## Продуктовый вклад

Проверяем, что слой навигации и durable-артефактов работает без чтения
всего репозитория.

## Задачи

- [x] 99.1. Показать путь нового агента.
      Brief: [tasks/99.1/brief.md](tasks/99.1/brief.md)
      Change: `No spec change: docs/example`
      Tier: T0
      AC: ответ за 3 ссылки; evidence в файле
      Owner: scrum-worker
      owns: `.scrum/sprints/99/**`
      Evidence: [tasks/99.1/evidence/](tasks/99.1/evidence/)

## Трассировка

| Task | Brief | Change | PR | Review | Evidence | Status |
|---|---|---|---|---|---|---|
| 99.1 | [brief](tasks/99.1/brief.md) | `No spec change` | #999 | [review](../../reviews/99-99.1.md) | [evidence](tasks/99.1/evidence/) | in_review |

## Проверка владельцем

- [ ] Открыть `.scrum/README.md`, `brief.md`, `No spec change` — ответить
      на пять вопросов без чтения кода.

## Quality gates

| Гейт | Волна | Статус | Evidence |
|---|---|---|---|
| context map fresh / links live | каждая фаза | pass | [evidence/verify.txt](tasks/99.1/evidence/verify.txt) |
| TDD/ATDD | 1 | N/A | T0, docs example |
| contract/property/threat/runbook | 1 | N/A | T0 |
| SLO-дизайн/логи | 1 | N/A | T0 |
| mutation/SAST/alert/RUM | по волне | N/A | T0 |

## Debt budget

- План: 0; факт: 0; P3 с owner/сроком: нет.

## Риски и зависимости

- Пример может быть принят за активный спринт. Mitigation: предупреждение
  в README; state/board — только пример; установщик не копирует `.scrum/`.

## Ход фаз

| Фаза | Гейт | Команда | Exit | Commit |
|---|---|---|---|---|
| BUILDING | brief + report + evidence | link check | 0 | `abc1234` |

## Итоги и ретро

Ожидает REVIEW; после — `review.md`, `retro.md`, `status: done`.
