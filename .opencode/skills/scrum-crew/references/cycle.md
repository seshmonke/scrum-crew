# Цикл: церемонии и шаги

Шаблоны — в `assets/`. Здесь — последовательность и гейты.

## Файл спринта

`docs/tasks/NN-краткое.md` по шаблону `assets/sprint.md`.

Обязательно: цель одной фразой, задачи-чекбоксы, `Change:` для
behavior-changing PBI, `owns:`, evidence, «Проверка владельцем», риски,
«Ход фаз», итоги.

После закрытия файл остаётся историей.

## Планирование

0. PO: Tier T0/T1/T2 до оценки и change; сомнение T1/T2 → T2.
1. PO: цель направления + порядок бэклога.
2. Sprint Goal — один наблюдаемый исход.
3. PO + Architect: затронутые capability.
4. Change на каждый behavior-changing PBI.
5. QA: ATDD happy/error до кода; White Hacker: abuse cases;
   Architect: contract; для T2 — threat model; DevSecOps: SLO/бюджет;
   Designer: UX.
6. Оценка t-shirt; проверка, что влезает в 4–6 циклов.
7. SM: файл спринта + строка в `INDEX.md`.
8. `openspec validate <change> --strict` по каждому.
9. Записать риски, зависимости, `owns:`.

Выход: Goal, Sprint Backlog, changes, риски, evidence-формат.
T0: TDD/ATDD/e2e/archive не применяются; `verify` + проверка
ссылок/фактов.
Направление пусто — стоп и вопрос.

Если PBI касается запуска, контента, поддержки или легала — активировать
on-demand шляпу **только на этот PBI**: Growth/Content, Support/Community
или Legal/Privacy. Они не входят в дейли, не имеют своего бэклога; задачи
идут через PO. Legal может наложить вето на релиз.

## Дейлик

До синка — `assets/daily.md`, 3 строки от активных.
Синк 10 минут:
1. SM идёт по доске.
2. Говорят только WIP и блокеры.
3. Решение: продолжить / перепланировать / эскалировать.
4. Записать impediments и план следующего цикла.

Запрещено: пересказ диффа, статус-отчёт, обсуждение вне Goal.

## Сборка

1. **RED:** тест на AC/дефект падает по ожидаемой причине.
2. **GREEN:** минимальный код; тест и полный suite зелёные.
3. **REFACTOR:** без изменения поведения; тесты остаются зелёными.
4. Evidence — в `task.md`/PR, включая e2e главного сценария; для T2 —
   артефакты текущей волны.
5. Merge только после проверки evidence: нет RED/T2-артефакта — не мержится.

## Обзор

1. Демо только Done-инкремента на preview.
2. QA прогоняет ATDD-сценарий; reviewer подтверждает RED-evidence и
   T2-гейты текущей волны.
3. Специалисты — по строке: design / security / perf / a11y.
4. User Proxy — гипотезы с пометкой.
5. PO — ACCEPT/REJECT с причиной.
6. Новые задачи — в бэклог.
7. Записать `assets/review.md`.

## Ретро

1. 3 что сработало, 3 что мешало.
2. 1–2 действия: что меняем, owner, когда проверим.
3. Проверить действия прошлого ретро.
4. Записать `assets/retro.md`; действия — в следующий спринт.

## Закрытие

1. Все задачи `[x]`; `verify` зелёный.
2. `openspec validate --all --strict`; changes заархивированы.
3. Коммит закрытия → пуш → CI.
4. Красный CI — стоп, следующий спринт не начинать.
5. `state.json` → `CLOSED`; событие в `events.jsonl`.
6. Debt: P3 имеют owner/срок; debt-бюджет записан.
7. Postmortem P0/P1: actions с owner/сроком; закрытие проверено.
8. Исключения закрыты или просрочены → P1-долг.
9. Следующий спринт — только по команде.

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

- Бриф задачи — `assets/task.md`.
- Передача — `assets/handoff.md` + read-back получателя.
- Вопрос владельцу — `.scrum/questions/NN.md`:

```markdown
# Вопрос NN
## Контекст
## Вопрос (один, с вариантами)
## Рекомендация + trade-off
## Что заблокировано
```
