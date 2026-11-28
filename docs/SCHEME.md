# Схема работы scrum-crew

Карта, не склад. Детали — в `references/` скилла; здесь — связи между
входом, циклом, задачей и артефактами.

## 1. Вход и контекст

```mermaid
flowchart TD
  A["AGENTS.md<br/>проект: правила, команды"] --> B[".scrum/README.md<br/>phase, sprint, goal, gate, tasks"]
  B --> S["state.json<br/>phase, cycle, stop"]
  B --> Bd["board.json<br/>owner, PR, status"]
  B --> Sp["sprint.md<br/>Goal, PBI, trace"]
  B --> Br["tasks/id/brief.md<br/>objective, AC, owns, evidence"]
  Br --> Ch["openspec change<br/>или No spec change"]
  Br --> Dod["docs/quality/dod.md<br/>Done"]
  Br --> Ev["report.md + evidence/<br/>RED/GREEN, checks"]
  Ev --> Rv["review artifact<br/>task id + PR + drift"]
  Rv --> Pr["PR + merge train"]
```

- Навигация — два уровня: `AGENTS.md` (проект) → `.scrum/README.md`
  (спринт). Задача — `brief.md`, контекстный пакет.
- `.scrum/README.md` пишет только SM/оркестратор на границах фаз; stale
  phase или битая ссылка — провал гейта.
- Ответ нового агента — ≤ 3 ссылки: README → brief → change/`No spec
  change`; evidence лежит по ссылке из brief/report.

## 2. Цикл

```mermaid
stateDiagram-v2
  [*] --> INIT
  INIT --> PLANNING: product gate
  PLANNING --> READY: DoR
  READY --> BUILDING
  BUILDING --> BLOCKED
  BLOCKED --> BUILDING
  BUILDING --> REVIEW: evidence
  REVIEW --> RETRO: ACCEPT
  REVIEW --> BUILDING: REJECT
  RETRO --> CLOSED
  BUILDING --> ESCALATED: stop
```

- Спринт = 4–6 циклов по 60–90 минут; дейлик — на границе цикла.
- В работе 1–2 код-задачи; WIP 6 — потолок, не цель. Общие файлы и
  контракты — последовательно.
- Один мерж за раз; следующий PR — после зелёного `main`.

## 3. Задача

```mermaid
sequenceDiagram
  participant O as Orchestrator
  participant W as Worker
  participant R as Reviewer
  participant G as GitHub
  O->>O: brief + read-back gate
  O->>W: brief + 2-5 links
  W->>W: RED/GREEN + report/evidence
  W-->>O: summary + links
  O->>O: verify
  O->>R: brief/report/evidence/PR/diff
  R->>R: drift + test promise
  R-->>O: review artifact
  O->>G: rebase/verify/squash-merge
  O->>O: trace/event/board
```

- Brief: objective, AC, owns, контракты, non-goals, output format,
  tools/sources, evidence, stop conditions. Без read-back задача не начата.
- Worker пишет `report.md`, `handoff.md`, `evidence/`; координатору —
  резюме ≤ 10 строк + ссылки.
- Reviewer читает артефакты, PR и diff, а не логи; проверяет drift и
  «обещание теста = ссылка на тест».

## 4. Артефакты и владельцы

| Артефакт | Путь | Владелец |
|---|---|---|
| Правила проекта | `AGENTS.md` | владелец/Architect |
| Карта спринта | `.scrum/README.md` | SM/оркестратор |
| Состояние | `.scrum/state.json`, `board.json`, `events.jsonl` | только оркестратор |
| Файл спринта | `.scrum/sprints/NN/sprint.md` | SM |
| Brief задачи | `.scrum/sprints/NN/tasks/<id>/brief.md` | оркестратор |
| Report / handoff / evidence | `.scrum/sprints/NN/tasks/<id>/` | worker |
| Review | `.scrum/reviews/NN-<task>.md` | reviewer |
| Поведение | `openspec/specs/`, `openspec/changes/` | PO/Architect/QA |
| Зачем / как / вид / проверка | `docs/concept`, `docs/stack`, `docs/design`, `docs/quality/` | владельцы зон |

## 5. Гейты

| Гейт | Что проверяется |
|---|---|
| Init | Goal, сценарий, метрика, non-goals; `verify`; preview; `.scrum/README.md` в `INIT` |
| Planning | DoR, change/`No spec change`, Tier, `openspec validate --strict` |
| Build | RED-evidence, `verify`, ревью не-автора, T2-артефакты текущей волны |
| Review | Done на preview, ATDD, drift, `No doc change`/host-doc, ACCEPT/REJECT |
| Close | `verify`, archive, trace полон, README → `CLOSED/done`, долг/postmortem закрыты |

Гейт — команда + exit code + evidence. «Зелёно» без вывода не
принимается.

## 6. Свежесть

- `status: plan|active|done|superseded`, `updated`, `owner`, `sprint`,
  `task`, `change`, `links` — в шапке артефакта.
- `plan` → `active` переводит PR реализации; `done` — после merge/verify.
- PR задачи: правка host-файла или `No doc change: <причина>`.
- Один факт — один файл; карта, sprint и review ссылаются, не копируют.

## 7. Что не читать

- `events.jsonl` как нарратив — только `tail`/`grep` по событию.
- Весь репозиторий, чужие task-папки, старые спринты.
- `/tmp`, чат и логи сессий как источник истины.
- Копии метрик, размеров и API — читай источник.

## Куда дальше

- Вход и контекст — `../.opencode/skills/scrum-crew/references/context.md`
- Оркестратор, WIP, merge train — `../.opencode/skills/scrum-crew/references/orchestrator.md`
- OpenSpec, статусы, drift — `../.opencode/skills/scrum-crew/references/openspec.md`
- Аудит и метрики — `../.opencode/skills/scrum-crew/references/audit.md`
- Шаблоны — `../.opencode/skills/scrum-crew/assets/sprint.md`,
  `brief.md`, `report.md`, `review.md`
- Raptor-поколения — `RAPTOR-SKILL.md`
