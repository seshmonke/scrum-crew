# Оркестратор

Оркестратор — main-сессия. Он не «умный начальник», а диспетчер с правом
записи в состояние. Всё, что можно проверить командой, проверяется
командой.

## Компоненты

```
.scrum/
  state.json      фаза, спринт, цикл, stop, human_gate
  events.jsonl    append-only: phase, gate, question, decision, merge
  board.json      задачи, статусы, owner, PR, change
  budget.json     лимиты и расход
  locks/          lease на задачу/файлы
  sprints/NN/     sprint.md, daily.md, review.md, retro.md, evidence/
  bus/            каналы сообщений
  questions/      вопросы владельцу
  reviews/        review-артефакты
  metrics/        снимки
  memory/         память ролей
```

Единственный писатель `state.json` и `board.json` — оркестратор. Роли
пишут только свои артефакты, сообщения и PR.

## Фазы

```
INIT → PLANNING → READY → BUILDING ⇄ BLOCKED → REVIEW → RETRO → CLOSED
                                   ↘ ESCALATED
```

Переход только по гейту. Гейт — команда + exit code + evidence, а не
мнение.

## Диспатч

1. Выбрать PBI: порядок PO → зависимости → конфликт файлов → WIP.
2. Проверить DoR: change, `validate --strict`, AC, `owns:`.
3. Создать worktree `task/NN-*` и `task.md`.
4. Записать lease в `.scrum/locks/NN.json` (owner, expires_at).
5. Запустить owner-субагента: role card + brief + контракты + evidence.
6. Получить `report.json`.
7. Самому прогнать `verify`; не доверять отчёту.
8. Запустить reviewer-субагента (другая роль, желательно другая модель).
9. Rebase → verify → squash-merge → обновить board → снять lease.
10. Записать событие и обновить метрики.

### Контекстный пакет

Агенту не даётся весь репозиторий и вся история. Даётся:
- Sprint Goal (1 строка);
- `task.md` (AC, скоуп, non-goals);
- контракты;
- 2–5 ссылок на доки;
- DoD и формат evidence;
- границы и стоп-условия.

## Гейты

```
pnpm verify
pnpm test:e2e
pnpm audit:security
pnpm test:a11y
pnpm budget:perf
openspec validate --all --strict
```

В `sprint.md` / `evidence/` пишется: команда, exit code, хвост вывода,
commit SHA. «Зелёно» без вывода не принимается.

## Merge train

Личный приватный репозиторий не даёт GitHub merge queue. Поэтому:

1. PR открыт; обязательные checks зелёные.
2. Reviewer (не автор) оставил review-artifact.
3. `review-gate` ставит статус.
4. Оркестратор: rebase на main → verify → squash-merge → удалить ветку.
5. Следующий PR — только после зелёного main.
6. Конфликт/красный — назад автору с ошибкой как следующим промптом.
7. Один мерж за раз. Параллельный мерж запрещён.
8. Пакет из нескольких PR: rebase всех → CI на пакете → мерж по одному;
   красный пакет — бисекция.

## Бюджет

- Лимит на спринт, роль, задачу.
- 70% — снизить параллелизм.
- 90% — только завершение и закрытие.
- 100% — стоп.
- 3 неудачи на задаче → park + вопрос.
- 3 REJECT → вопрос владельцу.
- CI красный > 2 циклов → стоп фич, чинить trunk.
- `.scrum/STOP` — жёсткий стоп на каждом шаге.

## Именованные сессии

- У роли своя сессия: `ses-po`, `ses-fe`, `ses-be`, `ses-qa`, …
- Память — устойчивые конвенции и решения.
- Apply — отдельная сессия на change, чистый контекст.
- Archive — 5 строк в `memory/<role>.md`, остальное в артефакты.
- Смена change = смена working set.

## Автопилот

Внутри спринта человек не нужен. Исключения:
1. концептуальное решение;
2. прод-релиз и прод-секреты;
3. инцидент безопасности;
4. бюджет > 90% / STOP.

Вопрос: `.scrum/questions/NN.md` + уведомление + завершить ход. Ответ
продолжает ту же сессию.

## Восстановление

- Сетевая ошибка — повторить фазу с той же точки входа.
- Повтор не чинит — стоп и вопрос.
- Сессия переживает сон машины: после пробуждения — «продолжи».
- Потеря состояния — читать `events.jsonl` и `board.json`, не выдумывать.
- Красный main — фиксить или revert; следующий спринт не начинать.

## Псевдокод цикла

```text
read AGENTS.md, board, state, openspec list
if no product goal: ask owner; stop
planning()
while cycle < cycles and phase == BUILDING:
    dispatch_wave()
    collect_reports()
    verify_all()
    review_all()
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
- Не мержит параллельно.
- Не начинает следующий спринт без команды.
- Не выдумывает продукт, стек и состав.
