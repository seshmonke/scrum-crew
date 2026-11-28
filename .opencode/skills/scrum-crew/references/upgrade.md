# Обновление скилла в существующем проекте

Скилл не обновляется автоматически. Обновление — отдельная операция
между спринтами, по команде владельца и отдельным PR. Это не PBI и не
часть спринта.

## 0. Платформа и границы

Процедура написана для Bash: Linux, macOS, WSL и Git Bash на Windows.
Выполняйте команды в одной shell-сессии: переменные `installed`, `latest`,
`target`, `tmp` и `backup` не переживают переход между блоками. Если
запускаете блоками — задайте нужные переменные заново.

На Windows без Git Bash/WSL полный сценарий не поддерживается:
`install.ps1` остаётся для первичной установки, но upgrade-процедура
требует Bash-утилит (`mktemp`, `cp`, `grep`, `diff`, `test`). Не
смешивайте Bash-переменные с PowerShell.

Можно, только если:

- владелец дал команду на обновление;
- текущий спринт закрыт;
- рабочее дерево проекта чистое;
- проект в git и есть возможность откатить коммит;
- доступен upstream `seshmonke/scrum-crew`;
- target — released tag `vX.Y.Z`, и он новее установленной версии.

Нельзя:

- обновлять посреди спринта;
- ставить `main`, `-dev` или prerelease (`-rc`, `-beta`);
- запускать `install.sh --with-scaffold`;
- удалять `.scrum/`, `openspec/`, `docs/` или код проекта;
- продолжать, если changelog не объясняет breaking change.

## 1. Версии и target

Установленная версия:

```bash
if [ -f .opencode/skills/scrum-crew/VERSION ]; then
  installed="$(tr -d '\r' < .opencode/skills/scrum-crew/VERSION)"
else
  installed="unknown"
fi
printf 'installed=%s\n' "$installed"
```

Последний released tag:

```bash
latest="$(
  git ls-remote --tags --refs --sort=-v:refname \
    https://github.com/seshmonke/scrum-crew.git 'v*' \
  | awk -F/ '{print $NF}' \
  | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' \
  | head -n1
)"
printf 'latest=%s\n' "$latest"
```

`grep` отсекает `-dev`, `-rc` и другие prerelease-теги: target — только
финальный `vX.Y.Z`.

Выбрать target:

```bash
target="$latest"
case "$target" in
  v[0-9]*.[0-9]*.[0-9]*) ;;
  *) echo "target must be released vX.Y.Z"; exit 1 ;;
esac
```

Если `gh` доступен, подтвердить, что тег опубликован как GitHub Release:

```bash
gh release view "$target" --repo seshmonke/scrum-crew >/dev/null || {
  echo "target is not a GitHub Release"; exit 1;
}
```

Если `gh` нет — владелец подтверждает, что `$target` — released tag.
`gh release view` без тега не использовать для выбора latest: порядок
публикации не равен semver.

Сравнить версии:

```bash
ver_gt() {
  local IFS=.
  local a=($1) b=($2) i
  for i in 0 1 2; do
    if [ "${a[i]:-0}" -gt "${b[i]:-0}" ]; then return 0; fi
    if [ "${a[i]:-0}" -lt "${b[i]:-0}" ]; then return 1; fi
  done
  return 1
}

target_version="${target#v}"
installed_core="${installed%%-*}"

if [ "$installed" = "unknown" ]; then
  echo "pre-versioned install: read the full changelog and confirm with owner"
elif [ "$installed" = "$target_version" ]; then
  echo "already up to date"; exit 0
elif [ "${installed#*-}" != "$installed" ]; then
  echo "dev build $installed: reinstall released $target"
elif ! ver_gt "$target_version" "$installed_core"; then
  echo "target $target is not newer than installed $installed"; exit 1
fi
```

## 2. Changelog и migration notes

Склонировать target во временный каталог:

```bash
tmp="$(mktemp -d "${TMPDIR:-/tmp}/scrum-crew-upgrade.XXXXXX")"
git clone --depth 1 --branch "$target" \
  https://github.com/seshmonke/scrum-crew.git "$tmp"
```

Прочитать `CHANGELOG.md` от установленной версии до target. Искать:

- `Breaking`;
- `Migration`;
- `Upgrade`;
- изменения skill-id, путей, триггеров, `opencode.json`.

Если в диапазоне есть breaking change без migration-инструкции — стоп и
вопрос владельцу. Не угадывать.

## 3. Подготовка

1. Проверить чистое дерево:

   ```bash
   git status --porcelain
   ```

   Вывод должен быть пустым. Грязное дерево — сначала commit/stash.

2. Проверить, что спринт закрыт. Если `.scrum/state.json` существует,
   `sprint` должен быть `null`:

   ```bash
   if [ -f .scrum/state.json ] && \
      ! grep -q '"sprint"[[:space:]]*:[[:space:]]*null' .scrum/state.json; then
     echo "active sprint in .scrum/state.json"; exit 1
   fi
   ```

   Если состояние хранится иначе — проверить по правилам проекта.

3. Создать ветку обновления:

   ```bash
   git switch -c "chore/upgrade-scrum-crew-${target}"
   ```

4. Сохранить всё `.opencode` — включая старую папку `sprint-crew`, если
   она есть:

   ```bash
   backup="$(mktemp -d "${TMPDIR:-/tmp}/scrum-crew-backup.XXXXXX")"
   cp -R .opencode "$backup/opencode-before"
   printf 'backup=%s\n' "$backup"
   ```

   Это нужно, чтобы сравнить кастомизации до удаления старой папки.

## 4. Установка

Из корня проекта, **без** `--with-scaffold`:

```bash
"$tmp/install.sh" "$PWD"
```

Установщик копирует `.opencode/` (в текущем релизе — скилл и агентов) и
предупреждает, если нашёл старую папку скилла. Он не трогает `.scrum/`,
`openspec/`, `docs/` и код проекта.

**Игнорировать блок `Next` установщика при обновлении.** Он предназначен
для новой установки: не запускать `openspec init` и Init, иначе можно
изменить `openspec/`, `.scrum/` и `docs/`.

Если установщик недоступен, скопировать вручную
`.opencode/skills/scrum-crew/` и `.opencode/agents/scrum-*.md` из target.

## 5. Миграция

1. Сравнить старую папку с бэкапом и сохранить кастомизации:

   ```bash
   diff -ru "$backup/opencode-before/skills/sprint-crew" \
     .opencode/skills/sprint-crew 2>/dev/null || true
   ```

   Если правки есть — перенести их в `scrum-crew`/агентов после
   установки.

2. Удалить старые папки скилла, о которых предупредил установщик:

   ```bash
   rm -rf .opencode/skills/sprint-crew
   ```

   Не удалять `.scrum/`, `openspec/`, `docs/` и код.

3. Обновить `opencode.json`, если он есть: skill-id, permissions,
   упоминания `sprint-crew` → `scrum-crew`.

4. Обновить активные ссылки в `AGENTS.md`, конфигах и скриптах.
   Содержимое `docs/` и `openspec/` не менять; если в них есть ссылки на
   старый skill-id, это отдельная задача/PR.

5. Перенести кастомизации скилла и агентов поверх установленных файлов.

6. Выполнить breaking-change шаги из changelog, если они есть.

## 6. Проверка

```bash
test "$(tr -d '\r' < .opencode/skills/scrum-crew/VERSION)" = "${target#v}"
test ! -d .opencode/skills/sprint-crew
```

Проверить:

- OpenCode видит ровно один `scrum-crew`, старого skill-id нет;
- внутренние ссылки скилла резолвятся:

  ```bash
  ( cd .opencode/skills/scrum-crew && \
    grep -rhoE '(references|assets)/[a-z0-9-]+\.md' . \
      | sort -u \
      | while read -r p; do test -f "$p" || echo "missing: $p"; done )
  ```

- `openspec validate --all --strict` (если OpenSpec используется);
- проектная команда `verify`;
- `git status --porcelain` показывает только `.opencode/` и разрешённые
  конфиги:

  ```bash
  unexpected="$(
    git status --porcelain \
      | awk '{print $2}' \
      | grep -vE '^(\.opencode/|opencode\.json$|AGENTS\.md$)' || true
  )"
  test -z "$unexpected"
  ```

  Если появились `.scrum/`, `openspec/`, `docs/` или код — стоп и
  разобраться. `git diff --stat` для этой проверки не использовать: он
  не видит untracked-файлы.

Если проверка красная — не коммитить обновление, сначала rollback.

## 7. Коммит и PR

Из корня проекта:

```bash
cd "$(git rev-parse --show-toplevel)"
git add .opencode
if [ -f opencode.json ]; then git add opencode.json; fi
if [ -f AGENTS.md ]; then git add AGENTS.md; fi
git commit -m "chore: upgrade scrum-crew to ${target}"
```

В теле PR указать:

- версию до и после;
- breaking changes и migration-шаги;
- что проверено;
- что кастомизации сохранены;
- rollback-коммит/тег.

Не смешивать upgrade с PBI спринта.

## 8. Rollback

Основной путь — revert коммита обновления:

```bash
git revert <upgrade-commit>
```

Если обновление ещё не закоммичено, восстановить только пути обновления:

```bash
git restore .opencode
git restore opencode.json AGENTS.md 2>/dev/null || true
rm -rf .opencode/skills/scrum-crew
```

Не использовать `git clean -fdx`: он удалит рабочее состояние проекта.

Переустановка старого тега:

- допустима только для тега, где уже есть `scrum-crew` (v0.4.0+);
- для v0.3.0 и раньше не использовать: старый установщик вернёт
  `sprint-crew`, а `scrum-crew` останется — получится два skill-id;
- после rollback проверить: один skill-id, `VERSION`, конфиг и
  `git status`.

## 9. Первый переход `sprint-crew` → `scrum-crew`

Если в проекте ещё `.opencode/skills/sprint-crew/` и нет
`.opencode/skills/scrum-crew/VERSION`, это установка до v0.4.0.
Первый релиз, где есть `scrum-crew`, — v0.4.0; установщик v0.3.0 ставит
`sprint-crew` и для перехода не подходит.

Порядок:

1. установить v0.4.0+ через установщик;
2. удалить `.opencode/skills/sprint-crew/` (предварительно сравнив с
   бэкапом кастомизации);
3. обновить `opencode.json` и активные ссылки;
4. убедиться, что OpenCode видит один `scrum-crew`.

После этого дальше работает обычная процедура из этого документа.

## 9.1. Миграция v0.4.0 → v0.5.0

v0.5.0 добавляет карту входа, durable task workspace и протокол свежести.
Это migration, а не автоматическое переписывание проекта.

1. Установить v0.5.0 установщиком без `--with-scaffold`.
2. Проверить новые файлы скилла: `references/context.md`,
   `assets/context.md`, `assets/brief.md`, `assets/report.md`.
   `assets/task.md` остаётся deprecated-заглушкой; новые брифы — только
   `brief.md`.
3. Создать `.scrum/README.md` из `assets/context.md`, если его нет.
   Заполнить phase/sprint/goal/next gate/active tasks и ссылки. Если файл
   уже есть — слить вручную, не перезаписывать.
4. Для активных задач создать `.scrum/sprints/NN/tasks/<id>/` и перенести
   brief/handoff/report/evidence из `/tmp` или worktree. Если worktree уже
   удалён — восстановить из `sprint.md`, PR и диффа, пометить источник и
   `status: done`/`active` по факту.
5. Старые `docs/tasks/NN-*.md` не перемещать без решения владельца; они
   остаются историей. Новый файл спринта — `.scrum/sprints/NN/sprint.md`,
   `INDEX.md` ссылается на него.
6. `report.json` (если использовался) заменить на `report.md`; старый файл
   не удалять без проверки, но канон — `report.md`.
7. Добавить контекстные шапки новым и изменяемым докам. Архивы и старые
   спринты массово не переписывать.
8. Проверить ссылки по разделу 6; `git diff --check`; `git status` — только
   `.opencode/`, `.scrum/README.md`, новые task-папки и разрешённые доки.
9. Миграция — отдельным PR между спринтами; не смешивать с PBI.

## 10. Красные флаги

- обновление запущено в спринте;
- target — `main`, `-dev` или prerelease;
- target не новее установленной версии;
- `--with-scaffold` при обновлении;
- выполнение блока `Next` установщика (`openspec init`, Init);
- удаление `.scrum/`, `openspec/`, `docs/` или кода;
- старая папка скилла осталась;
- кастомизации агентов потеряны;
- `git status` показывает изменения вне `.opencode/` и разрешённых
  конфигов;
- `openspec validate` или `verify` красные, а обновление всё равно
  коммитится;
- нет чистого git и rollback;
- v0.5.0: `.scrum/README.md` не создан, brief/handoff остались в `/tmp`,
  новые брифы пишутся не в `brief.md`, архивы переписываются массово.
