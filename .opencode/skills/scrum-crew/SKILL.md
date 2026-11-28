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

Не спринт. Триггеры: «обнови скилл», «обнови scrum-crew», «перейди на
новую версию». Только по команде владельца и между спринтами.

1. Установленная версия — `.opencode/skills/scrum-crew/VERSION`.
2. Прочитать `references/upgrade.md`.
3. Гейт: рабочее дерево чистое, спринт закрыт, target — released tag,
   владелец подтвердил.
4. Обновление — отдельный PR; `.scrum/`, `openspec/`, `docs/` и код не
   трогать.

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

14 карточек — `references/roles.md`.

PO, SM, Architect, Fullstack, Frontend, Backend, Data, QA, Tester,
DevSecOps, White Hacker, Designer, User Proxy, Delivery, Methodology
Auditor (on-demand) + worker.

On-demand hats: **Growth / Content**, **Support / Community**,
**Legal / Privacy**.

Правила:
- Роль — шляпа, не отдельный репозиторий и не свой бэклог.
- Постоянная роль владеет зоной; на задачу поднимается worker.
- Один owner на задачу; остальные — reviewer/consultant.
- Автор не ревьюит себя и не мержит свой PR.
- User Proxy без права вето; White Hacker — вето только на security.

### On-demand hats

Growth / Content, Support / Community, Legal / Privacy не входят в
постоянный состав. Активируются только под PBI, который касается их
домена. Нет дейли, нет своего бэклога, нет отдельного репо. Задачи — в
общий бэклог через PO. Legal имеет вето на релиз при нарушении закона или
приватности; это не замена юристу.

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

Источник — `docs/quality/methodologies.md`.

| Волна | Когда | Что блокирует merge |
|---|---|---|
| 1 | сейчас | TDD/ATDD, contract, property, threat model, runbook/rollback; mutation — nightly; SAST — ручной/исключение; SLO-дизайн/логи обязательны, alert/RUM — исключение |
| 1 | после merge Q1.0–Q1.6 | все T2-гейты; field RUM — исключение до публичного запуска |
| 2 | Sprint 5–6 | trunk-based + flags, performance/load, полный incident-процесс |
| 3 | до публичного запуска | IaC + progressive delivery, ASVS/SBOM/DAST, debt-бюджет |

Подробно: `references/cycle.md`.

## 4. Планирование

0. PO: Tier T0/T1/T2 до оценки и change. Для T1/T2 QA — ATDD
   happy/error; для T2 Architect — contract/threat model, DevSecOps —
   SLO/бюджет.
1. PO: цель из направления + порядок бэклога.
2. Sprint Goal — один наблюдаемый исход.
3. PBI, укладывающиеся в 4–6 циклов.
4. На behavior-changing PBI — OpenSpec change (proposal, specs, design,
   tasks).
5. Architect — границы capability; QA — сценарии; White Hacker — abuse
   cases; Designer — UX.
6. SM фиксирует `.scrum/sprints/NN/sprint.md`, `.scrum/README.md` и
   строку в `INDEX.md`.
7. `openspec validate <change> --strict` по каждому; на задачу — brief.

Направление пусто — стоп и вопрос владельцу.

## 5. Сборка

Волны: контракты → фундамент → вертикальные срезы → полировка.

Durable-папка задачи — `.scrum/sprints/NN/tasks/<id>/`: `brief.md`,
`handoff.md`, `report.md`, `evidence/`. Worktree — runtime, не источник
истины; `/tmp` и чат запрещены.

На задачу:
0. Brief по `assets/brief.md`: objective, AC, owns, контракты, non-goals,
   output format, tools/sources, evidence, stop conditions.
1. Owner-субагент: role card + brief + 2–5 ссылок; read-back «Понял: …
   Делаю: …» до первой правки. Worktree и durable-папка уже созданы.
2. RED до кода: тест на AC/дефект падает по ожидаемой причине.
3. Worker пишет `report.md`, `handoff.md`, `evidence/`; координатору
   возвращает резюме ≤ 10 строк + ссылки, не весь текст.
4. Оркестратор сам прогоняет `verify`; evidence-check по AC.
5. Reviewer (не автор) читает brief, report, evidence, PR и diff;
   проверяет drift и «обещание теста = ссылка на тест».
6. Rebase → verify → evidence check → doc-check → squash-merge → board →
   trace.
7. Снять lease, записать событие с task/pr/commit/artifact.

Мерж без TDD/ATDD-evidence, T2-артефакта текущей волны или doc-change
запрещён.

### Conflict-aware WIP

- В работе 1–2 код-задачи; WIP 6 — потолок, не цель.
- Параллель — только для независимых задач: нет общих файлов и
  контрактов.
- Общий файл/контракт — последовательно или дробить; признак конфликта —
  сигнал планировщику, а не повод для rebase-лотереи.
- 12 слотов: contract baseline, `owns:`, shared-file czar, contract
  sentinel, batch merge, circuit breaker (15% конфликтов / 30 мин красного
  main / 8 PR в ревью → WIP 1–2, не выше 6). Детали —
  `references/orchestrator.md`.

## 6. Дейлик

До синка — 3 строки в `daily.md` (`assets/daily.md`): сделано с evidence /
следующее / блокер. Артефакты задачи — в durable-папке, не в чате и не в
`/tmp`.

Синк 10 минут:
1. SM сверяет карту: `.scrum/README.md` — phase/sprint/active tasks
   совпадают с `state.json`/`board.json`; битая ссылка — impediment.
2. SM идёт по доске; говорят только WIP и блокеры.
3. Проверить, что у активных задач есть `brief.md`, `report.md`,
   `evidence/`; нет — стоп и восстановить.
4. Выход — план следующего цикла; при смене фазы — обновить карту.

## 7. Review, retro, close

Review: демо Done, QA прогоняет ATDD-сценарий; reviewer проверяет, что
тест падал без кода, и T2-гейты текущей волны. Reviewer читает brief,
report, evidence, PR и diff, а не реконструирует картину из логов.

Drift-проверка: старые имена/пути, будущее как текущее (`status: plan`),
обещание теста без ссылки на тест, расхождение кода и чистовика,
скопированные метрики/API. PO — ACCEPT/REJECT, специалисты — по строке.
REJECT — в бэклог, не переделка спринта.

Retro: 1–2 действия с owner; проверить прошлые действия и postmortem-actions.

Close: задачи `[x]`, `verify`, changes заархивированы, CI зелёный.
Долг P3 — owner/срок; P0/P1 — postmortem; исключения закрыты или
просрочены в P1-долг. Следующий спринт — только по команде.

## 8. OpenSpec

- Поведение, видимое пользователю/API, требует change.
- `openspec/specs/` — правда; менять только через archive.
- DoR: `validate --strict`; DoD: `verify-change` + archive + `validate --all`.
- Apply: только `tasks.md`, только границы change.
- Archive: после merge, отдельным PR в конце цикла.
- Одна capability — один активный change на волну.
- Багфикс/рефакторинг/инфра/косметика — без change, строка причины в PR.
- Change status: `plan` → `active` → `done`/`superseded`; `plan` — не
  текущая правда. Трассировка: `task → change → PR → review → archive`.
- Archive после merge; review-артефакт и task id связаны с change.

Подробно: `references/openspec.md`.

## 9. Связь

Три уровня: шина + sync/focus (80–90%), design council 3–5 ролей на 20 мин
(развилки), continuous (P0/красный main/утечка).

Каналы: `#sprint`, `#task-N`, `#contract`, `#review-N`, `#incident`,
`#design`, `#spec`. Вопрос — с адресатом и дедлайном; 2 раунда; возражение
с доказательством; решение — в артефакт.

Подробно: `references/communication.md`.

## 10. Автопилот и остановки

Полный автопилот внутри. Человек — только: концепт, прод-релиз/секреты,
инцидент безопасности, бюджет > 90% / `.scrum/STOP`.

Стоп задачи: 3 неудачи, 3 REJECT, CI красный 2 цикла, конфликт контрактов
без решателя, анализ опрокинул задачу.

Вопрос: `.scrum/questions/NN.md` + уведомление, завершить ход.

## 10.1. Аудит методологии

Триггер: «аудит методологии» или после 3-го закрытого спринта.
Запускать только при материалах:

- **pilot:** ≥ 1 закрытый спринт, ≥ 5 merged задач, есть `retro.md` и
  метрики;
- **full:** ≥ 3 спринта, ≥ 20 merged, ≥ 20 событий, 2+ ретро.

Нет условий — одна строка `No audit: insufficient material` и стоп.
Никаких выводов на пустоте.

Read-only к коду/скиллу/спекам; единственная запись — отчёт. 1–3 находки:
доказательство, root cause, proposal, owner, метрика. Отчёт —
`docs/quality/audits/NN-*.md` по `assets/audit.md`.
Изменения — через ADR/PR, не в спринте. Нет эффекта два аудита — удалить
роль.

Метрики контекста: discovery/activation (нашёл ли агент вход), task
success, efficiency, errors/recovery, drift, durable brief/handoff,
trace completeness, rework из-за контекста, stale claims. Оценка — по
конечному состоянию и чекпоинтам, не по «правильному пути». Подробно —
`references/audit.md`.

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

`references/`: init, upgrade, scrum, roles, cycle, orchestrator, context,
communication, openspec, git-quality, failure-modes, audit.
`assets/`: context, brief, report, sprint, daily, review, retro, handoff,
pr, audit; `task` — deprecated stub.
`VERSION`: установленная версия скилла.
