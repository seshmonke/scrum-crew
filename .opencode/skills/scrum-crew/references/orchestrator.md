# Оркестратор

Оркестратор — main-сессия. Он не «умный начальник», а диспетчер с правом
записи в состояние. Всё, что можно проверить командой, проверяется
командой. Контекст не пересказывается — он лежит в файлах и ссылках.

## Компоненты

```
.scrum/
  README.md       карта входа: phase, sprint, goal, gate, active tasks
  state.json      фаза, спринт, цикл, stop, human_gate
  events.jsonl    append-only: phase, gate, dispatch, report, review,
                  merge, drift, document, question, decision, stop
  board.json      задачи, статусы, owner, PR, change, brief, review
  budget.json     лимиты и расход
  locks/          lease на задачу/файлы
  sprints/NN/
    sprint.md     Goal, PBI, trace-таблица, гейты, итоги
    daily.md
    review.md
    retro.md
    evidence/     evidence уровня спринта/гейта
    tasks/<id>/
      brief.md    контекстный пакет задачи
      report.md   отчёт worker'а
      handoff.md  передача
      evidence/   RED/GREEN, вывод, скриншоты, замеры
  bus/            каналы сообщений
  questions/      вопросы владельцу
  reviews/        review-артефакты (<task>.md)
  metrics/        снимки
  memory/         память ролей
```

Единственный писатель `state.json` и `board.json` — оркестратор. Роли
пишут только свои артефакты, сообщения и PR. `.scrum/README.md` пишет
SM/оркестратор на границах фаз.

## Durable workspace

- Источник истины задачи — `.scrum/sprints/NN/tasks/<id>/`.
- Worktree/ветка — runtime; после merge их можно удалить, артефакты
  остаются.
- `/tmp`, чат и логи сессии — не хранилище. Если worker начал там —
  остановить, перенести в task-папку, проверить ссылки.
- Brief, report, handoff и evidence переживают рестарт машины и смену
  сессии; они коммитятся с задачей/спринтом. Нет файла — задача не начата
  или не сдана.
- Один owner на папку задачи. Другие пишут только в свою папку или в
  `reviews/`.

## Фазы

```
INIT → PLANNING → READY → BUILDING ⇄ BLOCKED → REVIEW → RETRO → CLOSED
                                   ↘ ESCALATED
```

Переход только по гейту. Гейт — команда + exit code + evidence, а не
мнение. На каждой границе фаз оркестратор обновляет `.scrum/README.md`
(phase, sprint, goal, next gate, active tasks) и проверяет ссылки.

## Диспатч

1. Выбрать PBI: порядок PO → зависимости → конфликт файлов → WIP.
   Код-задачи с общими файлами/контрактом — последовательно, 1–2 в работе.
2. Проверить DoR: change, `validate --strict`, AC, Tier, `owns:`,
   T2-артефакты.
3. Создать worktree `task/NN-*` и durable-папку
   `.scrum/sprints/NN/tasks/<id>/`; brief — по `assets/brief.md`, с
   контекстной шапкой.
4. Записать lease в `.scrum/locks/NN.json` (owner, expires_at).
5. Запустить owner-субагента: role card + brief + 2–5 ссылок. Потребовать
   read-back «Понял: … Делаю: …» до первой правки; без read-back задача не
   начата.
6. Получить `report.md` и короткое резюме (≤ 10 строк) + ссылки на
   report/evidence/PR. Не пересказывать весь отчёт в чат.
7. Самому прогнать `verify`; не доверять отчёту.
8. Запустить reviewer-субагента (другая роль, желательно другая модель).
   Reviewer читает brief, report, evidence, PR и diff; не логи.
9. Rebase → verify → evidence check → doc-change check → squash-merge →
   board → trace.
10. Снять lease, записать событие с `task`, `pr`, `commit`, `artifact`;
    обновить метрики и карту, если граница фазы.

## Контекстный пакет

Brief — `assets/brief.md`; принципы и пример на 3 ссылки —
`references/context.md`. Агенту не даётся весь репозиторий: только brief,
2–5 ссылок, DoD и read-back. Больше 5 ссылок — дробить задачу, а не лить
в чат.

## Conflict-aware WIP

- 1–2 код-задачи в работе; WIP 6 — потолок, не цель.
- Параллель только для независимых: пересечение `owns:` или общего
  контракта запрещает параллельный старт.
- Общий файл — через shared-file czar; общий контракт — сначала
  contract baseline, потом срезы.
- Признак конфликта файлов — сигнал планировщику: сериализовать, дробить
  или менять порядок. Rebase-лотерея запрещена.
- 12 слотов — это ёмкость, а не приглашение запускать 12 задач.

## Трассировка и события

Trace-таблица — `assets/sprint.md`; колонки task/brief/change/PR/review/
evidence/status. `board.json` — источник истины по статусу; таблица —
производная, расхождение — провал гейта. Каждая строка ведёт к brief,
change, PR, review и evidence.

Событие в `events.jsonl`:

```json
{"ts":"2026-11-28T10:15:00Z","type":"merge","sprint":3,"task":"03.2","pr":118,"commit":"a1b2c3d","artifact":".scrum/sprints/03/tasks/03.2/report.md","gate":"verify","exit":0}
```

Обязательные поля, если применимо: `task`, `pr`, `commit`, `artifact`.
Без них аудит не соберёт trace и rework.

## Гейты

```
pnpm verify
pnpm test:e2e
openspec validate --all --strict

# owner-exception до появления скриптов:
pnpm audit:security   # Q1.4
pnpm test:a11y        # Wave 2
pnpm budget:perf      # Q1.6
```

В `sprint.md` / `evidence/` пишется: команда, exit code, хвост вывода,
commit SHA. «Зелёно» без вывода не принимается.

Дополнительные гейты контекста:

- `.scrum/README.md` совпадает с `state.json`/`board.json`, ссылки живые.
- У задачи есть durable brief/report/evidence; read-back записан.
- Reviewer проверил drift и «обещание теста = ссылка на тест».
- В PR — правка host-файла или `No doc change: <причина>`.
- Trace-таблица полна; событие несёт task/pr/commit/artifact.

## Merge train

Личный приватный репозиторий не даёт GitHub merge queue. Поэтому:

1. PR открыт; обязательные checks зелёные.
2. Evidence: TDD/ATDD для T1/T2; T2-артефакты текущей волны; brief,
   report, evidence в task-папке. Нет evidence — PR не мержится.
3. Reviewer (не автор) оставил review-артефакт с task id и PR.
4. `review-gate` ставит статус.
5. Оркестратор: rebase на main → verify → squash-merge → удалить ветку.
6. Следующий PR — только после зелёного main.
7. Конфликт/красный — назад автору с ошибкой как следующим промптом.
8. Один мерж за раз. Параллельный мерж запрещён.
9. Пакет из нескольких PR: rebase всех → CI на пакете → мерж по одному;
   красный пакет — бисекция.
10. После merge — trace, board, event; при необходимости — README.

## Бюджет

- Лимит на спринт, роль, задачу.
- 70% — снизить параллелизм.
- 90% — только завершение и закрытие.
- 100% — стоп.
- 3 неудачи на задаче → park + вопрос.
- 3 REJECT → вопрос владельцу.
- CI красный > 2 циклов → стоп фич, чинить trunk.
- Гейт методологии обойдён (нет RED-evidence, T2-артефакта, doc-change
  или исключения) → стоп и разбор.
- Карта устарела/ссылка битая → стоп и починить.
- `.scrum/STOP` — жёсткий стоп на каждом шаге.

## Именованные сессии

- У роли своя сессия: `ses-po`, `ses-fe`, `ses-be`, `ses-qa`, …
- Память — устойчивые конвенции и решения.
- Apply — отдельная сессия на change, чистый контекст.
- Archive — 5 строк в `memory/<role>.md`, остальное в артефакты.
- Смена change = смена working set.
- Новая сессия начинает с `.scrum/README.md` + brief, а не с корня.

## Автопилот

Внутри спринта человек не нужен. Исключения:
1. концептуальное решение;
2. прод-релиз и прод-секреты;
3. инцидент безопасности;
4. бюджет > 90% / STOP.

Вопрос: `.scrum/questions/NN.md` + уведомление + завершить ход. Ответ
продолжает ту же сессию.

## Восстановление

1. Прочитать `.scrum/README.md` — phase, sprint, active tasks, next gate.
2. Прочитать `state.json` — фаза и цикл; `board.json` — где задачи.
3. Прочитать `sprint.md` и `tasks/<id>/brief.md` + `report.md` +
   `handoff.md` — что уже сделано.
4. `openspec list` — активные changes.
5. Продолжить с последнего незакрытого гейта; не начинать заново.
6. `events.jsonl` — только точечно (`tail`, `grep` по task/pr), не как
   нарратив.

- Сетевая ошибка — повторить фазу с той же точки входа.
- Повтор не чинит — стоп и вопрос.
- Сессия переживает сон машины: после пробуждения — «продолжи».
- Потеря состояния — читать durable-артефакты, не выдумывать; missing
  artifact — finding, а не повод реконструировать из логов.
- Красный main — фиксить или revert; следующий спринт не начинать.

## Псевдокод цикла

```text
read AGENTS.md, .scrum/README.md, board, state
if no product goal: ask owner; stop
if map stale or link broken: stop and fix
planning()
while cycle < cycles and phase == BUILDING:
    dispatch_wave()
    collect_reports()      # summary + links
    verify_all()
    review_all()           # artifacts, not logs
    merge_train()
    standup()
review()
retro()
close()
```

## Что оркестратор не делает

- Не пишет код за роли (кроме мелких правок в гейтах).
- Не ревьюит вместо ревьюера.
- Не принимает «зелено» на слово.
- Не мержит PR без TDD/ATDD-evidence, T2-артефакта текущей волны или
  doc-change.
- Не мержит параллельно.
- Не начинает следующий спринт без команды.
- Не выдумывает продукт, стек и состав.
- Не держит brief/handoff/report в `/tmp` или в чате.
- Не копирует факты в `.scrum/README.md`; карта — ссылки.
- Не запускает 12 задач только потому, что есть 12 слотов.
