# Copywriter Motif Patch Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Убрать повторяющийся мотив «пауза» из будущих текстов: разделить голос и мотив, добавить журнал мотивов и корпусную проверку.

**Architecture:** Правила — в `references/copywriting.md`; журнал — `docs/design/motifs.md`; проверка — `scripts/motif-check.sh`; интеграция — карточка Copywriter, review, README, SCHEME, DECISIONS.

**Tech Stack:** Markdown, bash, git.

**Spec:** разбор проблемы в сессии 2026-11-28 (исследование mode collapse, self-authored references, instruction drift).

## Global Constraints

- Голос — инвариант; мотив — переменная. Один центральный образ на текст.
- Не повторять образ и слова-подписи в следующих трёх текстах.
- Не называть приём: пауза, тишина, воздух, ритм — строить, не объяснять.
- `motif-check.sh` — эвристика, не суд; ложное срабатывание разбирается в evidence.
- Патч не меняет роли, цикл и гейты; только копирайтинг и проверку.
- Версия — 0.6.1; migration не требуется.

## Review Focus

- Не превратить «мотив» в новый штамп и не заставить тексты звучать одинаково.
- Не сломать `slop-check.sh` и установку скилла.
- Не дублировать правила между `roles.md` и `copywriting.md`.
- Проверить, что журнал мотивов не становится вторым бэклогом.
- Проверить релиз: VERSION, changelog, tag, GitHub Release.

---

### Task 1: RED — зафиксировать повтор

**Files:**
- Modify: `docs/evidence/COPYWRITER-ROLE.md`

- [x] **Step 1: Собрать корпус**

Записать четыре текста в `/tmp/opencode/motif-corpus/`: расстояние, бессознательное, The Finals, Bleach.

- [x] **Step 2: Показать повтор**

Run: `grep -RIn "пауза\|паузы\|паузе" /tmp/opencode/motif-corpus`
Expected: совпадения в трёх текстах.

- [x] **Step 3: Записать вывод**

В `docs/evidence/COPYWRITER-ROLE.md` добавить раздел `MOTIF`: где повторяется «пауза», почему это подпись, а не голос.

---

### Task 2: `scripts/motif-check.sh`

**Files:**
- Create: `.opencode/skills/scrum-crew/scripts/motif-check.sh`

**Interfaces:**
- Consumes: новый текст + корпус (файлы или папки).
- Produces: `MOTIF:` и `REPEAT:` предупреждения; exit 1 при повторе.

- [x] **Step 1: Написать скрипт**

Проверяет слова-подписи из watchlist в новом тексте и считает, в скольких файлах корпуса они уже встречались. Порог — 2 предыдущих текста. Внутри текста — повтор content-слова 5+ раз.

- [x] **Step 2: Проверить синтаксис**

Run: `bash -n .opencode/skills/scrum-crew/scripts/motif-check.sh`
Expected: exit 0.

- [x] **Step 3: Проверить на корпусе**

Run: `bash .opencode/skills/scrum-crew/scripts/motif-check.sh /tmp/opencode/motif-corpus/bleach.md /tmp/opencode/motif-corpus`
Expected: `MOTIF: "пауза"` и exit 1.

- [x] **Step 4: Проверить на чистом тексте**

Создать текст без слов watchlist. Run: `motif-check.sh clean.md /tmp/opencode/motif-corpus`
Expected: exit 0.

---

### Task 3: Правила и журнал

**Files:**
- Modify: `.opencode/skills/scrum-crew/references/copywriting.md`
- Modify: `.opencode/skills/scrum-crew/references/roles.md`
- Modify: `.opencode/skills/scrum-crew/references/init.md`
- Modify: `.opencode/skills/scrum-crew/assets/review.md`
- Create: `template/docs/design/motifs.md`

- [x] **Step 1: `copywriting.md`**

Заменить формулу на «Одна мысль. Один образ. Ни слова о приёме». Добавить раздел «Мотив и подпись», правила журнала, `motif-check`, чек-лист, тренировку, источники.

- [x] **Step 2: `roles.md`**

В карточке Copywriter добавить `docs/design/motifs.md`, проверку мотива в DoD и аудит слов-подписей в калибровке.

- [x] **Step 3: `init.md` и `review.md`**

В Init добавить журнал мотивов в выход Copywriter. В review — пункт про мотив и `motif-check`.

- [x] **Step 4: Шаблон журнала**

`template/docs/design/motifs.md`: таблица «дата, текст, образ, слова-подписи, не повторять до» и три правила.

- [x] **Step 5: Проверить**

Run: `grep -RIn "motifs.md\|motif-check\|Мотив и подпись" .opencode template`
Expected: все файлы содержат упоминание.

---

### Task 4: Документация и версия

**Files:**
- Modify: `README.md`, `CHANGELOG.md`, `docs/SCHEME.md`, `docs/DECISIONS.md`
- Modify: `.opencode/skills/scrum-crew/VERSION`, `.opencode/skills/scrum-crew/SKILL.md`

- [x] **Step 1: README**

Статус `v0.6.1`; структура — `motif-check.sh`; bullet Copywriter — журнал мотивов.

- [x] **Step 2: CHANGELOG**

v0.6.1: мотив vs голос, журнал, скрипт, правило «не называй приём». Migration не требуется.

- [x] **Step 3: SCHEME и DECISIONS**

В таблицу артефактов — `docs/design/motifs.md`. D20: голос — инвариант, мотив — переменная.

- [x] **Step 4: VERSION и SKILL**

`0.6.1`; в `SKILL.md` — `motif-check.sh` в scripts.

- [x] **Step 5: Проверить**

Run: `cat .opencode/skills/scrum-crew/VERSION`
Expected: `0.6.1`.

---

### Task 5: GREEN — новый текст без «паузы»

**Files:**
- Modify: `docs/evidence/COPYWRITER-ROLE.md`

- [x] **Step 1: Написать текст на новую тему**

Тема — «След». Центральный образ — след, а не пауза. Без слов watchlist.

- [x] **Step 2: Проверить**

Run: `bash .opencode/skills/scrum-crew/scripts/motif-check.sh <new-text> /tmp/opencode/motif-corpus`
Expected: exit 0.

- [x] **Step 3: Записать**

Добавить текст и результат в evidence.

---

### Task 6: Релиз v0.6.1

- [ ] **Step 1: Проверить всё**

`git diff --check`, `bash -n` обоих скриптов, `slop-check` на GREEN, `motif-check` на GREEN, установка в `/tmp/opencode/install-test`.

- [ ] **Step 2: Коммит**

`fix(skill): separate voice from motifs and add motif check`

- [ ] **Step 3: Merge в main, tag, push**

Fast-forward main; annotated tag `v0.6.1`; push main + tag.

- [ ] **Step 4: GitHub Release**

Notes из CHANGELOG v0.6.1; `gh release create v0.6.1`.
