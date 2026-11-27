---
name: scrum-crew
description: Ведёт веб-разработку по Scrum командой из 12+ агентов — инициализация продукта, спринт 4–8 часов, 4–6 циклов, дейлик на границе цикла, 12 слотов в коде, OpenSpec для поведения, шина сообщений и последовательный merge train. Включать по команде владельца — «инициализируй проект», «запусти спринт», «через scrum-crew», «через sprint-crew» (legacy), «scrum спринт», «спланируй спринт», «проведи ретро».
---

# Scrum Crew

Оркестратор — эта сессия. Роли — субагенты. Состояние — `.scrum/`.
Поведение — `openspec/`. Правила проекта — `AGENTS.md`.

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
   `.scrum/`, `openspec init`.
4. **Первый change:** walking skeleton — healthcheck → экран → API → БД →
   preview. Не sprint 0 и не «вся инфраструктура».

Гейт: владелец подтвердил Goal, сценарий, метрику, non-goals; `verify`
работает; preview открывается; первый change создан. Только после этого —
команда на Sprint 1.

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

`AGENTS.md` → `docs/tasks/INDEX.md` → `docs/quality/methodologies.md` →
`docs/quality/dod.md` → `openspec list` → `.scrum/state.json` → `verify`.

Чего нет — спросить владельца. Продукт, стек и состав спринта не
выдумывать.

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
6. SM фиксирует спринт и строку в `INDEX.md`.
7. `openspec validate <change> --strict` по каждому.

Направление пусто — стоп и вопрос владельцу.

## 5. Сборка

Волны: контракты → фундамент → вертикальные срезы → полировка.

На задачу:
0. RED до кода: тест на AC/дефект падает по ожидаемой причине.
1. Worktree + `task.md` с Tier, артефактами и RED-требованием.
2. Owner-субагент: role card + brief + контракты.
3. Отчёт: статус, файлы, команды, вывод, RED/GREEN, блокеры.
4. Оркестратор сам прогоняет `verify`.
5. Reviewer-субагент (не автор).
6. Rebase → verify → evidence check → squash-merge → board.
7. Снять lease, записать событие.

Мерж без TDD/ATDD-evidence или T2-артефакта текущей волны запрещён.

12 слотов: contract baseline, `owns:`, shared-file czar, contract sentinel,
batch merge, circuit breaker (15% конфликтов / 30 мин красного main / 8 PR
в ревью → WIP 6). Детали — `references/orchestrator.md`.

## 6. Дейлик

До синка — 3 строки в `daily.md` (`assets/daily.md`): сделано с evidence /
следующее / блокер. Синк 10 минут: SM идёт по доске, говорят только WIP и
блокеры. Выход — план следующего цикла.

## 7. Review, retro, close

Review: демо Done, QA прогоняет ATDD-сценарий; reviewer проверяет, что
тест падал без кода, и T2-гейты текущей волны. PO — ACCEPT/REJECT,
специалисты — по строке. REJECT — в бэклог, не переделка спринта.

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
роль. Подробно — `references/audit.md`.

## 11. Куда писать

| Что | Куда |
|---|---|
| Goal, PBI, план | `docs/tasks/NN-*.md` |
| Дейлик / обзор / ретро | `daily.md` / `review.md` / `retro.md` |
| Поведение | `openspec/specs/`, `openspec/changes/` |
| Зачем / как / вид / проверка | `docs/concept|stack|design|quality/` |
| Состояние | `.scrum/state.json`, `board.json`, `events.jsonl` |

Один факт — один файл. Чистовик без «возможно».

## 12. Чек-лист

- [ ] Init закрыт: Goal, сценарий, метрика, non-goals.
- [ ] `verify` работает; контракты смержены.
- [ ] У PBI есть change или «no spec change».
- [ ] У задачи worktree, `owns:`, owner, evidence.
- [ ] `verify` прогнан оркестратором.
- [ ] Ревьюер — не автор.
- [ ] Мерж последовательный; main зелёный.
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

`references/`: init, upgrade, scrum, roles, cycle, orchestrator,
communication, openspec, git-quality, failure-modes, audit.
`assets/`: sprint, daily, review, retro, task, handoff, pr, audit.
`VERSION`: установленная версия скилла.
