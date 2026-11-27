# Skill Upgrade Guide Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Добавить в скилл `scrum-crew` инструкцию по обновлению скилла в проектах, где уже установлена предыдущая версия.

**Architecture:** Новый `references/upgrade.md` описывает процедуру от проверки версии до rollback; `SKILL.md` получает режим `Upgrade`; `VERSION` в скилле хранит установленную версию; README, `template/AGENTS.md` и D17 связывают процедуру с проектом. Код и данные проекта не мигрируются.

**Tech Stack:** Markdown, Bash, PowerShell, Git, GitHub CLI, OpenCode skills.

**Spec:** `docs/superpowers/specs/2026-11-27-skill-upgrade-guide-design.md`

## Global Constraints

- Обновление — только между спринтами и по команде владельца.
- Target — только released tag `vX.Y.Z`; не `main` и не `-dev`.
- Установщик запускается **без** `--with-scaffold`.
- `.scrum/`, `openspec/`, `docs/` и код проекта не трогаются.
- Старые skill-id и папки удаляются; `opencode.json` обновляется.
- `VERSION` на ветке — `0.4.0-dev`; bump до `0.4.0` — в release-шаге.
- Ветка `task/skill-upgrade-guide` от `task/quality-skill-waves`; PR #5 → #4.
- Поведение и содержание методологии не меняется.

## Review Focus

- Инструкция разрешает `main`/`-dev` → нестабильный скилл; ловится проверкой target-tag в `upgrade.md`.
- Установщик перезаписывает кастомизированных агентов → потеря правок; ловится разделом «кастомизации».
- Старая папка `sprint-crew` остаётся → два skill-id; ловится шагом удаления и проверкой одного ID.
- `VERSION` отсутствует в pre-v0.4.0 установке → процедура не знает версию; ловится разделом «pre-versioned install».
- Обновление трогает `.scrum/`/`openspec/`/`docs/` → потеря состояния; ловится проверкой `git diff` и sentinel-файлами в smoke-тесте.
- Нет чистого git/rollback → обновление не откатить; ловится гейтом «чистое дерево + отдельный PR».

---

### Task 1: Зафиксировать дизайн и план

**Files:**
- Create: `docs/superpowers/specs/2026-11-27-skill-upgrade-guide-design.md`
- Create: `docs/superpowers/plans/2026-11-27-skill-upgrade-guide.md`

**Interfaces:**
- Consumes: одобренный дизайн.
- Produces: spec и план для PR #5.

- [ ] **Step 1: Проверить ветку**

Run: `git status --short --branch`
Expected: `## task/skill-upgrade-guide`; untracked только `PROGRESS.md`,
`docs/superpowers/specs/...` и `docs/superpowers/plans/...`.

- [ ] **Step 2: Добавить документы**

```bash
git add docs/superpowers/specs/2026-11-27-skill-upgrade-guide-design.md \
        docs/superpowers/plans/2026-11-27-skill-upgrade-guide.md
git commit -m "docs: add skill upgrade guide design and plan"
```

- [ ] **Step 3: Проверить**

Run: `git show --stat --oneline HEAD`
Expected: два файла в `docs/superpowers/`.

---

### Task 2: Добавить VERSION и `references/upgrade.md`

**Files:**
- Create: `.opencode/skills/scrum-crew/VERSION`
- Create: `.opencode/skills/scrum-crew/references/upgrade.md`

**Interfaces:**
- Consumes: skill-id `scrum-crew`, установщики из текущей ветки.
- Produces: установленная версия `0.4.0-dev`; каноническая процедура
  обновления.

- [ ] **Step 1: Создать `VERSION`**

Содержимое файла — одна строка:

```text
0.4.0-dev
```

- [ ] **Step 2: Создать `references/upgrade.md`**

Документ на русском, разделы:

1. **Когда можно и когда нельзя.** Только между спринтами, по команде
   владельца; чистое git-дерево; released tag; при активном спринте,
   грязном дереве или отсутствии сети — стоп.
2. **Версии.** Команды:
   ```bash
   installed="$(cat .opencode/skills/scrum-crew/VERSION 2>/dev/null || echo unknown)"
   latest="$(git ls-remote --tags --refs --sort=-v:refname \
     https://github.com/seshmonke/scrum-crew.git 'v*' \
     | awk -F/ 'NR==1{print $NF}')"
   ```
   Если `VERSION` нет — pre-versioned install, читать changelog целиком.
   Если `VERSION` содержит `-dev` — это dev-сборка; target только
   released tag, не `main`; если тег не новее — обновление не требуется.
3. **Changelog и migration notes.** `git clone --depth 1 --branch "$target"`
   во временный каталог; читать `CHANGELOG.md` от installed до target;
   breaking/migration без заметок — стоп и вопрос владельцу.
4. **Подготовка.** Отдельная ветка `chore/upgrade-scrum-crew-vX.Y.Z`;
   зафиксировать/сохранить локальные кастомизации скилла и агентов.
5. **Установка.** `install.sh` / `install.ps1` **без**
   `--with-scaffold`; установщик копирует `.opencode/skills/scrum-crew/`
   и `.opencode/agents/scrum-*.md`, предупреждает о старых папках.
6. **Миграция.** Удалить старые папки (`sprint-crew`), обновить
   `opencode.json`, `AGENTS.md`, ссылки на skill-id; перенести
   кастомизации поверх установленных файлов.
7. **Проверка.** `VERSION` = target без `v`; ровно один `scrum-crew`;
   link-check `references/`/`assets/`; `openspec validate --all --strict`
   (если есть); `verify`; `git diff` не трогает `.scrum/`, `openspec/`,
   `docs/` и код.
8. **Коммит/PR.** `chore: upgrade scrum-crew to vX.Y.Z`; в теле —
   before/after, breaking changes, миграции, проверки.
9. **Rollback.** `git revert` upgrade-коммита или переустановка старого
   тега; состояние проекта не затронуто.
10. **Первый переход `sprint-crew` → `scrum-crew`.** Сначала README/D16:
    установить `scrum-crew`, удалить старую папку, обновить
    `opencode.json`; затем эта процедура для следующих версий.
11. **Красные флаги.** `main`/`-dev`, `--with-scaffold`, обновление в
    спринте, удаление `.scrum/`/`openspec/`/`docs/`, игнор warning о
    старой папке, потеря кастомизаций, merge с красным `verify`.

- [ ] **Step 3: Проверить**

```bash
test "$(cat .opencode/skills/scrum-crew/VERSION)" = "0.4.0-dev"
test -f .opencode/skills/scrum-crew/references/upgrade.md
grep -q "install.sh" .opencode/skills/scrum-crew/references/upgrade.md
grep -q "with-scaffold" .opencode/skills/scrum-crew/references/upgrade.md
grep -q "VERSION" .opencode/skills/scrum-crew/references/upgrade.md
```

- [ ] **Step 4: Закоммитить**

```bash
git add .opencode/skills/scrum-crew/VERSION .opencode/skills/scrum-crew/references/upgrade.md
git commit -m "docs(skill): add upgrade guide and version marker"
```

---

### Task 3: Подключить режим Upgrade в `SKILL.md`

**Files:**
- Modify: `.opencode/skills/scrum-crew/SKILL.md`

**Interfaces:**
- Consumes: `VERSION` и `references/upgrade.md` из Task 2.
- Produces: режим `Upgrade`, раздел `0.5`, пункт чек-листа, `upgrade` в
  списке reference-файлов.

- [ ] **Step 1: Добавить строку в таблицу режимов**

После строки `Sprint`:

```markdown
| Upgrade | «обнови скилл» | версия → changelog → установка → проверка |
```

- [ ] **Step 2: Добавить раздел `0.5` после Init**

Перед `## 1. Прочитать до спринта`:

```markdown
## 0.5. Обновление скилла

Не спринт. Триггеры: «обнови скилл», «обнови scrum-crew», «перейди на
новую версию». Только по команде владельца и между спринтами.

1. Установленная версия — `.opencode/skills/scrum-crew/VERSION`.
2. Прочитать `references/upgrade.md`.
3. Гейт: рабочее дерево чистое, спринт закрыт, target — released tag,
   владелец подтвердил.
4. Обновление — отдельный PR; `.scrum/`, `openspec/`, `docs/` и код не
   трогать.
```

- [ ] **Step 3: Добавить пункт в чек-лист**

В конец `## 12. Чек-лист`:

```markdown
- [ ] Обновление скилла — отдельным PR между спринтами; `VERSION`
      совпадает с target.
```

- [ ] **Step 4: Добавить `upgrade` в список reference-файлов**

В `## 13. Файлы`:

```text
`references/`: init, upgrade, scrum, roles, cycle, orchestrator,
communication, openspec, git-quality, failure-modes, audit.
`VERSION`: установленная версия скилла.
```

- [ ] **Step 5: Проверить**

```bash
grep -q "| Upgrade |" .opencode/skills/scrum-crew/SKILL.md
grep -q "## 0.5. Обновление скилла" .opencode/skills/scrum-crew/SKILL.md
grep -q "VERSION" .opencode/skills/scrum-crew/SKILL.md
grep -q "upgrade" .opencode/skills/scrum-crew/SKILL.md
```

- [ ] **Step 6: Закоммитить**

```bash
git add .opencode/skills/scrum-crew/SKILL.md
git commit -m "docs(skill): add Upgrade mode"
```

---

### Task 4: README, шаблон и D17

**Files:**
- Modify: `README.md`
- Modify: `template/AGENTS.md`
- Modify: `docs/DECISIONS.md`

**Interfaces:**
- Consumes: процедура и `VERSION` из Task 2–3.
- Produces: входная точка в README, правило в шаблоне проекта, решение D17.

- [ ] **Step 1: Добавить README-раздел «Обновление»**

После «Первый запуск» и перед «Структура»:

```markdown
## Обновление существующего проекта

Скилл не обновляется автоматически. Обновление — только между спринтами
и отдельным PR.

В OpenCode: команда «обнови скилл» → режим Upgrade. Подробная процедура —
`.opencode/skills/scrum-crew/references/upgrade.md`.

Установленная версия — `.opencode/skills/scrum-crew/VERSION`. Установщик
копирует скилл и агентов, но не трогает `.scrum/`, `openspec/`, `docs/`
и код проекта. После обновления удалите старые папки скилла и обновите
`opencode.json`, если в нём были старые skill-id.
```

- [ ] **Step 2: Добавить `VERSION` в структуру README**

В блоке структуры после `SKILL.md`:

```text
    VERSION               # установленная версия
```

- [ ] **Step 3: Добавить правило в `template/AGENTS.md`**

В «С чего начинать» пункт 6:

```markdown
6. Для обновления скилла — команда «обнови скилл», отдельный PR между
   спринтами; подробно —
   `.opencode/skills/scrum-crew/references/upgrade.md`.
```

- [ ] **Step 4: Добавить D17 в `docs/DECISIONS.md`**

После D16:

```markdown
## D17. Обновление скилла в проектах-потребителях

**Статус:** принято.
**Почему:** скилл копируется в проект, автообновления нет; без явной
процедуры проекты остаются на старых версиях и ломаются на breaking
changes.
**Последствия:** каноническая процедура — `references/upgrade.md`;
установленная версия — `.opencode/skills/scrum-crew/VERSION`; обновление
только между спринтами, по команде владельца, отдельным PR, через
установщик без `--with-scaffold`; `.scrum/`, `openspec/`, `docs/` и код
не трогаются; старые skill-id удаляются, `opencode.json` обновляется;
rollback — revert PR или переустановка старого тега. Первый переход
`sprint-crew` → `scrum-crew` — по README/D16.
```

- [ ] **Step 5: Проверить**

```bash
grep -q "## Обновление существующего проекта" README.md
grep -q "VERSION" README.md
grep -q "references/upgrade.md" template/AGENTS.md
grep -q "## D17" docs/DECISIONS.md
```

- [ ] **Step 6: Закоммитить**

```bash
git add README.md template/AGENTS.md docs/DECISIONS.md
git commit -m "docs: link upgrade guide from README and template"
```

---

### Task 5: Проверить upgrade-процедуру

**Files:**
- Test: временные каталоги в `/tmp/opencode/`
- No source changes.

**Interfaces:**
- Consumes: `VERSION`, `references/upgrade.md`, `install.sh`.
- Produces: доказательство, что процедура обновляет скилл, не трогает
  состояние проекта и предупреждает о старой папке.

- [ ] **Step 1: Проверить latest-tag**

Run:
```bash
git ls-remote --tags --refs --sort=-v:refname \
  https://github.com/seshmonke/scrum-crew.git 'v*' \
  | awk -F/ 'NR==1{print $NF}'
```
Expected: `v0.3.0` (до релиза v0.4.0).

- [ ] **Step 2: Смоделировать проект на v0.3.0**

```bash
base="$(mktemp -d /tmp/opencode/upgrade-base.XXXXXX)"
git clone --depth 1 --branch v0.3.0 https://github.com/seshmonke/scrum-crew.git "$base"
project="$(mktemp -d /tmp/opencode/upgrade-project.XXXXXX)"
"$base/install.sh" "$project"
test -d "$project/.opencode/skills/sprint-crew"
mkdir -p "$project/.scrum" "$project/openspec" "$project/docs"
printf 'state' > "$project/.scrum/state.json"
printf 'spec' > "$project/openspec/spec.md"
printf 'doc' > "$project/docs/keep.md"
```

- [ ] **Step 3: Обновить текущей веткой**

```bash
tmp="$(mktemp -d /tmp/opencode/upgrade-current.XXXXXX)"
cp -R /home/frozenpunk/scrum-crew/.opencode "$tmp/"
cp -R /home/frozenpunk/scrum-crew/template "$tmp/"
cp /home/frozenpunk/scrum-crew/install.sh "$tmp/"
"$tmp/install.sh" "$project" | tee /tmp/opencode/upgrade-install.log
grep -F "old skill found" /tmp/opencode/upgrade-install.log
test -f "$project/.opencode/skills/scrum-crew/VERSION"
test "$(cat "$project/.opencode/skills/scrum-crew/VERSION")" = "0.4.0-dev"
rm -rf "$project/.opencode/skills/sprint-crew"
test ! -d "$project/.opencode/skills/sprint-crew"
test "$(cat "$project/.scrum/state.json")" = "state"
test "$(cat "$project/openspec/spec.md")" = "spec"
test "$(cat "$project/docs/keep.md")" = "doc"
```

- [ ] **Step 4: Проверить ссылки и frontmatter**

```bash
cd "$project/.opencode/skills/scrum-crew"
grep -rhoE '(references|assets)/[a-z0-9-]+\.md' . \
  | sort -u \
  | while read -r p; do test -f "$p" || echo "missing: $p"; done
test "$(sed -n '2p' SKILL.md)" = "name: scrum-crew"
```

- [ ] **Step 5: Проверить скрипты и diff**

```bash
cd /home/frozenpunk/scrum-crew
bash -n install.sh
git diff --check
```

---

### Task 6: Запушить и открыть PR #5

**Files:**
- Branch: `task/skill-upgrade-guide`
- PR: → `task/quality-skill-waves`

**Interfaces:**
- Consumes: коммиты Task 1–4, проверки Task 5.
- Produces: PR #5 в стеке.

- [ ] **Step 1: Запушить**

```bash
git push -u origin task/skill-upgrade-guide
```

- [ ] **Step 2: Открыть PR**

```bash
body="$(mktemp /tmp/opencode/skill-upgrade-pr.XXXXXX.md)"
cat > "$body" <<'EOF'
## Что
- `references/upgrade.md`: процедура обновления скилла в существующем проекте.
- `VERSION` в скилле: установленная версия.
- Режим `Upgrade` в `SKILL.md`, README, `template/AGENTS.md`, D17.
- Первый переход `sprint-crew` → `scrum-crew` описан отдельно.

## Проверка
- upgrade-процедура смоделирована на v0.3.0 → текущая ветка.
- `.scrum/`, `openspec/`, `docs/` не изменились.
- старый skill-dir удалён, `VERSION` = target.
- link-check и `bash -n install.sh`.

## Стек
- #1 → #2 → #3 → #4 → этот PR.

## Раскатка
Релиз v0.4.0 — после мержа всей цепочки. Проекты-потребители не трогаем.
EOF
gh pr create \
  --repo seshmonke/scrum-crew \
  --base task/quality-skill-waves \
  --head task/skill-upgrade-guide \
  --title "docs(skill): add upgrade guide for existing projects" \
  --body-file "$body"
```

- [ ] **Step 3: Проверить**

```bash
gh pr list --repo seshmonke/scrum-crew --json number,title,baseRefName,headRefName,state
```

Expected: PR #5 open, base `task/quality-skill-waves`.

---

### Task 7: Release follow-up (не выполнять сейчас)

- [ ] После мержа цепочки #1–#5 заменить `0.4.0-dev` на `0.4.0` в
      `.opencode/skills/scrum-crew/VERSION`.
- [ ] Bump `README.md`/`CHANGELOG.md`, tag `v0.4.0`, GitHub Release.
- [ ] Удалить legacy-триггер «через sprint-crew» из `SKILL.md` после
      релиза.
- [ ] Раскатать v0.4.0 на проекты; обновить `clout-cloud` и правила
      skill-id у потребителей.
