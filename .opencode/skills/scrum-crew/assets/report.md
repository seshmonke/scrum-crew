# Report: Task <id> — <название>

> **Context:** `status: active` · `updated: YYYY-MM-DD` · `owner: <role>` ·
> `sprint: NN` · `task: <id>` · `change: <id | No spec change: причина>` ·
> links: [brief](brief.md) · [handoff](handoff.md) · [evidence](evidence/)

## Итог для координатора (≤ 10 строк)

- Статус: done / partial / blocked.
- Что сделано: 1–3 строки.
- PR/commit:
- Evidence: [ссылка](evidence/).
- Блокеры/риски:
- Doc change: host-файл / `No doc change: <причина>`.

## AC и evidence

| AC | Проверка | Результат | Ссылка |
|---|---|---|---|
| AC-1 | команда/сценарий | pass/fail | `evidence/…` |
| AC-2 | … | … | … |

## TDD / ATDD

- RED: команда, тест, ожидаемое падение.
- GREEN: та же команда, N/N.
- REFACTOR: тесты зелёные, поведение не менялось.
- T0: `N/A` — причина.

## Изменения

- Файлы:
- Контракты/схема:
- Миграции/откат:
- Зависимости:

## Проверки

| Команда | Exit | Вывод (хвост) |
|---|---:|---|
| `pnpm verify` | | |
| `pnpm test:e2e` | | |
| `openspec validate --all --strict` | | |

## Doc change и drift

- Host-файл: … (обновлён) или `No doc change: <причина>`.
- Stale claims: none / список с owner.
- Обещание теста: ссылка на тест или N/A.
- Старые имена/будущее как текущее: none / список.

## Handoff

- Что осталось:
- Грабли:
- Открытые треды: `#task-<id>`, `#spec`.
- Следующий шаг:

## Блокеры

- …

## Read-back получателя (если передаётся)

«Понял: … Делаю: … Не трогаю: …»
