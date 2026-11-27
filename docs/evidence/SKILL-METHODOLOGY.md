# Skill methodology evidence

Дата: 27.11.2026. Источник политики — проектный
`docs/quality/methodologies.md` (в скилл не копируется). Разработка — только
`.opencode/skills/scrum-crew/`; проекты-потребители не меняются.

## Gap-аудит до правки

| Термин | Вхождений в скилле | Где |
|---|---:|---|
| `Tier` | 0 | нет |
| `ATDD` | 1 | только `references/roles.md` |
| `TDD` | 9 | только `references/roles.md` |
| `threat` | 3 | только `references/roles.md` |
| `mutation` | 5 | только `references/roles.md` |
| `SLO` | 2 | только `references/roles.md` |
| `debt` | 0 | нет |
| `postmortem` | 0 | нет |

## Baseline

Сценарии запускались свежими субагентами на текущем скилле. Поведенчески
агенты не провалили практики: они читали проектные `docs/quality/*` и сами
включали Tier/TDD/ATDD/threat/contract/SLO. RED структурный: полей и
гейтов в скилле не было.

- T0: `Tier: T0`; `TDD evidence: N/A`; TDD/e2e не требуются.
- T1: `Tier: T1`; `TDD: RED → GREEN → REFACTOR`; T2-практики не требуются.
- T2: `Tier: T2`; threat model, contract/property, PII-логи, миграция;
  отдельно остановился на отсутствии подписи у текущего провайдера.

## Post-change

- T0: `Tier: T0`; TDD/ATDD/e2e/OpenSpec archive — N/A; `verify` + ссылки.
- T1: `Tier: T1`; RED-тест падал до кода; ATDD happy/error; e2e главного
  сценария; T2-артефакты N/A.
- T2: `Tier: T2`; threat model, contract/property, SLO-дизайн/логи,
  runbook/rollback; mutation/SAST/alert/RUM — по волне; field RUM —
  исключение до публичного запуска.

## REFACTOR

- Убрана двусмысленность «SLO-дизайн/логи, alert/RUM — исключение»:
  SLO-дизайн/логи обязательны, alert/RUM — именованное исключение.
- `runbook/rollback` добавлен в волновой гейт, чек-лист, T2-артефакты и
  карточку Reviewer.
- `field RUM` выделен как исключение до публичного запуска (как в DoD).
- T0 явно исключён из e2e и OpenSpec archive; T1/T2 требуют e2e главного
  сценария.
- В `sprint.md` режимы mutation/SAST/alert/RUM разделены: что действует
  сейчас и что блокирует после Q1.0–Q1.6.

## Проверки

- `git diff --check` — exit 0.
- Внутренние ссылки скилла (`references/`, `assets/`) — missing: 0.
- `bash -n install.sh` — exit 0.
- Абсолютные пути/email в изменённых файлах — не найдены.
- `pnpm verify`, `pnpm format:check`, `openspec validate` в этом
  репозитории не применимы: нет `package.json`/`openspec`; скилл —
  Markdown-пакет.
- Сценарии T0/T1/T2 прогонялись на копии скилла, идентичной этой ветке.

## Границы

- Менялся только `.opencode/skills/scrum-crew/`.
- `template/`, `CHANGELOG.md`, `README.md`, `docs/` проекта-потребителя не
  менялись.
- Правка `docs/quality/methodologies.md` в `localhand` — проектное
  изменение, в скилл не переносится.
