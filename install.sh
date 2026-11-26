#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-.}"
WITH_SCAFFOLD="${2:-}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$TARGET"
TARGET="$(cd "$TARGET" && pwd)"

mkdir -p "$TARGET/.opencode"
cp -R "$ROOT/.opencode/." "$TARGET/.opencode/"

echo "Installed skill: $TARGET/.opencode/skills/scrum-team"
echo "Installed agents: $TARGET/.opencode/agents"

if [ "$WITH_SCAFFOLD" = "--with-scaffold" ]; then
  cd "$ROOT/template"
  find . -type f | while read -r file; do
    relative="${file#./}"
    destination="$TARGET/$relative"
    mkdir -p "$(dirname "$destination")"
    if [ -e "$destination" ]; then
      echo "skip (exists): $relative"
    else
      cp "$file" "$destination"
      echo "created: $relative"
    fi
  done
fi

echo ""
echo "Next:"
echo "  cd \"$TARGET\""
echo "  openspec init --tools opencode --scope project"
echo "  then in OpenCode: initialize the project via scrum-team"
