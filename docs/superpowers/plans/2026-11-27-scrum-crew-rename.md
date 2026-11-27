# Scrum Crew Rename Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Переименовать скилл, бренд и GitHub-репозиторий `sprint-crew` / «Sprint Crew» в `scrum-crew` / «Scrum Crew», не меняя поведение методологии и не раскатывая новую версию на проекты.

**Architecture:** skill-пакет переезжает через `git mv`; точные строки `sprint-crew` и `Sprint Crew` заменяются во всех активных ссылках; установщики предупреждают о старой папке; README получает раздел миграции; решение фиксируется как D16; GitHub-репозиторий переименовывается, remote обновляется явно, открывается PR. Локальный каталог переименовывается в конце, после перевода сессии в `/tmp/opencode`.

**Tech Stack:** Git, Bash, PowerShell, GitHub CLI, OpenCode skills.

**Spec:** `docs/superpowers/specs/2026-11-27-scrum-crew-rename-design.md`

## Global Constraints

- Не менять поведение, содержание, роли, гейты и шаблоны методологии — только имена, пути и миграционные заметки.
- Не менять версию `v0.3` и `CHANGELOG.md`; bump и release-заметки — после завершения всех текущих планов.
- Не трогать проекты-потребители, включая `localhand` и PR #54–#56.
- Оставить «через sprint-crew» legacy-триггером на один релиз.
- Ветка: `task/rename-scrum-crew` от `main`. PR не мержить без владельца.
- GitHub-репозиторий: `seshmonke/sprint-crew` → `seshmonke/scrum-crew`; remote обновить явно.
- Локальный каталог: `/home/frozenpunk/sprint-crew` → `/home/frozenpunk/scrum-crew` — только после git-работы и PR.

## Review Focus

- Старый путь `.opencode/skills/sprint-crew/` остался в агенте или шаблоне → агент не найдёт reference; ловится `git grep` и smoke-тестом установки.
- В установленном проекте осталась старая папка скилла → OpenCode видит два скилла; ловится предупреждением установщика и README-миграцией.
- Невалидный frontmatter (`name: Sprint Crew` с пробелом) → скилл не обнаруживается; ловится точной проверкой `name: scrum-crew`.
- GitHub-redirect не покрывает часть API/скриптов → push/PR падает; ловится явным `git remote set-url` и `gh repo view`.
- Переименование локального каталога ломает cwd сессии → команды идут не туда; ловится последовательностью `session_move` → `mv` → `session_move`.
- Ссылки `references/` и `assets/` внутри скилла ломаются после переезда → скилл не может загрузить файл; ловится link-check.

---

### Task 1: Зафиксировать дизайн и план

**Files:**
- Create: `docs/superpowers/specs/2026-11-27-scrum-crew-rename-design.md`
- Create: `docs/superpowers/plans/2026-11-27-scrum-crew-rename.md`

**Interfaces:**
- Consumes: ничего.
- Produces: spec и план, на которые ссылаются коммит и PR.

- [ ] **Step 1: Проверить ветку**

Run: `git status --short --branch`
Expected: `## task/rename-scrum-crew`; untracked: `PROGRESS.md` (рабочие
заметки, не коммитить) и `docs/superpowers/` (дизайн и план, добавить в
коммит).

- [ ] **Step 2: Добавить документы**

```bash
git add docs/superpowers/specs/2026-11-27-scrum-crew-rename-design.md \
        docs/superpowers/plans/2026-11-27-scrum-crew-rename.md
```

- [ ] **Step 3: Закоммитить**

```bash
git commit -m "docs: add scrum-crew rename design and plan"
```

- [ ] **Step 4: Проверить коммит**

Run: `git show --stat --oneline HEAD`
Expected: два файла в `docs/superpowers/`.

---

### Task 2: Переименовать skill-пакет

**Files:**
- Move: `.opencode/skills/sprint-crew/` → `.opencode/skills/scrum-crew/`
- Modify: `.opencode/skills/scrum-crew/SKILL.md:1-8`

**Interfaces:**
- Consumes: ветку и документы из Task 1.
- Produces: skill-id `scrum-crew`, каталог `.opencode/skills/scrum-crew/`, заголовок `# Scrum Crew`.

- [ ] **Step 1: Переместить каталог**

```bash
git mv .opencode/skills/sprint-crew .opencode/skills/scrum-crew
```

- [ ] **Step 2: Обновить frontmatter, триггер и заголовок**

В `.opencode/skills/scrum-crew/SKILL.md`:

```yaml
---
name: scrum-crew
description: Ведёт веб-разработку по Scrum командой из 12+ агентов — инициализация продукта, спринт 4–8 часов, 4–6 циклов, дейлик на границе цикла, 12 слотов в коде, OpenSpec для поведения, шина сообщений и последовательный merge train. Включать по команде владельца — «инициализируй проект», «запусти спринт», «через scrum-crew» (ранее sprint-crew), «scrum спринт», «спланируй спринт», «проведи ретро».
---
```

Первый заголовок после frontmatter: `# Scrum Crew`.

- [ ] **Step 3: Проверить, что старый ID не остался**

Run:
```bash
git grep -n "sprint-crew\|Sprint Crew" -- .opencode/skills/scrum-crew
```
Expected: только одна строка — legacy-триггер в `description`.

- [ ] **Step 4: Проверить frontmatter**

Run: `sed -n '1,8p' .opencode/skills/scrum-crew/SKILL.md`
Expected: `name: scrum-crew`, заголовок `# Scrum Crew`.

- [ ] **Step 5: Закоммитить**

```bash
git add -A .opencode/skills
git commit -m "refactor(skill): rename sprint-crew to scrum-crew"
```

---

### Task 3: Обновить ссылки, установщики, README и ADR

**Files:**
- Modify: `.opencode/agents/scrum-worker.md`
- Modify: `.opencode/agents/scrum-reviewer.md`
- Modify: `.opencode/agents/scrum-orchestrator.md`
- Modify: `.opencode/agents/scrum-methodology-auditor.md`
- Modify: `install.sh`
- Modify: `install.ps1`
- Modify: `README.md`
- Modify: `template/AGENTS.md`
- Modify: `template/docs/quality/audits/README.md`
- Modify: `docs/RAPTOR-SKILL.md`
- Modify: `docs/DESIGN.md`
- Modify: `docs/DECISIONS.md`
- Modify: `docs/evidence/SKILL-METHODOLOGY.md`

**Interfaces:**
- Consumes: skill-id и каталог из Task 2.
- Produces: все активные ссылки указывают на `scrum-crew`; установщики предупреждают о старой папке; README объясняет миграцию; D16 фиксирует решение.

- [ ] **Step 1: Заменить точные строки в перечисленных файлах**

```bash
perl -pi -e 's/sprint-crew/scrum-crew/g; s/Sprint Crew/Scrum Crew/g' \
  .opencode/agents/scrum-worker.md \
  .opencode/agents/scrum-reviewer.md \
  .opencode/agents/scrum-orchestrator.md \
  .opencode/agents/scrum-methodology-auditor.md \
  install.sh install.ps1 README.md \
  template/AGENTS.md template/docs/quality/audits/README.md \
  docs/RAPTOR-SKILL.md docs/DESIGN.md docs/DECISIONS.md \
  docs/evidence/SKILL-METHODOLOGY.md
```

- [ ] **Step 2: Добавить предупреждение в `install.sh`**

После строки `echo "Installed agents: $TARGET/.opencode/agents"`:

```bash
if [ -d "$TARGET/.opencode/skills/sprint-crew" ]; then
  echo ""
  echo "Warning: old skill found: $TARGET/.opencode/skills/sprint-crew"
  echo "Remove it to avoid two versions of the skill."
fi
```

- [ ] **Step 3: Добавить предупреждение в `install.ps1`**

После строки `Write-Host "Installed agents: $opencode\agents"`:

```powershell
$oldSkill = Join-Path $opencode "skills\sprint-crew"
if (Test-Path $oldSkill) {
    Write-Host ""
    Write-Host "Warning: old skill found: $oldSkill"
    Write-Host "Remove it to avoid two versions of the skill."
}
```

- [ ] **Step 4: Добавить README-раздел миграции**

После раздела «Вручную» и перед «Первый запуск»:

```markdown
### Миграция с `sprint-crew`

Репозиторий и скилл переименованы в `scrum-crew`. Старые ссылки на
GitHub редиректятся, но установленную копию нужно обновить вручную:

1. Обновите скилл из репозитория.
2. Удалите старую папку `.opencode/skills/sprint-crew/`, иначе OpenCode
   увидит две версии скилла.
3. Команда «через sprint-crew» пока принимается как legacy; новая —
   «через scrum-crew».

Новая версия раскатывается на проекты после завершения текущих планов
по скиллу.
```

- [ ] **Step 5: Добавить D16 в `docs/DECISIONS.md`**

После D15:

```markdown
## D16. Переименование скилла и репозитория в Scrum Crew

**Статус:** принято.
**Почему:** `scrum-crew` короче, выравнивает ID скилла с агентами
`scrum-*` и лучше рифмуется за счёт повтора `cr`.
**Последствия:** каталог скилла — `.opencode/skills/scrum-crew/`,
skill-id — `scrum-crew`, заголовок — «Scrum Crew»; репозиторий —
[seshmonke/scrum-crew](https://github.com/seshmonke/scrum-crew)
(GitHub редиректит старый URL). Старая команда «через sprint-crew»
остаётся legacy-триггером на один релиз. Установленные проекты должны
удалить `.opencode/skills/sprint-crew/`. Раскатка новой версии на
проекты — после завершения всех текущих планов по скиллу.
```

- [ ] **Step 6: Проверить, что остались только осознанные упоминания**

Run:
```bash
git grep -n "sprint-crew\|Sprint Crew" -- . ':(exclude)docs/superpowers'
```
Expected: только legacy-триггер в `SKILL.md`, README-миграция и D16.
Каждое совпадение прочитать глазами.

- [ ] **Step 7: Проверить скрипты и diff**

```bash
bash -n install.sh
git diff --check
```

- [ ] **Step 8: Закоммитить**

```bash
git add .opencode/agents install.sh install.ps1 README.md template docs/DECISIONS.md docs/DESIGN.md docs/RAPTOR-SKILL.md docs/evidence/SKILL-METHODOLOGY.md
git commit -m "docs: point links and installers at scrum-crew"
```

---

### Task 4: Smoke-тест установки и ссылок

**Files:**
- Test: временные каталоги в `/tmp/opencode/`
- No source changes.

**Interfaces:**
- Consumes: `install.sh` и skill-пакет из Task 3.
- Produces: доказательство, что установка создаёт `scrum-crew`, предупреждает о старой папке и не перезаписывает scaffold.

- [ ] **Step 1: Установка в пустой проект**

```bash
tmp="$(mktemp -d /tmp/opencode/scrum-crew-install.XXXXXX)"
bash install.sh "$tmp"
test -f "$tmp/.opencode/skills/scrum-crew/SKILL.md"
test ! -e "$tmp/.opencode/skills/sprint-crew"
test -f "$tmp/.opencode/agents/scrum-worker.md"
```

- [ ] **Step 2: Предупреждение о старой папке**

```bash
tmp2="$(mktemp -d /tmp/opencode/scrum-crew-old.XXXXXX)"
mkdir -p "$tmp2/.opencode/skills/sprint-crew"
bash install.sh "$tmp2" | grep -F "old skill found"
```

- [ ] **Step 3: Scaffold и защита от перезаписи**

```bash
tmp3="$(mktemp -d /tmp/opencode/scrum-crew-scaffold.XXXXXX)"
bash install.sh "$tmp3" --with-scaffold
test -f "$tmp3/AGENTS.md"
test -f "$tmp3/.scrum/state.json"
printf 'keep' > "$tmp3/AGENTS.md"
bash install.sh "$tmp3" --with-scaffold | grep -F "skip (exists): AGENTS.md"
```

- [ ] **Step 4: Проверить внутренние ссылки**

```bash
cd .opencode/skills/scrum-crew
grep -rhoE '(references|assets)/[a-z0-9-]+\.md' . \
  | sort -u \
  | while read -r p; do test -f "$p" || echo "missing: $p"; done
```
Expected: пустой вывод.

- [ ] **Step 5: Проверить frontmatter**

```bash
cd /home/frozenpunk/sprint-crew
test "$(sed -n '2p' .opencode/skills/scrum-crew/SKILL.md)" = "name: scrum-crew"
```

---

### Task 5: Переименовать GitHub-репозиторий, обновить remote, открыть PR

**Files:**
- GitHub: `seshmonke/sprint-crew` → `seshmonke/scrum-crew`
- Remote: `origin`
- PR: `task/rename-scrum-crew` → `main`

**Interfaces:**
- Consumes: коммиты из Task 2–3, проверки Task 4.
- Produces: PR в новом репозитории; remote указывает на новый URL.

- [ ] **Step 1: Переименовать репозиторий**

```bash
gh repo rename scrum-crew --repo seshmonke/sprint-crew --yes
```

Если команда падает — остановиться и доложить; не переименовывать вручную через веб без подтверждения.

- [ ] **Step 2: Обновить remote**

```bash
git remote set-url origin https://github.com/seshmonke/scrum-crew.git
git remote get-url origin
gh repo view seshmonke/scrum-crew --json nameWithOwner,url
```

Expected: URL `https://github.com/seshmonke/scrum-crew`.

- [ ] **Step 3: Запушить ветку**

```bash
git push -u origin task/rename-scrum-crew
```

- [ ] **Step 4: Открыть PR**

```bash
body="$(mktemp /tmp/opencode/scrum-crew-pr.XXXXXX.md)"
cat > "$body" <<'EOF'
## Что меняется
- skill-id и каталог: `sprint-crew` → `scrum-crew`
- бренд: «Sprint Crew» → «Scrum Crew»
- GitHub-репозиторий: `seshmonke/scrum-crew`
- README: миграция и предупреждение установщика о старой папке
- D16 в `docs/DECISIONS.md`

## Проверка
- `git grep` — только осознанные legacy-упоминания
- `bash -n install.sh`
- smoke-тест установки в temp-проект
- link-check `references/` и `assets/`

## Раскатка
На проекты не ставим до завершения всех текущих планов по скиллу.
EOF
gh pr create \
  --repo seshmonke/scrum-crew \
  --base main \
  --head task/rename-scrum-crew \
  --title "refactor: rename Sprint Crew to Scrum Crew" \
  --body-file "$body"
```

- [ ] **Step 5: Проверить PR**

```bash
gh pr view --repo seshmonke/scrum-crew --json number,title,url,state
```

- [ ] **Step 6: Не мержить**

Оставить PR владельцу. Merge и rebase quality-веток — отдельный шаг после подтверждения.

---

### Task 6: Переименовать локальный каталог и перевести сессию

**Files:**
- Move: `/home/frozenpunk/sprint-crew` → `/home/frozenpunk/scrum-crew`
- Session cwd.

**Interfaces:**
- Consumes: PR из Task 5.
- Produces: локальный каталог и cwd сессии указывают на `scrum-crew`.

- [ ] **Step 1: Перевести сессию в `/tmp/opencode`**

Вызвать `tools.opencode.session_move({ directory: "/tmp/opencode" })` и
дождаться безопасной границы. Не запускать в этом же вызове команды,
зависящие от нового каталога.

- [ ] **Step 2: Переименовать каталог**

```bash
cd /home/frozenpunk
mv sprint-crew scrum-crew
```

- [ ] **Step 3: Перевести сессию в новый каталог**

Вызвать `tools.opencode.session_move({ directory: "/home/frozenpunk/scrum-crew" })`.

- [ ] **Step 4: Проверить**

```bash
pwd
git status --short --branch
git remote get-url origin
```

Expected: `/home/frozenpunk/scrum-crew`, ветка `task/rename-scrum-crew`,
remote `https://github.com/seshmonke/scrum-crew.git`.

---

### Task 7: Follow-up после merge (не выполнять сейчас)

**Files:**
- Branches: `task/quality-skill-tier-tdd`, `task/quality-skill-t2`, `task/quality-skill-waves`
- `CHANGELOG.md`, `README.md` — только на финальном release-шаге.

**Interfaces:**
- Consumes: merged rename-PR.
- Produces: quality-ветки на новом `main`, stacked PR, финальный release и раскатка.

- [ ] **Step 1: После merge перебазировать quality-ветки**

```bash
git switch task/quality-skill-tier-tdd && git rebase main
git switch task/quality-skill-t2 && git rebase task/quality-skill-tier-tdd
git switch task/quality-skill-waves && git rebase task/quality-skill-t2
```
Конфликты из-за смены пути решать вручную; после каждого rebase — `git push --force-with-lease`.

- [ ] **Step 2: Открыть stacked PR**

Слой 1 → `main`, слой 2 → слой 1, слой 3 → слой 2.

- [ ] **Step 3: Финальный release после всех текущих планов**

- Bump версии в `README.md` и `CHANGELOG.md`.
- Синхронизировать `.opencode/agents/scrum-reviewer.md` и `template/` с новыми гейтами, если это входит в текущие планы.
- Только после этого раскатывать новую версию на проекты.
- `localhand` PR #54–#56 не мержить; закрытие/удаление веток — владелец.
