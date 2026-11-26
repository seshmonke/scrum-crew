---
name: Sprint Crew
description: Ведёт веб-разработку по Scrum командой из 12+ агентов — инициализация продукта, спринт 4–8 часов, 4–6 циклов, дейлик на границе цикла, 12 слотов в коде, OpenSpec для поведения, шина сообщений и последовательный merge train. Включать по команде владельца — «инициализируй проект», «запусти спринт», «через sprint-crew», «scrum спринт», «спланируй спринт», «проведи ретро».
---

# Sprint Crew

Оркестратор — эта сессия. Роли — субагенты. Состояние — `.scrum/`.
Поведение — `openspec/`. Правила проекта — `AGENTS.md`.

## Режимы

| Режим | Команда | Что делает |
|---|---|---|
| Init | «инициализируй проект» | продукт → стек → delivery → walking skeleton |
| Sprint | «запусти спринт» | планирование → сборка → review → retro |
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

## 1. Прочитать до спринта

`AGENTS.md` → `docs/tasks/INDEX.md` → `docs/quality/dod.md` →
`openspec list` → `.scrum/state.json` → `verify`.

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
| Planning | Goal в одну фразу, PBI Ready, `openspec validate` |
| Build | `verify` зелёный, ревью не-автора, main не красный |
| Review | только Done-инкремент на preview, ACCEPT/REJECT |
| Retro | 1–2 действия с owner |
| Close | `verify` + `openspec validate --all --strict` + архив |

Подробно: `references/cycle.md`.

## 4. Планирование

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
1. Worktree + `task.md` (`assets/task.md`).
2. Owner-субагент: role card + brief + контракты.
3. Отчёт: статус, файлы, команды, вывод, блокеры.
4. Оркестратор сам прогоняет `verify`.
5. Reviewer-субагент (не автор).
6. Rebase → verify → squash-merge → board.
7. Снять lease, записать событие.

12 слотов: contract baseline, `owns:`, shared-file czar, contract sentinel,
batch merge, circuit breaker (15% конфликтов / 30 мин красного main / 8 PR
в ревью → WIP 6). Детали — `references/orchestrator.md`.

## 6. Дейлик

До синка — 3 строки в `daily.md` (`assets/daily.md`): сделано с evidence /
следующее / блокер. Синк 10 минут: SM идёт по доске, говорят только WIP и
блокеры. Выход — план следующего цикла.

## 7. Review, retro, close

Review: демо Done-инкремента, QA прогоняет сценарий, PO — ACCEPT/REJECT,
специалисты — по строке. REJECT — задачи в бэклог, не переделка спринта.

Retro: 1–2 действия с owner; проверить прошлые действия.

Close: все задачи `[x]`, `verify` зелёный, changes заархивированы, CI
зелёный. Следующий спринт — только по команде.

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
- [ ] После 3-го спринта — аудит методологии, если есть материалы.
- [ ] Следующий спринт не начат без команды.

## 13. Файлы

`references/`: init, scrum, roles, cycle, orchestrator, communication,
openspec, git-quality, failure-modes, audit.
`assets/`: sprint, daily, review, retro, task, handoff, pr, audit.
