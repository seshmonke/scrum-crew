# Цикл: церемонии и шаги

Шаблоны — в `assets/`. Здесь — последовательность и гейты.

## Файл спринта

`.scrum/sprints/NN/sprint.md` по шаблону `assets/sprint.md`.

Структура — `assets/sprint.md`: Goal, PBI, `Change:`, `owns:`, trace,
гейты, риски, ход фаз, итоги. Рядом — `.scrum/README.md` и
`tasks/<id>/` с brief/report/handoff/evidence. `INDEX.md` ссылается на
файл спринта; старые `docs/tasks/NN-*.md` — история.

После закрытия файл остаётся историей.

## Планирование

0. PO: Tier T0/T1/T2 до оценки и change; сомнение T1/T2 → T2.
1. PO: цель направления + порядок бэклога.
2. Sprint Goal — один наблюдаемый исход.
3. PO + Architect: затронутые capability.
4. Change на каждый behavior-changing PBI.
5. QA: ATDD happy/error до кода; White Hacker: abuse cases;
   Architect: contract; для T2 — threat model; DevSecOps: SLO/бюджет;
   Designer: UX; Copywriter: голос и сообщения.
6. Оценка t-shirt; проверка, что влезает в 4–6 циклов.
7. SM: `.scrum/sprints/NN/sprint.md` + строка в `INDEX.md` +
   `.scrum/README.md` (phase `PLANNING/READY`, ссылки).
8. `openspec validate <change> --strict` по каждому.
9. Записать риски, зависимости, `owns:`.
10. На задачу — durable-папку и `brief.md` по `assets/brief.md`; read-back
    до старта.

Выход: Goal, Sprint Backlog, changes, риски, evidence-формат, brief'ы.
T0: TDD/ATDD/e2e/archive не применяются; `verify` + проверка
ссылок/фактов.
Направление пусто — стоп и вопрос.

Если PBI меняет текст, лендинг, UI или письма — Copywriter в planning.
Если PBI касается запуска, каналов, поддержки или легала — активировать
on-demand шляпу **только на этот PBI**: Growth/Content, Support/Community
или Legal/Privacy. Они не входят в дейли, не имеют своего бэклога; задачи
идут через PO. Legal может наложить вето на релиз.

## Дейлик

До синка — `assets/daily.md`, 3 строки от активных; артефакты — в
durable-папке, не в чате.
Синк 10 минут:
1. SM сверяет `.scrum/README.md` с `state.json`/`board.json`; битая
   ссылка — impediment.
2. SM идёт по доске.
3. Говорят только WIP и блокеры.
4. Проверить brief/report/evidence у активных задач.
5. Решение: продолжить / перепланировать / эскалировать.
6. Записать impediments и план следующего цикла.

Запрещено: пересказ диффа, статус-отчёт, обсуждение вне Goal.

## Сборка

1. **Brief + read-back:** objective/AC/owns/контракты/non-goals/output
   format/tools/evidence/stop conditions; «Понял: … Делаю: …».
2. **RED:** тест на AC/дефект падает по ожидаемой причине.
3. **GREEN:** минимальный код; тест и полный suite зелёные.
4. **REFACTOR:** без изменения поведения; тесты остаются зелёными.
5. Evidence — в `.scrum/sprints/NN/tasks/<id>/evidence/` и `report.md`,
   включая e2e главного сценария; для T2 — артефакты текущей волны.
6. Worker пишет `handoff.md`; координатору — резюме + ссылка.
7. Merge только после проверки evidence: нет RED/T2-артефакта или
   doc-change — не мержится.

## Обзор

1. Демо только Done-инкремента на preview.
2. QA прогоняет ATDD-сценарий; reviewer читает brief/report/evidence/PR/
   diff и подтверждает RED-evidence и T2-гейты текущей волны.
3. Drift-проверка: старые имена, будущее как текущее, обещание теста без
   ссылки, код vs чистовик, `No doc change`.
4. Специалисты — по строке: copy / design / security / perf / a11y.
5. User Proxy — гипотезы с пометкой.
6. PO — ACCEPT/REJECT с причиной.
7. Новые задачи — в бэклог.
8. Записать `assets/review.md` и `.scrum/reviews/NN-<task>.md` с task id и
   PR.

## Ретро

1. 3 что сработало, 3 что мешало.
2. 1–2 действия: что меняем, owner, когда проверим.
3. Проверить действия прошлого ретро.
4. Записать `assets/retro.md`; действия — в следующий спринт.

## Закрытие

1. Все задачи `[x]`; `verify` зелёный.
2. `openspec validate --all --strict`; changes заархивированы.
3. Trace-таблица полна: task → change → PR → review → evidence → status.
4. Brief/report/handoff/evidence — в durable-папках; `/tmp` не использован.
5. Коммит закрытия → пуш → CI.
6. Красный CI — стоп, следующий спринт не начинать.
7. `state.json` → `CLOSED`; событие в `events.jsonl`; `.scrum/README.md` →
   `CLOSED/done` и ссылка на итоговый `sprint.md`.
8. Debt: P3 имеют owner/срок; debt-бюджет записан.
9. Postmortem P0/P1: actions с owner/сроком; закрытие проверено.
10. Исключения закрыты или просрочены → P1-долг.
11. Следующий спринт — только по команде.

## Задачный конвейер

```
proposed → ready → claimed → in_progress → in_review
→ changes_requested → approved → merged → verified → done
```

| Шаг | Кто | Гейт |
|---|---|---|
| proposed | PO/любой | ценность и AC |
| ready | PO + QA + Architect | DoR, change, `validate` |
| claimed | оркестратор | lease, worktree, brief |
| in_progress | owner | — |
| in_review | reviewer | diff, тесты, evidence |
| approved | reviewer | P0/P1 закрыты |
| merged | оркестратор | rebase + verify + CI |
| verified | QA | сценарий на preview |
| done | PO | DoD |

## Бриф и передача

- Бриф задачи — `assets/brief.md`, durable-путь
  `.scrum/sprints/NN/tasks/<id>/brief.md`.
- Отчёт worker'а — `assets/report.md`, путь `.../report.md`; координатору —
  резюме + ссылка.
- Передача — `assets/handoff.md` + read-back получателя, путь
  `.../handoff.md`.
- Вопрос владельцу — `.scrum/questions/NN.md`:

```markdown
# Вопрос NN
## Контекст
## Вопрос (один, с вариантами)
## Рекомендация + trade-off
## Что заблокировано
```
