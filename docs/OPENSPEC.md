# OpenSpec в методологии

Дополнение к `DESIGN.md`. Отвечает на требование: **встроить OpenSpec в
Scrum-цикл, 12 параллельных агентов и документацию по стандарту
солоспринт-конвеера.**

Версия на момент проектирования: OpenSpec 2.2.x, CLI
`@fission-ai/openspec`, MIT.

---

## 1. Зачем OpenSpec

OpenSpec — слой **поведенческих требований** между бэклогом и кодом.
Один change = один PBI: `proposal.md` (зачем), `specs/` (что меняется в
поведении), `design.md` (как), `tasks.md` (чек-лист).

Что он даёт методологии:

- **Ревью намерения до кода.** Ревьюер читает diff требований, а не
  реконструирует intent из 800 строк диффа.
- **Сценарии вместо размытых AC.** `WHEN/THEN` проверяемы, их можно
  превратить в тесты.
- **Постоянный контекст.** Спеки лежат в репозитории и переживают сессию
  агента.
- **Brownfield-first.** Работает с существующим кодом, не требует
  «переписать всё начисто».
- **Дельта вместо копии.** Изменение описывается как ADDED / MODIFIED /
  REMOVED / RENAMED, а не как новая версия всей спеки.

OpenSpec **не заменяет** Scrum, ADR и дизайн-документацию. Он занимает
ровно одну нишу: «что система обязана делать».

---

## 2. Место в системе артефактов

Правило: **поведение — в OpenSpec, причины — в docs, реализация — в коде.**

```
openspec/
  specs/                      # текущая правда о поведении
    auth-session/spec.md
    checkout-cart/spec.md
    checkout-payment/spec.md
  changes/                    # в работе
    42-guest-checkout/
      .openspec.yaml
      proposal.md             # почему и что меняется
      specs/
        checkout-cart/spec.md # дельта: ADDED/MODIFIED/REMOVED
      design.md               # как (если нужно)
      tasks.md                # чек-лист
  changes/archive/            # история изменений поведения
docs/
  concept/                    # продукт: зачем, персоны, journey, правила
  stack/                      # архитектура, контракты, ADR, runbooks
  design/                     # UX, дизайн-система, a11y
  quality/                    # тест-стратегия, threat model, DoD
  tasks/                      # доска, спринты, milestones
```

Разграничение:

| Вопрос | Где живёт | Пример |
|---|---|---|
| Зачем продукт и кому | `docs/concept/` | «Гость не должен регистрироваться до оплаты» |
| Что система обязана делать | `openspec/specs/` | «WHEN гость оформляет заказ, THEN создаётся гостевой заказ» |
| Как устроено | `docs/stack/` + ADR | «Заказы хранятся в `orders`, ключ — `idempotency_key`» |
| Как выглядит | `docs/design/` | «Шаг 2 показывает сводку и итог» |
| Как проверяем | `docs/quality/` + тесты | «e2e: гость → оплата → подтверждение» |
| Что делаем сейчас | `docs/tasks/` + change | «Спринт 7, change `42-guest-checkout`» |

Один факт — один файл. Если поведение описано в OpenSpec, в `docs/concept`
остаётся только причина и ссылка. Дублирование запрещено.

### Пример связей

```
docs/concept/checkout.md
  → зачем гостевой checkout, метрика, персоны
  → ссылка: openspec/specs/checkout-cart/spec.md

openspec/changes/42-guest-checkout/proposal.md
  → why: конверсия, исследование
  → what: ADDED guest checkout
  → link: docs/concept/checkout.md

openspec/changes/42-guest-checkout/design.md
  → как: idempotency, схема, откат
  → link: docs/stack/adr/0007-guest-orders.md

openspec/changes/42-guest-checkout/tasks.md
  → чек-лист реализации
```

---

## 3. Установка (Windows / Ubuntu + OpenCode)

### 3.1. CLI

Вариант A, standalone (рекомендуется, не зависит от Node):

Windows:

```powershell
irm https://openspec.dev/cli/install.ps1 | iex
openspec --version
```

Ubuntu / macOS:

```bash
curl -fsSL https://openspec.dev/cli/install.sh | sh
openspec --version
```

Вариант B, npm (нужен Node.js ≥ 22.20.0):

```bash
node --version
npm install -g @fission-ai/openspec@latest
openspec --version
```

Если установщик печатает строку `export PATH=...`, выполнить её и открыть
новый терминал.

### 3.2. Инициализация проекта

```bash
cd <корень-репозитория>
openspec init --tools opencode --scope project
```

Что появится:

```
openspec/
  config.yaml
  specs/
  changes/
.agents/
  skills/
    openspec-explore/SKILL.md
    openspec-propose/SKILL.md
    openspec-apply-change/SKILL.md
    openspec-verify-change/SKILL.md
    openspec-archive-change/SKILL.md
    ...
```

OpenCode читает `.agents/skills/`, поэтому отдельная папка `.opencode/`
для OpenSpec не нужна. На Windows проектные ссылки могут быть копиями —
это нормально.

### 3.3. Профиль и вызов

```powershell
openspec config profile core
openspec list
openspec view
```

В чате OpenCode (slash-форма зависит от версии; если не сработала —
попросить словами или загрузить skill через `@openspec-...`):

```
/openspec-explore
/openspec-propose <что-меняем>
/openspec-apply-change <change-id>
/openspec-verify-change <change-id>
/openspec-archive-change <change-id>
```

Старые имена `/opsx:*` — это 1.x; в 2.x используем `/openspec-*`.
Скиллы лежат в `.agents/skills/`; OpenCode читает этот каталог.

### 3.4. Версия и обновление

- Версия фиксируется в `docs/stack/tooling.md`.
- `openspec update` — отдельным PR, не внутри фича-ветки.
- Обновление скиллов не должно ломать текущий спринт: сначала `--dry-run`.
- CLI и скиллы версионируются вместе; не смешивать 1.x и 2.x.

### 3.5. Ограничения

- `openspec init` пишет файлы; в существующем репозитории запускать только
  после проверки, что он не перезапишет пользовательские настройки.
- OpenSpec-скиллы токенозатратны. Поэтому — порог «spec-worthy» (раздел 9)
  и профиль `core`, а не полный набор.
- `openspec validate` проверяет структуру, а не поведение. Поведение
  проверяют тесты и `verify-change`.

---

## 4. Маппинг на Scrum

| Scrum | OpenSpec |
|---|---|
| Product Goal | набор capability-спеков + `docs/concept/` |
| Product Backlog item | change `openspec/changes/<sprint>-<id>/` |
| Sprint Goal | 1–3 change, дающих один наблюдаемый исход |
| Sprint Backlog | `tasks.md` каждого change + план спринта |
| Definition of Ready | proposal + delta specs + сценарии + `validate --strict` |
| Definition of Done | все задачи `[x]`, verify, тесты, archive, main зелёный |
| Increment | архивные changes, влитые в `openspec/specs/` |
| Sprint Review | diff спеков + демо на preview |
| Retro | аудит drift: код без спеки, спека без кода |

### 4.1. Definition of Ready (дополнение)

PBI готов, если:

- [ ] `proposal.md` отвечает: зачем, что меняется, что не меняется.
- [ ] Дельта спеков описывает поведение через `SHALL` + `WHEN/THEN`.
- [ ] Минимум один сценарий на happy path и один на ошибку/край.
- [ ] `design.md` есть, если меняются контракт, схема, authz или деньги.
- [ ] `tasks.md` — чекбоксы, а не проза.
- [ ] `openspec validate <change> --strict` зелёный.
- [ ] PO подтвердил ценность, Architect — границы, QA — проверяемость.

### 4.2. Definition of Done (дополнение)

- [ ] Все задачи `tasks.md` отмечены.
- [ ] `openspec verify-change` пройден: реализация соответствует сценариям.
- [ ] `openspec validate --all --strict` зелёный.
- [ ] Change заархивирован, `openspec/specs/` обновлён.
- [ ] Нет поведения в коде, которого нет в спеке (или явно записано
      исключение).

---

## 5. Поток одного change

```
explore → propose → review → apply → verify → archive → retro
   ↑                                                      │
   └──────────────── следующая итерация ─────────────────┘
```

### 5.1. Explore (опционально)

PO, Architect, User Proxy, White Hacker. Без кода. Выход — 5–10 строк:
варианты, риски, что неизвестно. Если идея уже ясна, шаг пропускается.

### 5.2. Propose

- PO: `proposal.md` — why, what changes, non-goals, метрика.
- Architect: границы capability, `design.md`, ссылка на ADR.
- QA: сценарии, включая negative/edge.
- White Hacker: abuse-case сценарии (authz, enumeration, rate limit).
- Designer: UX-сценарии, состояния.
- SM: проверяет, что change привязан к PBI и спринту.

Имя change: `<номер-задачи>-<краткое-имя>`, например
`42-guest-checkout`. Один change = один PBI.

### 5.3. Review (до кода)

- Ревьюер читает `proposal.md` → `specs/` → `tasks.md`.
- Проверяет: сценарии наблюдаемы, нет противоречий с `openspec/specs/`,
  non-goals явные, задачи покрывают спеки и ничего лишнего.
- `openspec validate <change> --strict`.
- После ревью — **spec freeze** до конца apply. Изменение спеки на ходу —
  через `#spec` и повторный review.

### 5.4. Apply

- Один change на агента и worktree.
- Агент работает по `tasks.md`, отмечает `[x]` по мере выполнения.
- `openspec/specs/` **не редактируется** вручную во время apply. Меняется
  только дельта в `changes/<id>/specs/`.
- Если реализация выявила дыру в спеке — стоп, `#spec`, решение, обновление
  дельты, повторный review. Не «подгоняем спеку под код» молча.

### 5.5. Verify

- QA/ревьюер запускает `/openspec-verify-change`.
- Проверка: каждый сценарий имеет тест или явное ручное доказательство.
- `openspec validate --all --strict`.
- Расхождение «спека обещает — код не делает» — блокер.

### 5.6. Archive

**Рекомендуемый порядок:** merge кода → архив в отдельном маленьком PR в
конце цикла.

Почему не в том же PR: нельзя архивировать отклонённую работу. Почему не
откладывать: дольше цикла — начинается drift.

```powershell
openspec archive 42-guest-checkout -y
openspec validate --all --strict
```

Архив:
- переносит change в `changes/archive/<дата>-<id>/`;
- вливает дельту в `openspec/specs/<capability>/spec.md`;
- фиксирует историю поведения (аналог `milestones.md`).

Для инфраструктуры/тулинга/доков — `--skip-specs`, с одной строкой
причины в PR.

### 5.7. Retro

- Аудит drift: есть ли в коде поведение без спеки.
- Если да — задача в бэклог, не «допишем потом».
- Метрика: archive lag (время от merge до archive).

---

## 6. 12 параллельных changes

OpenSpec хорошо ложится на параллельность: у каждого change своя папка.
Но есть общие точки — `openspec/specs/` и capability.

### 6.1. Capability ownership

- Одна capability — один активный change на волну.
- Два change на одну capability — либо последовательно, либо
  разделить capability.
- Владелец capability (Architect) решает, можно ли дробить.

### 6.2. Spec merge queue

- Агенты пишут только в `changes/<id>/specs/`.
- `openspec/specs/` меняет только archive.
- Архивация — последовательно, по одному change, с `validate --all` после
  каждого.
- Параллельная архивация запрещена: это тот же merge hell, но в спеках.

### 6.3. Contract sentinel

Перед мержем:

```powershell
openspec show <change> --json --deltas-only
openspec validate --all --json
```

Проверяем:
- ADDED с тем же именем requirement, что уже есть;
- MODIFIED, у которого нет цели;
- REMOVED, который ломает соседний change;
- RENAMED, который не видят открытые PR.

`INFO` про archive-конфликт не валит сборку, но требует решения
Architect.

### 6.4. Batch preflight

Перед merge train:

```powershell
openspec validate --all --strict --json
```

Красный — не мержим пакет. Зелёный — можно, но `INFO` всё равно читаем.

### 6.5. Staggered start

12 слотов открываются волнами:
1. Контракты и capability-границы.
2. Фундамент (схема, auth, API skeleton).
3. Экраны и ручки, зависимые от контрактов.
4. Полировка, a11y, perf, docs.

Это не «12 одновременно с одного коммита», а 12 параллельных слотов без
старта от устаревшей основы.

---

## 7. Роли и OpenSpec

| Роль | Артефакт / действие | Право |
|---|---|---|
| Product Owner | `proposal.md`, порядок, приёмка | решает ценность и скоуп |
| Architect | `design.md`, границы capability | решает контракт и дробирование |
| QA | сценарии, `verify-change` | решает достаточность доказательств |
| Frontend / Backend / Fullstack | `tasks.md`, apply | пишет код по спеке |
| Tester | edge-case сценарии, ручная проверка | находит расхождения |
| DevSecOps | NFR-сценарии (authz, лимиты, секреты) | вето на security-риск |
| White Hacker | abuse-case сценарии | вето на релиз при active exploit |
| Designer | UX-сценарии, состояния | вето на a11y/разрушение сценария |
| User Proxy | гипотезы сценариев | без права вето |
| SM | гейты, архив, доска | останавливает процесс |
| Delivery | release notes из архива | внешние зависимости |

Правило: **спеку пишет не тот, кто её реализует.** Иначе агент
рационализирует код задним числом. Минимум: PO/Architect/QA пишут,
Developer применяет.

---

## 8. Гейты и команды

| Когда | Команда | Что значит |
|---|---|---|
| Ready | `openspec validate <change> --strict` | спека структурно готова |
| Перед apply | `openspec status --change <id>` | все артефакты на месте |
| Перед merge | `openspec validate --all --strict` | нет конфликтов |
| Ревью | `openspec show <change> --diff` | diff требований в PR |
| После merge | `openspec archive <id> -y` | спека стала правдой |
| После archive | `openspec validate --all --strict` | main не сломан |
| Ежедневно | `openspec list --json` | синк доски |
| Ретро | `openspec list --archived` | что вошло в инкремент |

`verify` проекта дополняется:

```json
{
  "scripts": {
    "verify": "pnpm typecheck && pnpm lint && pnpm test && pnpm build && openspec validate --all --strict"
  }
}
```

Если `openspec/` нет — шаг пропускается с явной пометкой в файле спринта,
а не имитируется.

---

## 9. Порог «spec-worthy»

OpenSpec на каждый чих — это process theater. Правило:

| Тип работы | Нужен change? |
|---|---|
| Новая наблюдаемая возможность | да |
| Изменение поведения API/UI/данных | да |
| Новый authz/деньги/PII-путь | да, обязательно |
| Багфикс, возвращающий заданное поведение | нет, но нужен regression-тест |
| Рефакторинг без изменения поведения | нет, ссылка на Raptor review |
| Инфраструктура, CI, доки | нет, `--skip-specs` при архиве |
| Копирайт, стили, косметика | нет |

Если change не нужен, в PR одна строка:
`No spec change: <причина>. Поведение не меняется.`

Это защищает от двух крайностей: «спека на всё» и «спека ни на что».

---

## 10. Антипаттерны

- Спека написана после кода, чтобы оправдать реализацию.
- Archive пропущен → спека врёт.
- `openspec/specs/` правится вручную в ветке фичи.
- Один change на пять capability.
- Сценарий без наблюдаемого `THEN`.
- `validate` зелёный, но поведение не проверено тестом.
- Два change на одну capability в одной волне.
- Параллельная архивация.
- OpenSpec вместо ADR: «как» уехало в спеку.
- OpenSpec вместо тестов: «сценарий есть, значит работает».
- 100% задач через change, включая опечатки.

---

## 11. Метрики

- Доля PBI, у которых есть change (цель: 100% для behavior-changing).
- Доля критических путей, покрытых сценариями.
- Drift: поведение в коде без спеки (аудит на ретро).
- Archive lag: Merge → Archive (цель: ≤ 1 цикл).
- `validate` failures на цикл.
- Rework из-за неоднозначной спеки.
- Время ревью спеки vs время ревью кода.
- Токены на OpenSpec / общие токены (цель ≤ 20%).

---

## 12. Источники

- OpenSpec: https://openspec.dev/
- Документация: https://openspec.dev/docs
- Quickstart: https://openspec.dev/docs/quickstart
- CLI: https://openspec.dev/docs/cli
- Установка: https://openspec.dev/docs/installation
- Поддерживаемые инструменты: https://openspec.dev/docs/supported-tools
- Репозиторий: https://github.com/Fission-AI/OpenSpec
- Схема spec-driven: https://openspec.dev/docs/schemas/spec-driven
