# Brief: Task 99.1 — карта входа для нового агента

> **Context:** `status: active` · `updated: 2026-11-28` · `owner: scrum-worker` ·
> `sprint: 99` · `task: 99.1` · `change: No spec change: docs/example` ·
> links: [sprint](../../sprint.md) · [board](../../../../board.json)

## 1. Objective

Показать, что новый агент по `.scrum/README.md` и этому брифу отвечает на
вопросы «где я, какая задача, какая фаза, где evidence, что меняется» за
≤ 3 ссылки, не читая весь репозиторий.

## 2. AC

- [ ] AC-1: ответ называет phase `BUILDING`, sprint `99`, task `99.1`.
- [ ] AC-2: ответ ссылается на brief и evidence.
- [ ] AC-3: ответ говорит `No spec change: docs/example` и не выдумывает
      change.

## 3. Tier и change

- Tier: T0 — docs/example, поведение не меняется.
- Change: `No spec change: docs/example`.
- Change status: N/A.
- Task id в change: N/A.

## 4. owns

- `.scrum/sprints/99/**` — пример.
- Не трогать: код, `openspec/specs/`, `.opencode/`.

## 5. Контракты

- Нет. Поведение продукта не меняется.

## 6. Non-goals

- Не добавлять runtime-код, CLI, зависимости.
- Не менять канон скилла.
- Не создавать реальную задачу в board.

## 7. Output format

- `report.md` — по `assets/report.md`, резюме ≤ 10 строк.
- `handoff.md` — по `assets/handoff.md`.
- `evidence/` — вывод проверки ссылок и `git diff --check`.
- Координатору — резюме + ссылки.

## 8. Tools / sources

- Разрешено: `git diff --check`, локальная проверка markdown-ссылок.
- Прочитать (3 ссылки): [sprint](../../sprint.md), этот brief,
  [DoD (шаблон)](../../../../../template/docs/quality/dod.md).
- Не читать: весь репозиторий, `events.jsonl` как нарратив, `/tmp`, чужие
  task-папки.

## 9. Evidence contract

- T0: `verify`/link check + ссылки/факты; TDD/ATDD/e2e/archive не
  требуются.
- Doc change: `No doc change: dry-run example`.
- Drift: нет старых имён, будущего как текущего, теста без ссылки.

## 10. Stop conditions

- Ссылка не резолвится.
- Пример начинает противоречить канону.
- Нужно менять код или спеку.
- На стопе — блокер в `report.md`, сообщение в `#task-99.1`, не гадать.

## 11. Границы

- Только `.scrum/sprints/99/**`; не мержить; не менять `openspec/specs/`.
- Не писать `state.json`, `board.json`, `.scrum/README.md`.
- Не хранить артефакты в `/tmp` или чате.

## 12. Read-back (до первой правки)

«Понял: phase BUILDING, sprint 99, task 99.1, change — No spec change.
Делаю: проверяю карту и ссылки, пишу report/handoff/evidence. Не трогаю:
код, openspec/specs, state/board/README. Стоп: битая ссылка или
противоречие канону.»
