# Sprint Crew

Переиспользуемая методология Scrum-команды агентов для веб-разработки.
Одна команда, 12+ ролей, спринт 4–8 часов, OpenSpec для поведения,
монорепозиторий, последовательный merge train.

Статус: **v0.1**. Продукт и стек не входят — они определяются на стадии
Init в каждом проекте.

## Что даёт

- **Init как стадия 0:** продукт → стек → delivery → walking skeleton.
  Код не пишется, пока не определены Goal, пользователь, сценарий,
  метрика и non-goals.
- **Спринт 4–8 часов:** 4–6 циклов по 60–90 минут, дейлик на границе
  цикла.
- **12+ ролей:** PO, SM, Architect, Fullstack, Frontend, Backend, Data, QA,
  Tester, DevSecOps, White Hacker, Designer, User Proxy, Delivery.
- **OpenSpec:** каждый behavior-changing PBI = change с proposal, delta
  specs, design и tasks; ревью намерения до кода.
- **12 слотов в коде** с contract baseline, file ownership, shared-file
  czar и circuit breaker.
- **Связь:** структурированная шина + sync/focus, design council на
  развилках, continuous только для инцидентов.
- **Безопасность:** автор ≠ ревьюер, least privilege, нет прод-доступа,
  гейты командами, а не мнениями.

## Требования

- [OpenCode](https://opencode.ai/) — скиллы и субагенты.
- [OpenSpec](https://openspec.dev/) 2.2+ — `openspec` в PATH.
- Git.
- GitHub — опционально, для PR и merge train.
- Node.js не обязателен: OpenSpec ставится standalone.

## Установка

### Windows

```powershell
git clone https://github.com/seshmonke/sprint-crew.git
cd C:\path\to\your-project
C:\path\to\sprint-crew\install.cmd -Target .
```

С каркасом проекта (только в пустой проект, существующие файлы не
перезаписываются):

```powershell
C:\path\to\sprint-crew\install.cmd -Target . -WithScaffold
```

`install.cmd` обходит ExecutionPolicy только для этого запуска. Прямой
вызов `.ps1` — `powershell -ExecutionPolicy Bypass -File .\install.ps1`.

### Ubuntu / macOS / Linux

Ubuntu 22.04+ и macOS. Нужны `git`, `curl`, `bash`.

```bash
# 1. OpenSpec (standalone, без Node)
curl -fsSL https://openspec.dev/cli/install.sh | sh

# 2. Скилл
git clone https://github.com/seshmonke/sprint-crew.git
cd /path/to/your-project
chmod +x /path/to/sprint-crew/install.sh
/path/to/sprint-crew/install.sh . --with-scaffold
```

`install.sh` — bash-скрипт, работает на Ubuntu без PowerShell. Если
`openspec` не в PATH, добавьте строку, которую напечатает установщик
(обычно `export PATH="$HOME/.local/bin:$PATH"`), и откройте новый терминал.

### Вручную

Скопировать `.opencode/skills/sprint-crew/` и `.opencode/agents/scrum-*.md`
в `.opencode/` проекта.

## Первый запуск

Windows:

```powershell
cd C:\path\to\your-project
openspec init --tools opencode --scope project
```

Ubuntu / macOS:

```bash
cd /path/to/your-project
openspec init --tools opencode --scope project
```

В чате OpenCode:

```text
инициализируй проект через sprint-crew
```

Скилл проведёт через стадию Init:

1. Product Goal, пользователь, главный сценарий, метрика, non-goals.
2. Стек, ADR, `verify`, CI, preview.
3. Репозиторий, защищённый `main`, merge train, `.scrum/`.
4. Первый change — walking skeleton.

Затем:

```text
запусти спринт через sprint-crew
```

## Структура

```
.opencode/
  skills/sprint-crew/
    SKILL.md              # вход: режимы, цикл, гейты
    references/
      init.md             # стадия 0: продукт, стек, delivery
      scrum.md            # правила и артефакты
      roles.md            # 14 карточек ролей
      cycle.md            # церемонии и шаги
      orchestrator.md     # состояние, диспатч, merge train
      communication.md    # шина и протоколы
      openspec.md         # change-поток и гейты
      git-quality.md      # ветки, PR, безопасность, a11y/perf
      failure-modes.md    # сбои и восстановление
    assets/               # sprint, daily, review, retro, task, handoff, pr
  agents/
    scrum-orchestrator.md
    scrum-worker.md
    scrum-reviewer.md
    scrum-security-reviewer.md
template/                  # каркас проекта для Init
docs/                      # дизайн методологии и 100 источников
install.ps1
install.sh
```

## Как это работает

```
Init → Sprint 1 → Review → Retro → Sprint 2 → …
```

Спринт:

```
PLANNING → READY → BUILDING ⇄ BLOCKED → REVIEW → RETRO → CLOSED
```

Гейт — команда + exit code + evidence. «Зелёно» без вывода не
принимается.

## Роли

| Роль | Зона |
|---|---|
| Product Owner | ценность, порядок, Goal, приёмка |
| Scrum Master | процесс, доска, дейли, препятствия |
| Architect | контракты, ADR, границы capability |
| Fullstack / Integrator | сквозной срез, интеграция |
| Frontend | UI, состояние, a11y, perf |
| Backend | API, authz, jobs, данные |
| Data / DB | схема, миграции, откат |
| QA | стратегия тестов, e2e, quality gates |
| Tester | exploratory, устройства, edge cases |
| DevSecOps / SRE | CI, секреты, IaC, наблюдаемость |
| White Hacker | threat model, abuse cases, red team |
| Designer | UX/UI, дизайн-система, a11y |
| User Proxy | персоны, сценарии, гипотезы |
| Delivery / PM | зависимости, риски, релизы |

## Принципы

- Один продукт, один бэклог, один монорепозиторий.
- Роль — шляпа, не отдельный репозиторий.
- Один owner на задачу; остальные — reviewer/consultant.
- Автор не ревьюит себя и не мержит свой PR.
- Поведение — в OpenSpec; причины — в docs; реализация — в коде.
- Один факт — один файл.
- Полный автопилот внутри; человек — только аварийный контур.

## Raptor-рефакторинг

Скилл прошёл Raptor-рефакторинг: вопрос требований → удаление →
упрощение → ускорение → автоматизация.

| Метрика | До | После |
|---|---:|---:|
| Файлов | 21 | 17 |
| Строк | 1406 | 1272 |
| Слов | 7909 | 7346 |
| SKILL.md | 180 | 135 |
| Шаблонов | 11 | 7 |

Подробности — `docs/RAPTOR-SKILL.md`.

## Ограничения

- Merge queue GitHub требует organization; для личного репозитория
  используется merge train.
- Protected branches на приватном репозитории могут требовать GitHub Pro.
- Синтетический пользователь не заменяет живую проверку владельца.
- Скрипты состояния и мержа — следующая генерация, не v0.1.

## Лицензия

MIT. См. `LICENSE`.
