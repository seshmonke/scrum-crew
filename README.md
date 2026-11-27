# Scrum Crew

Переиспользуемая методология Scrum-команды агентов для веб-разработки.
Одна команда, 12+ ролей, спринт 4–8 часов, OpenSpec для поведения,
монорепозиторий, последовательный merge train.

Статус: **v0.3**. Продукт и стек не входят — они определяются на стадии
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
- **Аудит методологии:** on-demand мета-роль, только при наличии
  материалов; 1–3 системные находки, read-only, изменения через ADR/PR.
- **On-demand шляпы:** Growth/Content, Support/Community, Legal/Privacy —
  только под PBI своего домена, без второго бэклога; Legal имеет вето.
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
git clone https://github.com/seshmonke/scrum-crew.git
cd C:\path\to\your-project
C:\path\to\scrum-crew\install.cmd -Target .
```

С каркасом проекта (только в пустой проект, существующие файлы не
перезаписываются):

```powershell
C:\path\to\scrum-crew\install.cmd -Target . -WithScaffold
```

`install.cmd` обходит ExecutionPolicy только для этого запуска. Прямой
вызов `.ps1` — `powershell -ExecutionPolicy Bypass -File .\install.ps1`.

### Ubuntu / macOS / Linux

Ubuntu 22.04+ и macOS. Нужны `git`, `curl`, `bash`.

```bash
# 1. OpenSpec (standalone, без Node)
curl -fsSL https://openspec.dev/cli/install.sh | sh

# 2. Скилл
git clone https://github.com/seshmonke/scrum-crew.git
cd /path/to/your-project
chmod +x /path/to/scrum-crew/install.sh
/path/to/scrum-crew/install.sh . --with-scaffold
```

`install.sh` — bash-скрипт, работает на Ubuntu без PowerShell. Если
`openspec` не в PATH, добавьте строку, которую напечатает установщик
(обычно `export PATH="$HOME/.local/bin:$PATH"`), и откройте новый терминал.

### Вручную

Скопировать `.opencode/skills/scrum-crew/` и `.opencode/agents/scrum-*.md`
в `.opencode/` проекта.

### Миграция с `sprint-crew`

Репозиторий и скилл переименованы в `scrum-crew`. Старые ссылки на
GitHub редиректятся, но установленную копию нужно обновить вручную:

1. Переустановите скилл установщиком `install.sh` / `install.cmd` — он
   обновит и `.opencode/skills/scrum-crew/`, и
   `.opencode/agents/scrum-*.md` — или скопируйте и то и другое вручную.
2. Удалите старую папку `.opencode/skills/sprint-crew/`, иначе OpenCode
   увидит две версии скилла.
3. Команда «через sprint-crew» пока принимается как legacy; новая —
   «через scrum-crew».
4. Если в `opencode.json` есть правила для skill-id `sprint-crew`,
   замените их на `scrum-crew`.

Новая версия раскатывается на проекты после завершения текущих планов
по скиллу.

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
инициализируй проект через scrum-crew
```

Скилл проведёт через стадию Init:

1. Product Goal, пользователь, главный сценарий, метрика, non-goals.
2. Стек, ADR, `verify`, CI, preview.
3. Репозиторий, защищённый `main`, merge train, `.scrum/`.
4. Первый change — walking skeleton.

Затем:

```text
запусти спринт через scrum-crew
```

## Обновление существующего проекта

Скилл не обновляется автоматически. Обновление — только между спринтами
и отдельным PR.

В OpenCode: команда «обнови скилл» → режим Upgrade. Подробная процедура —
`.opencode/skills/scrum-crew/references/upgrade.md`.

Установленная версия — `.opencode/skills/scrum-crew/VERSION`. Установщик
копирует скилл и агентов, но не трогает `.scrum/`, `openspec/`, `docs/`
и код проекта. После обновления удалите старые папки скилла и обновите
`opencode.json`, если в нём были старые skill-id.

## Структура

```
.opencode/
  skills/scrum-crew/
    SKILL.md              # вход: режимы, цикл, гейты
    VERSION               # установленная версия
    references/
      init.md             # стадия 0: продукт, стек, delivery
      scrum.md            # правила и артефакты
      roles.md            # 14 ролей + аудитор
      cycle.md            # церемонии и шаги
      orchestrator.md     # состояние, диспатч, merge train
      communication.md    # шина и протоколы
      openspec.md         # change-поток и гейты
      git-quality.md      # ветки, PR, безопасность, a11y/perf
      failure-modes.md    # сбои и восстановление
      audit.md            # мета-аудит: готовность, скоринг, находки
    assets/               # sprint, daily, review, retro, task, handoff, pr, audit
  agents/
    scrum-orchestrator.md
    scrum-worker.md
    scrum-reviewer.md
    scrum-security-reviewer.md
    scrum-methodology-auditor.md
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
| Growth / Content | запуск, контент, SEO, кампании; on-demand |
| Support / Community | тикеты, отзывы, churn; on-demand |
| Legal / Privacy | комплаенс, PII, cookies; on-demand, вето |
| Methodology Auditor | качество методологии; on-demand, только при материалах |

## Аудит методологии

Запускается вручную («аудит методологии») или после 3-го закрытого
спринта. Сначала проверяет готовность:

- **pilot:** ≥ 1 спринт, ≥ 5 merged задач, есть retro и метрики;
- **full:** ≥ 3 спринта, ≥ 20 merged, ≥ 20 событий, 2+ ретро.

Нет материалов — `No audit: insufficient material`, отчёт не создаётся.
Read-only; 1–3 находки с доказательством, root cause, owner и метрикой;
изменения — через ADR/PR. Нет эффекта два аудита — роль удаляется.

## On-demand шляпы

- **Growth / Content** — запуск, лендинг, SEO, соцсети, email, PR.
- **Support / Community** — тикеты, отзывы, FAQ, churn.
- **Legal / Privacy** — PII, cookies, ToS, DPA; вето на релиз, но не
  замена юристу.

Не входят в постоянный состав: активируются под конкретный PBI, не имеют
дейли и своего бэклога. Задачи — через PO. Если шляпа не активировалась
3 спринта — удалить.

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

| Метрика | До Raptor | v0.3 |
|---|---:|---:|
| Файлов | 21 | 19 |
| Строк | 1406 | 1506 |
| Слов | 7909 | 8885 |
| SKILL.md | 180 | 159 |
| Шаблонов | 11 | 7 |

Масса почти не выросла, хотя добавлены Init и мета-аудит; SKILL и число
шаблонов сокращены. Подробности — `docs/RAPTOR-SKILL.md`.

Подробности — `docs/RAPTOR-SKILL.md`.

## Ограничения

- Merge queue GitHub требует organization; для личного репозитория
  используется merge train.
- Protected branches на приватном репозитории могут требовать GitHub Pro.
- Синтетический пользователь не заменяет живую проверку владельца.
- Скрипты состояния и мержа — следующая генерация, не v0.1.

## Лицензия

MIT. См. `LICENSE`.
