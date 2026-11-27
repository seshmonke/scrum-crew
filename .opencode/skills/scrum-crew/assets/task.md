# Task NN: <название>

## Tier

T0 / T1 / T2 — почему. Сомнение T1/T2 → T2.

## Цель

Один проверяемый результат.

## AC

- [ ] …

## Change

`openspec/changes/NN-…` или `No spec change: <причина>`.
T0: `No spec change`; archive не требуется.

## Test plan (ATDD)

- AC-1: Given / When / Then; happy/error.
- Главный e2e-сценарий:
- T0: TDD/ATDD/e2e/archive не требуются; `verify` + ссылки/факты.

## TDD evidence (RED/GREEN/REFACTOR)

- RED: команда, тест, ожидаемое падение.
- GREEN: та же команда, N/N.
- REFACTOR: тесты зелёные, поведение не менялось.

## T2 artifacts

Только для T2; для T0/T1 — `N/A` с причиной.

- Threat model:
- Contract/property:
- Mutation (волна):
- SLO-дизайн/логи (обязательно):
- Alert/RUM (исключение до активации):
- Field RUM (исключение до публичного запуска):
- Runbook/rollback:

## owns

- `path/…`

## Контракты

- `packages/contracts/…`
- OpenAPI:
- Схема:

## Non-goals

- …

## Evidence

- `pnpm verify` — вывод.
- e2e — сценарий.
- Скриншот/замер — если UI/perf.

## Exception

- Owner / причина / срок / артефакт. Нет — `none`.

## Границы

- Не менять: …
- Не добавлять зависимость без ADR.
- Не мержить.
- При дыре в спеке — стоп и `#spec`.
