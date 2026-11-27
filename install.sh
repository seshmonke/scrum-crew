#!/usr/bin/env bash
set -euo pipefail

TARGET=""
WITH_SCAFFOLD=0

for arg in "$@"; do
  case "$arg" in
    --with-scaffold) WITH_SCAFFOLD=1 ;;
    -h|--help)
      echo "Usage: install.sh [target] [--with-scaffold]"
      exit 0
      ;;
    *) if [ -z "$TARGET" ]; then TARGET="$arg"; fi ;;
  esac
done

TARGET="${TARGET:-.}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$TARGET"
TARGET="$(cd "$TARGET" && pwd)"

mkdir -p "$TARGET/.opencode"
cp -R "$ROOT/.opencode/." "$TARGET/.opencode/"

echo "Installed skill: $TARGET/.opencode/skills/scrum-crew"
echo "Installed agents: $TARGET/.opencode/agents"

if [ -d "$TARGET/.opencode/skills/sprint-crew" ]; then
  echo ""
  echo "Warning: old skill found: $TARGET/.opencode/skills/sprint-crew"
  echo "Remove it to avoid two versions of the skill."
fi

if [ "$WITH_SCAFFOLD" -eq 1 ]; then
  cd "$ROOT/template"
  find . -type f -print0 | while IFS= read -r -d '' file; do
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
echo "  then in OpenCode: initialize the project via scrum-crew"

if ! command -v openspec >/dev/null 2>&1; then
  echo ""
  echo "Warning: openspec is not in PATH."
  echo "Install: curl -fsSL https://openspec.dev/cli/install.sh | sh"
fi
