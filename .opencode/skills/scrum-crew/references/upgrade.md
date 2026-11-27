# Обновление скилла в существующем проекте

Скилл не обновляется автоматически. Обновление — отдельная операция
между спринтами, по команде владельца и отдельным PR. Это не PBI и не
часть спринта.

## 0. Когда можно и когда нельзя

Можно, только если:

- владелец дал команду на обновление;
- текущий спринт закрыт (нет активного цикла, review или retro);
- рабочее дерево проекта чистое;
- проект в git и есть возможность откатить коммит;
- доступен upstream `seshmonke/scrum-crew`;
- target — released tag `vX.Y.Z`.

Нельзя:

- обновлять посреди спринта;
- ставить `main` или версию с `-dev`;
- запускать `install.sh --with-scaffold`;
- удалять `.scrum/`, `openspec/`, `docs/` или код проекта;
- продолжать, если changelog не объясняет breaking change.

При любом сомнении — стоп и вопрос владельцу.

## 1. Версии

Установленная версия лежит рядом со скиллом:

```bash
cat .opencode/skills/scrum-crew/VERSION
```

Последний released tag:

```bash
latest="$(git ls-remote --tags --refs --sort=-v:refname \
  https://github.com/seshmonke/scrum-crew.git 'v*' \
  | awk -F/ 'NR==1{print $NF}')"
printf 'latest=%s\n' "$latest"
```

Если `gh` доступен, можно так:

```bash
gh release view --repo seshmonke/scrum-crew --json tagName --jq .tagName
```

Правила:

- `VERSION` нет — это pre-v0.4.0 установка; читать changelog целиком и
  действовать осторожнее.
- `VERSION` содержит `-dev` — это незарелиженная сборка; target только
  released tag, не `main`. Если тег не новее — обновление не требуется.
- `VERSION` совпадает с `${latest#v}` — обновление не требуется.
- `latest` пуст — нет сети/тегов; стоп.

## 2. Changelog и migration notes

Склонировать target во временный каталог:

```bash
target="$latest"
tmp="$(mktemp -d /tmp/opencode/scrum-crew-upgrade.XXXXXX)"
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

2. Создать ветку обновления:

   ```bash
   git switch -c "chore/upgrade-scrum-crew-${target}"
   ```

3. Если скилл или агенты кастомизированы, сохранить копии:

   ```bash
   cp -R .opencode/skills/scrum-crew /tmp/opencode/scrum-crew-before
   cp -R .opencode/agents /tmp/opencode/scrum-agents-before
   ```

   После установки сравнить и перенести свои правки поверх новых файлов.

## 4. Установка

Из корня проекта, **без** `--with-scaffold`.

Linux / macOS:

```bash
"$tmp/install.sh" "$PWD"
```

Windows PowerShell:

```powershell
git clone --depth 1 --branch $target https://github.com/seshmonke/scrum-crew.git $tmp
powershell -ExecutionPolicy Bypass -File "$tmp\install.ps1" -Target (Get-Location)
```

Установщик:

- копирует `.opencode/skills/scrum-crew/`;
- копирует `.opencode/agents/scrum-*.md`;
- предупреждает, если нашёл старую папку скилла;
- не трогает `.scrum/`, `openspec/`, `docs/` и код проекта.

Если установщик недоступен, скопировать вручную
`.opencode/skills/scrum-crew/` и `.opencode/agents/scrum-*.md` из target.

## 5. Миграция

1. Удалить старые папки скилла, о которых предупредил установщик:

   ```bash
   rm -rf .opencode/skills/sprint-crew
   ```

   Не удалять `.scrum/`, `openspec/`, `docs/` и код.

2. Обновить `opencode.json`: skill-id, permissions, упоминания
   `sprint-crew` → `scrum-crew`.

3. Обновить активные ссылки в `AGENTS.md`, проектных доках и скриптах.
   Исторические записи (CHANGELOG, ADR, migration notes) не переписывать.

4. Перенести кастомизации скилла и агентов поверх установленных файлов.

5. Выполнить breaking-change шаги из changelog, если они есть.

## 6. Проверка

```bash
test "$(cat .opencode/skills/scrum-crew/VERSION)" = "${target#v}"
test ! -d .opencode/skills/sprint-crew
```

Проверить:

- OpenCode видит ровно один `scrum-crew`, старого skill-id нет;
- внутренние ссылки скилла резолвятся:

  ```bash
  cd .opencode/skills/scrum-crew
  grep -rhoE '(references|assets)/[a-z0-9-]+\.md' . \
    | sort -u \
    | while read -r p; do test -f "$p" || echo "missing: $p"; done
  ```

- `openspec validate --all --strict` (если OpenSpec используется);
- проектная команда `verify`;
- `git diff --stat` показывает только `.opencode/` и миграционные правки;
  `.scrum/`, `openspec/`, `docs/` и код не изменились.

Если проверка красная — не коммитить обновление, сначала rollback.

## 7. Коммит и PR

Обновление — отдельный PR:

```bash
git add .opencode opencode.json AGENTS.md
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

```bash
git revert <upgrade-commit>
```

Если проект ещё не закоммитил обновление — вернуть ветку/файлы из git.
Если нужно вернуть старую версию скилла — повторить установку со старым
тегом. `.scrum/`, `openspec/`, `docs/` и код проекта установщик не
трогал, поэтому rollback касается только `.opencode/` и агентов.

## 9. Первый переход `sprint-crew` → `scrum-crew`

Если в проекте ещё `.opencode/skills/sprint-crew/` и нет
`.opencode/skills/scrum-crew/VERSION`, это установка до v0.4.0.
Сначала выполнить миграцию из README/D16:

1. установить `scrum-crew` через установщик;
2. удалить `.opencode/skills/sprint-crew/`;
3. обновить `opencode.json` и активные ссылки;
4. убедиться, что OpenCode видит один `scrum-crew`.

После этого дальше работает обычная процедура из этого документа.

## 10. Красные флаги

- обновление запущено в спринте;
- target — `main` или `-dev`;
- `--with-scaffold` при обновлении;
- удаление `.scrum/`, `openspec/`, `docs/` или кода;
- старая папка скилла осталась;
- кастомизации агентов потеряны;
- `openspec validate` или `verify` красные, а обновление всё равно
  коммитится;
- нет чистого git и rollback.
