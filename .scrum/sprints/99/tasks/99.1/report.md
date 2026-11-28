# Report: Task 99.1 — карта входа для нового агента

> **Context:** `status: done` · `updated: 2026-11-28` · `owner: scrum-worker` ·
> `sprint: 99` · `task: 99.1` · `change: No spec change: docs/example` ·
> links: [brief](brief.md) · [handoff](handoff.md) · [evidence](evidence/)

## Итог для координатора (≤ 10 строк)

- Статус: done.
- Сделано: карта, sprint, brief, report, handoff и evidence показывают
  путь нового агента.
- PR/commit: #999 (example), `abc1234`.
- Evidence: [evidence/verify.txt](evidence/verify.txt).
- Блокеры: нет.
- Doc change: `No doc change: dry-run example`.

## AC и evidence

| AC | Проверка | Результат | Ссылка |
|---|---|---|---|
| AC-1 | phase/sprint/task в README и brief | pass | [README](../../README.md) |
| AC-2 | brief → evidence | pass | [brief](brief.md) |
| AC-3 | change = No spec change | pass | [sprint](../../sprint.md) |

## TDD / ATDD

- T0: `N/A` — docs/example, поведение не менялось.

## Изменения

- Файлы: `.scrum/sprints/99/**`.
- Контракты/схема: нет.
- Миграции/откат: удалить папку примера.

## Проверки

| Команда | Exit | Вывод (хвост) |
|---|---:|---|
| link check | 0 | `links: ok` |
| `git diff --check` | 0 | clean |

## Doc change и drift

- Host-файл: `No doc change: dry-run example`.
- Stale claims: none.
- Обещание теста: N/A (T0).
- Старые имена/будущее как текущее: none.

## Handoff

- Что осталось: review.
- Грабли: пример легко принять за активный спринт — читать warning.
- Открытые треды: `#task-99.1`.
- Следующий шаг: review-артефакт.

## Блокеры

- Нет.

## Read-back получателя

«Понял: пример завершён, нужен review. Делаю: проверяю drift и ссылки.»
