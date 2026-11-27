# Changelog

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
