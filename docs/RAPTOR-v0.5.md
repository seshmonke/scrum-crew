# Raptor-рефакторинг v0.5

На начало применения Raptor к v0.5.0 на руках было **поколение 1**.
Этот проход даёт **поколение 2** (v0.5.1). История v0.1–v0.3 — в
[`RAPTOR-SKILL.md`](RAPTOR-SKILL.md); нумерация там не переиспользуется.

## Вопрос требований

Зачем скилл: методология Scrum-команды агентов — Init → Sprint → Review →
Retro, OpenSpec для поведения, 12+ ролей, шина, merge train. Главные
сценарии: инициализировать проект, провести спринт, переиспользовать
скилл. Нельзя ломать роли, цикл, гейты, OpenSpec-философию и merge train.

Что проверяем Raptor-проходом: где инструкция пересказывает другую,
где шаблон дублирует reference, где SKILL разросся до руководства, и
сколько контекста нужно агенту до первой правки.

## До — поколение 1 (v0.5.0)

| Метрика | Значение |
|---|---:|
| Файлов в скилле | 24 |
| Строк | 3645 |
| Слов | 17698 |
| SKILL.md | 343 |
| References | 12 файлов / 2623 строки |
| Assets | 11 файлов / 679 строк |
| Agents | 5 файлов / 224 строки |
| Схема работы | нет |

## Реестр находок

| ID | Находка | Где | Глагол | Приоритет |
|---|---|---|---|---|
| F1 | Start-here и question→file продублированы в reference и шаблоне | `references/context.md` | удалить | P1 |
| F2 | Статус change, trace и drift продублированы | `references/openspec.md` | слить | P1 |
| F3 | Brief-поля и trace-таблица продублированы | `references/orchestrator.md` | слить | P1 |
| F4 | SKILL вырос до 343 строк и пересказывает references | `SKILL.md` | упростить | P1 |
| F5 | Brief/report/drift повторены в карточках | `references/roles.md` | упростить | P2 |
| F6 | Drift-чеклист продублирован в PR | `assets/pr.md` | ссылка | P2 |
| F7 | Контекстные метрики продублированы списком | `assets/audit.md` | удалить | P2 |
| F8 | Drift-чеклист продублирован в git-quality | `references/git-quality.md` | ссылка | P2 |
| F9 | Нет визуальной схемы работы | `docs/` | добавить | P1 |
| F10 | Нет Raptor-отчёта для линии v0.5 | `docs/` | добавить | P2 |
| F11 | Пять событий, ритм, Ready/Done и метрики продублированы | `references/scrum.md` | слить | P2 |
| F12 | Поля файла спринта продублированы | `references/cycle.md` | ссылка | P2 |

## Удаление

- Start-here и question→file таблицы из `references/context.md` — источник
  `assets/context.md`.
- Дубли статуса change, trace-таблицы и drift-чеклиста из
  `references/openspec.md` — остались OpenSpec-специфичные пункты и ссылки.
- Trace-таблица из `references/orchestrator.md` — источник
  `assets/sprint.md`.
- Контекстные метрики-списки из `assets/audit.md` — остались таблица и
  пороги.

## Упрощение

- `SKILL.md`: 343 → 271 строка. Роли, quality waves, планирование, OpenSpec,
  связь и аудит — короткие указатели; чек-лист остался гейтом.
- `references/context.md`: 178 → 138 строк. Остались принципы, 3-link
  пример, статусы, generated data и ссылки.
- `references/openspec.md`: 216 → 197 строк. Статус/trace/drift — ссылки
  на host-файлы.
- `references/orchestrator.md`: 258 → 245 строк. Контекстный пакет и trace —
  ссылки на `brief.md`/`sprint.md`.
- `references/scrum.md`: 86 → 65 строк. События/ритм/Ready-Done/метрики —
  ссылки на cycle/DoD/audit.
- `references/cycle.md`: 147 → 143 строки. Поля файла спринта — в
  `assets/sprint.md`.
- `references/roles.md`: 666 → 659 строк. Worker/reviewer не пересказывают
  шаблоны.
- `assets/pr.md`: 106 → 104, `assets/audit.md`: 94 → 85,
  `references/git-quality.md`: 126 → 123.

## Ускорение

- Вход по 3 ссылкам: README → brief → change/`No spec change`; evidence —
  внутри brief/report.
- `docs/SCHEME.md` — визуальная карта: вход, цикл, задача, артефакты, гейты.
- Один host-файл на факт: карта, brief, trace, drift, статусы больше не
  размазаны по reference.
- Этот отчёт — поколение 1 → 2 с замерами и находками.

## Автоматизация

- Runtime-код, CLI и генераторы не добавлялись — это non-goal скилла.
- Проверки остаются командными: `git diff --check`, link-check, install
  smoke, JSON/таблицы. Они уже дают exit code, но запускаются вручную.
- Следующий шаг автоматизации — только после eval-набора и двух стабильных
  поколений: link-check/README freshness в CI.

## После — поколение 2 (v0.5.1)

| Метрика | Поколение 1 | Поколение 2 | Δ |
|---|---:|---:|---:|
| Файлов в скилле | 24 | 24 | 0 |
| Строк | 3645 | 3455 | −190 |
| Слов | 17698 | 16512 | −1186 |
| SKILL.md | 343 | 271 | −72 |
| References | 2623 | 2516 | −107 |
| Assets | 679 | 668 | −11 |
| Agents | 224 | 224 | 0 |
| Схема работы | нет | есть | +1 |

Тяга: поведение и гейты не менялись, но у каждого факта снова один
host-файл; карта входа, brief, trace и ритуалы не размазаны по reference.
Масса: −190 строк и −1186 слов, плюс схема как точка сборки.

## Что не трогали и почему

- `references/roles.md` — ядро инструкций, резать карточки в ущерб ясности
  нельзя; сокращены только дубли шаблонов.
- `references/upgrade.md`, `init.md`, `communication.md` — связные
  процедуры, не дубли.
- `references/openspec.md` — поток и гейты OpenSpec не менялись.
- `assets/context.md`, `brief.md`, `report.md`, `sprint.md`, `review.md` —
  шаблоны-хосты; их поля не сокращались.
- Dry-run `.scrum/sprints/99/` — пример пути агента, не масса скилла.

## Следующая генерация

1. Eval-набор 10–20 задач: discovery/activation по 3 ссылкам, понимание
   brief, drift-находки в ревью.
2. Замер: файлы/токены до первой правки, rework из-за контекста.
3. Проверить, не пора ли удалить `assets/task.md` после миграции проектов.
4. Автоматизировать link-check/README freshness только после стабильных
   двух поколений — не раньше.

## Проверка

- `git diff --check` — exit 0.
- Локальные markdown-ссылки — 0 битых.
- Install smoke `install.sh --with-scaffold` — `VERSION=0.5.1`.
- JSON, `bash -n install.sh`, markdown-таблицы/fences — ok.
