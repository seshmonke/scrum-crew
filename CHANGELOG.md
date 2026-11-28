# Changelog

## v0.5.0 — 2026-11-28

- **Context/navigation layer:** `.scrum/README.md` — карта входа (phase,
  sprint, goal, next gate, active tasks; 5–6 ссылок; вопрос → файл; что не
  читать). Пишет только SM/оркестратор на границах фаз; устаревшая фаза
  или битая ссылка — провал гейта.
- **Durable task workspace:** `.scrum/sprints/NN/tasks/<id>/` с `brief.md`,
  `report.md`, `handoff.md`, `evidence/`. `/tmp`, чат и worktree больше не
  источник истины.
- **Brief как контекстный пакет:** objective, AC, owns, контракты,
  non-goals, output format, tools/sources, evidence, stop conditions +
  обязательный read-back.
- **Subagent output to files:** worker пишет report/evidence, координатору
  возвращает резюме + ссылку; reviewer читает brief/report/evidence/PR/diff,
  не логи.
- **Freshness protocol:** `status: plan | active | done | superseded`,
  `updated`, `owner`, `sprint`, `task`, `change`, `links`; PR задачи —
  правка host-файла или `No doc change: <причина>`; drift-проверка в ревью.
- **Conflict-aware WIP:** 1–2 задачи; WIP 6 — потолок; общие файлы и
  контракты — последовательно; конфликт — сигнал планировщику, не
  rebase-лотерея.
- **Trace и события:** trace-таблица `task → change → PR → review →
  evidence → status`; события несут `task`, `pr`, `commit`, `artifact`;
  review-артефакты — task id + PR.
- **Audit metrics:** discovery/activation, task success, efficiency,
  errors/recovery, durable %, trace %, map freshness, drift, stale claims,
  rework из-за контекста; оценка по конечному состоянию и чекпоинтам.
- **New files:** `references/context.md`, `assets/context.md`,
  `assets/brief.md`, `assets/report.md`; `assets/task.md` — deprecated stub.
- **Dry-run:** `.scrum/sprints/99/` показывает путь нового агента;
  установщик его не копирует.

### Migration v0.4.0 → v0.5.0

1. Обновить скилл установщиком без `--with-scaffold`.
2. Создать `.scrum/README.md` из `assets/context.md`; заполнить phase/
   sprint/goal/gate/active tasks и ссылки. Существующий файл — слить, не
   перезаписывать.
3. Для активных задач создать `.scrum/sprints/NN/tasks/<id>/` и перенести
   brief/handoff/report/evidence из `/tmp` или worktree. Worktree удалён —
   восстановить из `sprint.md`, PR и диффа с пометкой источника.
4. `assets/task.md` больше не шаблон: новые брифы — `brief.md`;
   `report.json` — `report.md`.
5. Старые `docs/tasks/NN-*.md` не перемещать без решения владельца; новый
   файл спринта — `.scrum/sprints/NN/sprint.md`, `INDEX.md` ссылается на
   него.
6. Добавить контекстные шапки новым/изменяемым докам; архивы массово не
   переписывать.
7. Миграция — отдельным PR между спринтами; продукт и код не менять.

## v0.4.0 — 2026-11-27

- **Breaking:** скилл и репозиторий переименованы в `scrum-crew` /
  «Scrum Crew»; skill-id `sprint-crew`, папка
  `.opencode/skills/sprint-crew/` и старый URL больше не используются.
  Миграция — README/D16; команда «через sprint-crew» остаётся
  legacy-триггером на один релиз.
- Tier + TDD/ATDD: Tier PBI, RED-evidence, ATDD test plan, T2-артефакты.
- T2-глубина: владельцы практик, threat model/contract/SLO,
  evidence-check в merge train.
- Quality waves, debt budget, postmortems и метрики внедрения.
- Инструкция обновления существующих проектов: `references/upgrade.md`,
  `VERSION`, режим Upgrade; только между спринтами, отдельным PR, через
  установщик без `--with-scaffold`.
- `docs/evidence/SKILL-METHODOLOGY.md`: gap-аудит и проверки.

## v0.3.0 — 2026-11-26

- Добавлены on-demand шляпы: Growth / Content, Support / Community,
  Legal / Privacy.
- Только карточки ролей: без новых агентов, бэклогов и репозиториев.
- Активация под конкретный PBI; нет дейли; задачи через PO.
- Legal имеет вето на релиз при нарушении закона/приватности.
- Raptor generation 3: +89 строк, 0 новых файлов.

## v0.2.1 — 2026-11-26

- Fix: аудитор может писать только отчёт в `docs/quality/audits/`,
  остальное — read-only.
- Уточнено: read-only к коду/скиллу/спекам, единственная запись — отчёт.

## v0.2 — 2026-11-26

- Добавлена мета-роль **Methodology Auditor** (on-demand, read-only).
- Аудит запускается только при наличии материалов: pilot / full,
  иначе `No audit: insufficient material`.
- 1–3 находки с доказательством, root cause, owner и метрикой.
- Отчёты — `docs/quality/audits/`; изменения через ADR/PR.
- Kill criteria: нет эффекта два аудита — роль удаляется.
- Raptor generation 2: +2 файла, +145 строк, SKILL 135 → 150.

## v0.1 — 2026-11-26

- Первый публичный скилл Scrum-команды агентов.
- Стадия Init: продукт → стек → delivery → walking skeleton.
- Спринт 4–8 часов, 4–6 циклов, дейлик на границе цикла.
- 14 карточек ролей, 12 слотов в коде, circuit breaker.
- OpenSpec: change на PBI, delta specs, verify, archive.
- Шина сообщений: три уровня, sync/focus, протоколы.
- Merge train для личного приватного репозитория.
- Raptor-рефакторинг: 21 → 17 файлов, 1406 → 1272 строк.
- Установщики: `install.cmd`, `install.ps1`, `install.sh`.
