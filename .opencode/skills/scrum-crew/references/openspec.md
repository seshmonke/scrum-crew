# OpenSpec в цикле

## Роль

OpenSpec — слой поведения: **что система обязана делать**. Не заменяет
Scrum, ADR и дизайн-доки.

```
openspec/specs/<capability>/spec.md     текущая правда
openspec/changes/<id>/proposal.md       зачем и что меняется
openspec/changes/<id>/specs/…/spec.md   дельта ADDED/MODIFIED/REMOVED
openspec/changes/<id>/design.md         как
openspec/changes/<id>/tasks.md          чек-лист
openspec/changes/archive/               история
```

Команды:

```bash
openspec list
openspec view
openspec status --change <id>
openspec validate <id> --strict
openspec show <id> --diff
openspec verify-change <id>   # через skill
openspec archive <id> -y
openspec validate --all --strict
```

## Маппинг

| Scrum | OpenSpec |
|---|---|
| PBI | change `<номер>-<краткое>` |
| Sprint Goal | 1–3 change с одним исходом |
| Sprint Backlog | `tasks.md` + план спринта |
| DoR | proposal + Tier + specs + сценарии + `validate --strict` |
| DoD | `verify-change` + archive + `validate --all` |
| Increment | архивные changes в `specs/` |
| Review | diff требований + демо |
| Retro | аудит drift |

## Поток

1. **Explore** (опционально): варианты, риски, что неизвестно.
2. **Propose:** PO — proposal + Tier; Architect — design + contract;
   QA — ATDD happy/error; White Hacker — threat model/abuse; Designer —
   UX-состояния.
3. **Review:** читать proposal → specs → tasks; `validate --strict`;
   spec freeze.
4. **Apply:** один change на агента/worktree; только `tasks.md`;
   RED-тест и ATDD-сценарий на каждый AC; `specs/` не править.
5. **Verify:** `verify-change`; каждый сценарий имеет тест или ручное
   доказательство.
6. **Archive:** после merge, отдельным PR в конце цикла;
   `archive -y` → `validate --all --strict`.
7. **Retro:** drift-аудит.

## Definition of Ready

- [ ] proposal: why, what, non-goals, метрика, Tier.
- [ ] Дельта спеков: SHALL + WHEN/THEN.
- [ ] Happy path + ошибка/край.
- [ ] Для T1/T2 ATDD happy/error, RED-тест на каждый AC и e2e главного
      сценария.
- [ ] Для T2 `design.md`: threat model, contract-план, SLO/логи;
      property/mutation — по волне.
- [ ] T0: `No spec change`; change/archive не требуются.
- [ ] `design.md`, если контракт/схема/authz/деньги/PII.
- [ ] `tasks.md` — чекбоксы.
- [ ] `openspec validate <id> --strict` зелёный.
- [ ] PO/Architect/QA подтвердили.

В `tasks.md` на каждый AC:

- [ ] RED: тест падает по ожидаемой причине.
- [ ] GREEN: минимальный код.
- [ ] ATDD: Given/When/Then, happy/error.

## Definition of Done

- [ ] Все задачи `[x]`.
- [ ] TDD/ATDD evidence и e2e главного сценария для T1/T2; T0 — N/A.
- [ ] T2-гейты текущей волны закрыты.
- [ ] T0: `No spec change`; archive не требуется.
- [ ] `verify-change` пройден.
- [ ] `openspec validate --all --strict` зелёный.
- [ ] Change заархивирован; `specs/` обновлён.
- [ ] Нет поведения в коде без спеки (или явное исключение).

## 12 параллельных changes

- Одна capability — один активный change на волну.
- Два change на capability — последовательно или дробить capability.
- Агенты пишут только в `changes/<id>/specs/`.
- `openspec/specs/` меняет только archive.
- Архивация последовательная, по одному, с `validate --all` после каждого.
- Перед мержем: `openspec show <id> --json --deltas-only` и
  `openspec validate --all --json`.
- `INFO` про archive-конфликт не валит сборку, но требует решения
  Architect.
- Staggered start: контракты → фундамент → зависимые срезы → полировка.

## Порог spec-worthy

| Работа | Change |
|---|---|
| Новая возможность | да |
| Изменение API/UI/данных | да |
| Authz/деньги/PII | да, обязательно |
| Багфикс заданного поведения | нет, regression-тест |
| Рефакторинг без поведения | нет, ссылка на Raptor |
| Инфра/CI/доки | нет, `--skip-specs` |
| Копирайт/стили | нет |

Если change не нужен: `No spec change: <причина>. Поведение не меняется.`

## Гейты

| Когда | Команда |
|---|---|
| Ready | `openspec validate <id> --strict` |
| Перед apply | `openspec status --change <id>` |
| Перед merge | `openspec validate --all --strict` |
| Ревью | `openspec show <id> --diff` |
| После merge | `openspec archive <id> -y` |
| После archive | `openspec validate --all --strict` |
| Дейли | `openspec list --json` |
| Ретро | `openspec list --archived` |

`verify` проекта:

```json
{
  "scripts": {
    "verify": "pnpm typecheck && pnpm lint && pnpm test && pnpm build && openspec validate --all --strict"
  }
}
```

Нет `openspec/` — шаг пропускается с явной пометкой, не имитируется.

## Антипаттерны

- Спека после кода, чтобы оправдать реализацию.
- Tier не записан или T2 без threat model/contract/property.
- `tasks.md` без RED-теста на AC.
- T0 через TDD/e2e/change/archive.
- Archive пропущен → спека врёт.
- `specs/` правится в ветке фичи.
- Один change на пять capability.
- Сценарий без наблюдаемого THEN.
- `validate` зелёный, поведение не проверено.
- Два change на capability в одной волне.
- Параллельная архивация.
- OpenSpec вместо ADR или вместо тестов.
- Change на опечатки.
