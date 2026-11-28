# Copywriter Role Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Добавить в scrum-crew постоянную роль Copywriter с кодексом вкуса, инструментами, тренировкой и жёстким анти-слоп-гейтом.

**Architecture:** Карточка роли — в `references/roles.md`; тяжёлый материал — в новом `references/copywriting.md`; кросс-ссылки — в `SKILL.md`, `README.md`, `init.md`, `cycle.md`. Growth/Content остаётся за каналы и метрику, тексты переходят Copywriter.

**Tech Stack:** Markdown, git, субагентные проверки.

**Spec:** решение в сессии 2026-11-28 (вариант A); этот план фиксирует содержание.

## Global Constraints

- Язык — русский; тон — сдержанный, точный, без пафоса.
- Нейрослоп запрещён: штампы, ложные обещания, «не просто X, а Y», эмодзи, восклицательные знаки, канцелярит.
- Роль — шляпа, не отдельный агент, не второй бэклог, не репозиторий.
- Один факт — один файл; карточка ссылается на reference, не дублирует.
- Нет заявлений без доказательства; нет тёмных паттернов; нет PII в креативах.
- Новый файл должен устанавливаться существующими `install.sh` / `install.ps1` без правок.

## Review Focus

- Штампы и AI-slop в новых текстах: «в современном мире», «не просто», «откройте для себя», «погрузитесь», «идеальный», «уникальный», «премиальный» как заявление.
- Пересечение зон Copywriter и Growth/Content: кто владеет `docs/design/content.md`, кто — каналом и метрикой.
- Счётчик ролей и ссылки: 14 → 15, `SKILL.md`, `README.md`, структура.
- Доступность и понятность: микротекст UI, ошибки без обвинения, ссылки с глаголом.
- Доказательность: цифры, факты, источник; нет выдуманных отзывов и кейсов.

---

### Task 1: RED — baseline без кодекса

**Files:**
- Create: `docs/evidence/COPYWRITER-ROLE.md` (временный артефакт проверки; не входит в установку)

**Interfaces:**
- Produces: список реальных слоп-штампов, которые войдут в чёрный список.

- [x] **Step 1: Получить baseline**

Запустить субагента с брифом: hero + CTA + три микротекста для премиального бренда японского чая. Без кодекса.

- [x] **Step 2: Записать вывод**

Сохранить текст в `docs/evidence/COPYWRITER-ROLE.md`; отметить 5–10 повторов и штампов.

- [x] **Step 3: Проверить**

Run: `test -s docs/evidence/COPYWRITER-ROLE.md`
Expected: exit 0.

---

### Task 2: Написать `references/copywriting.md`

**Files:**
- Create: `.opencode/skills/scrum-crew/references/copywriting.md`

**Interfaces:**
- Produces: разделы `Вкус`, `Голос`, `Лексикон`, `Анти-слоп`, `Процесс`, `Инструменты`, `Тренировка`, `Чек-лист`, `Источники`.
- Consumes: baseline из Task 1.

- [x] **Step 1: Написать кодекс вкуса**

Пять принципов: точность, простота, сдержанность, конкретность, уважение. Шкала голоса: формальность 7/10, теплота 5/10, энергия 4/10, орнамент 2/10, конкретность 9/10, срочность 1/10.

- [x] **Step 2: Написать анти-слоп**

Чёрный список фраз, конструкций и приёмов; правила «до/после»; проверка на факт, пользу, ритм, читаемость.

- [x] **Step 3: Написать процесс и инструменты**

Brief → research → message architecture → 3 варианта → edit → review → test → learn. Инструменты: web research, voice-of-customer, Hemingway, Grammarly/LanguageTool, «Главред», «Типограф», «Орфограммка», SEO-сервисы, AI как спарринг.

- [x] **Step 4: Написать тренировку**

Swipe file, copywork, reverse-outline, 25 headlines, 12 restatements, cut 30–50%, read aloud, A/B prediction, postmortem.

- [x] **Step 5: Проверить**

Run: `wc -l .opencode/skills/scrum-crew/references/copywriting.md`
Expected: 260–360 строк.

Run: `grep -nE "в современном мире|не просто|откройте для себя|погрузитесь|уникальн|инновационн|премиальн" .opencode/skills/scrum-crew/references/copywriting.md`
Expected: совпадения только внутри примеров «до» и чёрного списка.

---

### Task 3: Добавить карточку Copywriter

**Files:**
- Modify: `.opencode/skills/scrum-crew/references/roles.md`

**Interfaces:**
- Consumes: `references/copywriting.md`.
- Produces: раздел `## Copywriter`; обновлённую карточку Growth/Content.

- [x] **Step 1: Вставить карточку после Designer**

Миссия, вкус и голос, владеет, вход, выход, решает, не решает, границы, DoD, handoff, эскалация, калибровка.

- [x] **Step 2: Развести зоны с Growth/Content**

Copywriter владеет `docs/design/content.md`, голосом, сообщениями и текстами. Growth — запуск, каналы, SEO, UTM, метрика; тексты берёт у Copywriter.

- [x] **Step 3: Обновить вступление on-demand**

Оставить три шляпы; добавить, что Copywriter — постоянная роль, а не on-demand.

- [x] **Step 4: Проверить**

Run: `grep -n "^## Copywriter\|^## Growth / Content" .opencode/skills/scrum-crew/references/roles.md`
Expected: обе строки, Copywriter выше Growth.

Run: `grep -c "^## " .opencode/skills/scrum-crew/references/roles.md`
Expected: 23 (15 постоянных + 4 on-demand + Reviewer + Worker).

---

### Task 4: Интегрировать роль в поток

**Files:**
- Modify: `.opencode/skills/scrum-crew/SKILL.md`
- Modify: `.opencode/skills/scrum-crew/references/init.md`
- Modify: `.opencode/skills/scrum-crew/references/cycle.md`
- Modify: `README.md`

**Interfaces:**
- Consumes: Task 3.
- Produces: упоминания роли в планировании, составе, структуре.

- [x] **Step 1: SKILL.md**

`14 карточек` → `15 карточек`; в planning добавить `Copywriter — голос и сообщения`; в файлы — `copywriting.md`; в on-demand — уточнить границу.

- [x] **Step 2: init.md**

В определении продукта добавить голос и обещание: Copywriter фиксирует tone of voice и словарь.

- [x] **Step 3: cycle.md**

В планировании добавить Copywriter для PBI, меняющих текст, лендинг, UI или письма.

- [x] **Step 4: README.md**

Добавить роль в список, таблицу, структуру; обновить on-demand-раздел; `14 ролей` → `15`.

- [x] **Step 5: Проверить**

Run: `grep -RIn "15 карточек\|15 ролей\|Copywriter" .opencode/skills/scrum-crew/SKILL.md README.md .opencode/skills/scrum-crew/references/init.md .opencode/skills/scrum-crew/references/cycle.md`
Expected: все четыре файла содержат упоминание.

---

### Task 5: Версия и changelog

**Files:**
- Modify: `.opencode/skills/scrum-crew/VERSION`
- Modify: `CHANGELOG.md`
- Modify: `README.md`

**Interfaces:**
- Consumes: Tasks 2–4.
- Produces: v0.6.0.

- [x] **Step 1: VERSION**

`0.5.1` → `0.6.0`.

- [x] **Step 2: CHANGELOG**

Добавить v0.6.0: роль Copywriter, `references/copywriting.md`, анти-слоп-гейт, граница с Growth/Content. Migration: не требуется.

- [x] **Step 3: README**

Статус `v0.5.1` → `v0.6.0`; строка обновления — v0.6.0.

- [x] **Step 4: Проверить**

Run: `cat .opencode/skills/scrum-crew/VERSION`
Expected: `0.6.0`.

---

### Task 6: GREEN — проверка с кодексом

**Files:**
- Create: `docs/evidence/COPYWRITER-ROLE.md`

**Interfaces:**
- Consumes: `references/copywriting.md`, карточка Copywriter.
- Produces: доказательство, что кодекс убирает слоп.

- [x] **Step 1: Дать тот же бриф субагенту с кодексом**

Субагент читает карточку и reference, пишет hero + CTA + три микротекста.

- [x] **Step 2: Сравнить с baseline**

Проверить: нет фраз из чёрного списка; есть конкретика; ошибка без обвинения; CTA с глаголом; нет восклицаний и эмодзи.

- [x] **Step 3: Записать результат**

`docs/evidence/COPYWRITER-ROLE.md`: вывод, что убрано, что осталось.

- [x] **Step 4: Проверить**

Run: `grep -nE "в современном мире|не просто|откройте для себя|погрузитесь|уникальн|инновационн|премиальн" docs/evidence/COPYWRITER-ROLE.md`
Expected: пусто.

---

### Task 7: Финальный анти-слоп-аудит

**Files:**
- Modify: все изменённые файлы (точечно).

**Interfaces:**
- Consumes: Tasks 2–6.
- Produces: чистый дифф.

- [x] **Step 1: Прогнать чёрный список по диффу**

Run: `git diff -- .opencode README.md CHANGELOG.md | grep -nE "в современном мире|не просто|откройте для себя|погрузитесь|уникальн|инновационн|премиальн|идеальн|эксклюзивн|роскошн|элитн"`
Expected: только примеры «до» и чёрный список.

- [x] **Step 2: Проверить пунктуацию и голос**

Нет `!`, эмодзи, CAPS, двойных пробелов, длинных тире в новых текстах (кроме цитат и кода).

- [x] **Step 3: Перечитать вслух**

Каждое новое предложение — одно дыхание. Если нет — сократить.

- [x] **Step 4: Проверить ссылки**

Run: `grep -RIn "copywriting.md" .opencode/skills/scrum-crew README.md`
Expected: файл существует и на него ссылаются.
