# PR: <поведение, не файлы>

## Задача

- PBI:
- Change:
- Спринт:
- Tier:

## Что меняется

Поведение до → после.

## Spec delta

```
openspec show <change> --diff
```

## TDD evidence

- RED: команда, тест, ожидаемое падение.
- GREEN: та же команда, N/N.
- REFACTOR: тесты зелёные, поведение не менялось.
- T0: `N/A` — docs/copy без изменения поведения.

## ATDD

- AC-1: Given / When / Then; happy/error.
- Главный e2e-сценарий:

## T2 gates

Только для T2; для T0/T1 — `N/A`.

- [ ] Threat model:
- [ ] Contract/property:
- [ ] Mutation: nightly / ≥ 70% changed (волна):
- [ ] SAST: ручной Semgrep / owner-исключение:
- [ ] SLO-дизайн/логи (обязательно):
- [ ] Alert/RUM — owner-исключение до активации:
- [ ] Field RUM — owner-исключение до публичного запуска:
- [ ] Runbook/rollback:

## Проверки

- [ ] `pnpm verify`
- [ ] `pnpm test:e2e`
- [ ] `pnpm audit:security` — owner-exception до Q1.4.
- [ ] `pnpm test:a11y` — owner-exception до Wave 2.
- [ ] `pnpm budget:perf` — owner-exception до Q1.6.
- [ ] `openspec validate --all --strict`

`pnpm audit:security`, `pnpm test:a11y`, `pnpm budget:perf` пока нет в
`package.json`; до появления — owner-exception с owner, причиной и сроком.

## Exception

- Owner / причина / срок / артефакт. Нет — `none`.

## Debt/postmortem

- P3 debt: owner/срок.
- P0/P1 postmortem: ссылка, actions, owner/срок.

## Откат

Feature flag / revert / migration rollback.

## Риски

- …

## Скриншоты / замеры

- …
