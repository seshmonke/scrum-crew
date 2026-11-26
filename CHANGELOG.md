# Changelog

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
