---
name: scrum-crew
description: Ведёт веб-разработку по Scrum командой из 12+ агентов — инициализация продукта, спринт 4–8 часов, 4–6 циклов, дейлик на границе цикла, 12 слотов в коде, OpenSpec для поведения, шина сообщений и последовательный merge train. Включать по команде владельца — «инициализируй проект», «запусти спринт», «через scrum-crew», «через sprint-crew» (legacy), «обнови скилл», «обнови scrum-crew», «перейди на новую версию», «scrum спринт», «спланируй спринт», «проведи ретро».
---

# Scrum Crew

Оркестратор — эта сессия. Роли — субагенты. Состояние — `.scrum/`.
Поведение — `openspec/`. Правила проекта — `AGENTS.md`.

Вход: `AGENTS.md` → `.scrum/README.md` → `brief.md` задачи. Карта, а не
весь репозиторий: 3–5 ссылок под задачу. Детали — `references/context.md`.

## Режимы

| Режим | Команда | Что делает |
|---|---|---|
| Init | «инициализируй проект» | продукт → стек → delivery → walking skeleton |
| Sprint | «запусти спринт» | планирование → сборка → review → retro |
| Upgrade | «обнови скилл» | версия → changelog → установка → проверка |
| Audit | «аудит методологии» | quality of process, только при наличии материалов |
| Single task | обычная задача | без спринта, по правилам проекта |

Пока Init не закрыт, спринт не начинается.

## 0. Init

Стадия 0, не спринт. Подробно — `references/init.md`.

1. **Продукт:** Goal, пользователь, главный сценарий, метрика, скоуп,
   non-goals, риски. Выход — `docs/concept/product.md`.
2. **Фундамент:** стек, ADR, `verify`, CI, preview, секреты.
3. **Delivery:** репозиторий, защищённый `main`, review-gate, merge train,
   `.scrum/` (state, board, budget, events, `README.md`), `openspec init`.
4. **Первый change:** walking skeleton — healthcheck → экран → API → БД →
   preview. Не sprint 0 и не «вся инфраструктура».

Гейт: владелец подтвердил Goal, сценарий, метрику, non-goals; `verify`
работает; preview открывается; первый change создан; `.scrum/README.md`
существует, фаза `INIT` и ссылки живые. Только после этого — команда на
Sprint 1.

## 0.5. Обновление скилла

Не спринт; только по команде владельца и между спринтами. Версия —
`VERSION`, процедура — `references/upgrade.md`. Гейт: чистое дерево,
закрытый спринт, released tag; отдельный PR.

## 1. Прочитать до спринта

1. `AGENTS.md` — проект, команды, инварианты.
2. `.scrum/README.md` — phase, sprint, goal, next gate, active tasks и
   5–6 ссылок «начни здесь».
3. Дальше — только по карте: `state.json` → `board.json` → `sprint.md` →
   change → `docs/quality/dod.md`.
4. Для задачи — `brief.md` + change + 2–5 ссылок. Не весь репозиторий,
   не `events.jsonl` как нарратив, не `/tmp`.

Чего нет — спросить владельца. Продукт, стек и состав спринта не
выдумывать. Карта устарела или ссылка битая — стоп и починить до работы.
Церемонии и гейты — `references/cycle.md`.

## 2. Роли

15 карточек + on-demand hats — `references/roles.md`. Правила:

- Роль — шляпа; один owner на задачу; остальные reviewer/consultant.
- Постоянная роль владеет зоной; на задачу поднимается worker.
- Автор не ревьюит себя и не мержит свой PR.
- User Proxy без вето; White Hacker — вето только на security.
- Copywriter владеет голосом и текстами; Growth — каналами и метрикой.
- On-demand hats (Growth/Content, Support/Community, Legal/Privacy) —
  только под PBI; нет дейли и своего бэклога; Legal — вето на релиз.

## 3. Цикл

```
PLANNING → READY → BUILDING ⇄ BLOCKED → REVIEW → RETRO → CLOSED
```

Спринт = 4–6 циклов по 60–90 минут. Дейлик — на границе цикла, ≤ 10 мин.
Церемонии ≤ 20–25% бюджета.

| Фаза | Гейт |
|---|---|
| Planning | Goal, PBI Ready, Tier, `openspec validate` |
| Build | RED-evidence до кода, `verify`, ревью не-автора, T2-артефакты по волне |
| Review | только Done на preview, TDD/ATDD/T2-evidence, ACCEPT/REJECT |
| Retro | 1–2 действия с owner, debt/postmortem actions |
| Close | `verify` + validate + архив, исключения закрыты |

### Quality waves

Источник — `docs/quality/methodologies.md`; гейты по волнам —
`references/cycle.md`. Волна 1 сейчас: TDD/ATDD, contract, property,
threat model, runbook; mutation/SAST/alert/RUM — nightly/исключение.
Волны 2–3 — по методологии.

## 4. Планирование

0. PO: Tier T0/T1/T2 до оценки/change; T1/T2 — ATDD, T2 —
   contract/threat/SLO.
1. PO: цель + порядок; Sprint Goal — один исход; PBI в 4–6 циклов.
2. Behavior-changing PBI — OpenSpec change; `validate --strict`.
3. Architect — capability; QA — сценарии; White Hacker — abuse;
   Designer — UX; Copywriter — голос и сообщения.
4. SM фиксирует `sprint.md`, `.scrum/README.md`, `INDEX.md`; на задачу —
   brief.

Направление пусто — стоп и вопрос владельцу.

## 5. Сборка

Волны: контракты → фундамент → вертикальные срезы → полировка.

Durable-папка задачи — `.scrum/sprints/NN/tasks/<id>/`: `brief.md`,
`handoff.md`, `report.md`, `evidence/`. Worktree — runtime, не источник
истины; `/tmp` и чат запрещены.

На задачу:
0. Brief по `assets/brief.md` + read-back; worktree и durable-папка.
1. RED → GREEN → REFACTOR; worker пишет report/handoff/evidence и
   возвращает резюме ≤ 10 строк + ссылки.
2. Оркестратор прогоняет `verify`; reviewer читает brief/report/evidence/
   PR/diff, проверяет drift и «обещание теста = ссылка на тест».
3. Rebase → verify → evidence/doc-check → squash-merge → board → trace.
4. Lease снять, событие с task/pr/commit/artifact.

Мерж без TDD/ATDD-evidence, T2-артефакта текущей волны или doc-change
запрещён.

### Conflict-aware WIP

- 1–2 код-задачи; WIP 6 — потолок, не цель.
- Параллель только для независимых; общий файл/контракт — последовательно.
- Конфликт файлов — сигнал планировщику, не rebase-лотерея.
- 12 слотов: contract baseline, `owns:`, shared-file czar, contract
  sentinel, batch merge, circuit breaker. Детали —
  `references/orchestrator.md`.

## 6. Дейлик

До синка — 3 строки в `daily.md` (`assets/daily.md`): сделано с evidence /
следующее / блокер. Синк 10 минут: SM сверяет `.scrum/README.md` с
`state.json`/`board.json` (stale map — impediment), идёт по WIP/блокерам,
проверяет brief/report/evidence у активных задач. Выход — план цикла;
смена фазы — обновить карту. Артефакты — в durable-папке, не в `/tmp`.

## 7. Review, retro, close

Review: демо Done, QA прогоняет ATDD; reviewer читает brief/report/
evidence/PR/diff, проверяет RED-evidence, T2 и drift (старые имена,
будущее как текущее, обещание теста без ссылки, код vs чистовик).
PO — ACCEPT/REJECT; REJECT — в бэклог, не переделка спринта.

Retro: 1–2 действия с owner; проверить прошлые действия и postmortem.

Close: задачи `[x]`, `verify`, архив changes, CI зелёный, trace полон;
долг P3 — owner/срок; P0/P1 — postmortem; исключения закрыты или
просрочены в P1-долг; `.scrum/README.md` → `CLOSED/done`. Следующий
спринт — только по команде.

## 8. OpenSpec

Поведение пользователя/API — change; `specs/` — правда, менять только
через archive. DoR: `validate --strict`; DoD: `verify-change` + archive +
`validate --all`. Apply — только `tasks.md` и границы change; archive —
после merge отдельным PR. Одна capability — один change на волну;
багфикс/рефакторинг/инфра — `No spec change`. Status
`plan → active → done/superseded`; trace `task → change → PR → review →
archive`. Подробно — `references/openspec.md`.

## 9. Связь

Шина + sync/focus — 80–90%; council 3–5 ролей — на развилках; continuous —
P0/красный main/утечка. Каналы: `#sprint`, `#task-N`, `#contract`,
`#review-N`, `#incident`, `#design`, `#spec`. Вопрос — с адресатом и
дедлайном, 2 раунда, решение — в артефакт. Подробно —
`references/communication.md`.

## 10. Автопилот и остановки

Полный автопилот внутри. Человек — только: концепт, прод-релиз/секреты,
инцидент безопасности, бюджет > 90% / `.scrum/STOP`.

Стоп задачи: 3 неудачи, 3 REJECT, CI красный 2 цикла, конфликт контрактов
без решателя, анализ опрокинул задачу.

Вопрос: `.scrum/questions/NN.md` + уведомление, завершить ход.

## 10.1. Аудит методологии

Триггер: «аудит методологии» или после 3-го спринта; только при
материалах (pilot: 1 спринт / 5 merged / retro; full: 3 / 20 / 20
событий / 2 ретро). Нет — `No audit: insufficient material`. Read-only;
1–3 находки с доказательством, root cause, owner, метрикой; отчёт —
`docs/quality/audits/NN-*.md`. Метрики контекста: discovery/activation,
success, efficiency, errors, drift, durable %, trace, rework, stale
claims. Оценка — по конечному состоянию. Подробно — `references/audit.md`.

## 11. Куда писать

| Что | Куда | Кто |
|---|---|---|
| Карта входа | `.scrum/README.md` | SM/оркестратор, границы фаз |
| Goal, PBI, план, trace | `.scrum/sprints/NN/sprint.md` | SM/PO |
| Brief / report / handoff / evidence | `.scrum/sprints/NN/tasks/<id>/` | оркестратор / worker |
| Дейлик / обзор / ретро | `.scrum/sprints/NN/daily.md` / `review.md` / `retro.md` | SM |
| Review-артефакт | `.scrum/reviews/NN-<task>.md` | reviewer |
| Поведение | `openspec/specs/`, `openspec/changes/` | PO/Architect/QA |
| Зачем / как / вид / проверка | `docs/concept`, `docs/stack`, `docs/design`, `docs/quality/` | владельцы зон |
| Бэклог / направление | `docs/tasks/INDEX.md`, `backlog.md` | PO |
| Состояние | `.scrum/state.json`, `board.json`, `events.jsonl` | только оркестратор |

Правила:

- Один факт — один файл; остальное — ссылки. Чистовик без «возможно».
- `/tmp`, чат и worktree не источник истины; worktree — runtime.
- Brief/handoff/report переживают рестарт машины: они в `.scrum/`.
- В PR задачи — правка host-файла или `No doc change: <причина>`.
- Событие в `events.jsonl` несёт `task`, `pr`, `commit`, `artifact`, если
  применимо.

## 12. Чек-лист

- [ ] Init закрыт: Goal, сценарий, метрика, non-goals.
- [ ] `verify` работает; контракты смержены.
- [ ] У PBI есть change или «no spec change».
- [ ] `.scrum/README.md` свежая: phase/sprint/active tasks совпадают с
      `state.json`/`board.json`; ссылки живые.
- [ ] У задачи durable-папка `.scrum/sprints/NN/tasks/<id>/` с brief,
      report, handoff, evidence; не `/tmp`.
- [ ] Brief содержит objective/AC/owns/контракты/non-goals/output format/
      tools/evidence/stop conditions; read-back записан.
- [ ] Worker вернул резюме + ссылку; координатор не пересказывает весь
      отчёт.
- [ ] У задачи worktree, `owns:`, owner, evidence.
- [ ] `verify` прогнан оркестратором.
- [ ] Ревьюер — не автор; читал brief/report/evidence/PR/diff, не логи.
- [ ] Мерж последовательный; main зелёный.
- [ ] В review есть drift-проверка: старые имена, будущее как текущее,
      обещание теста = ссылка на тест.
- [ ] В PR — правка host-файла или `No doc change: <причина>`.
- [ ] Trace-таблица в `sprint.md` полна: task → change → PR → review →
      evidence → status; события несут task/pr/commit/artifact.
- [ ] WIP conflict-aware: 1–2, потолок 6; общие файлы/контракты —
      последовательно.
- [ ] Change заархивирован; спека обновлена.
- [ ] Дейлик, review, retro записаны.
- [ ] Tier T0/T1/T2 записан в PBI/change; T0 не требует TDD/ATDD, e2e
      и OpenSpec archive.
- [ ] Для T1/T2 есть ATDD happy/error, RED-evidence и e2e главного
      сценария.
- [ ] T2: threat model, contract/property, runbook/rollback;
      SLO-дизайн/логи обязательны; mutation/SAST/alert/RUM — по волне.
- [ ] Field RUM — owner-исключение до публичного запуска.
- [ ] Merge без evidence запрещён; «тесты зелёные» без RED не принимаются.
- [ ] Исключение: owner, причина, срок, артефакт; просрочка → P1-долг.
- [ ] P3-долг имеет owner/срок; P0/P1 — postmortem.
- [ ] Активная волна сверена с `docs/quality/methodologies.md`.
- [ ] После 3-го спринта — аудит методологии, если есть материалы.
- [ ] Обновление скилла — отдельным PR между спринтами; `VERSION`
      совпадает с target.
- [ ] Следующий спринт не начат без команды.

## 13. Файлы

`references/`: init, upgrade, scrum, roles, copywriting, cycle,
orchestrator, context, communication, openspec, git-quality,
failure-modes, audit.
`scripts/`: `slop-check.sh` — ловит штампы и давление; `motif-check.sh` —
повторяющиеся мотивы по корпусу текстов.
`assets/`: context, brief, report, sprint, daily, review, retro, handoff,
pr, audit; `task` — deprecated stub.
`VERSION`: установленная версия скилла.
