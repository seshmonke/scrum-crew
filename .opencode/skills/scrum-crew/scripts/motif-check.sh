#!/usr/bin/env bash
# motif-check.sh — ищет повторяющиеся мотивы между текстами.
# Использование:
#   bash .opencode/skills/scrum-crew/scripts/motif-check.sh <new-file> <corpus...>
# <corpus...> — файлы или папки. Проверяет слова-подписи и повтор внутри текста.
# Это эвристика: она показывает следы, решает копирайтер.
set -euo pipefail

usage() {
  printf 'Usage: bash .opencode/skills/scrum-crew/scripts/motif-check.sh <new-file> <corpus...>\n' >&2
  printf 'Watchlist: MOTIF_WATCHLIST="пауз|тишин|воздух|..."\n' >&2
}

if [ "$#" -lt 2 ]; then
  usage
  exit 2
fi

new_file="$1"
shift

if [ ! -f "$new_file" ]; then
  printf 'not a file: %s\n' "$new_file" >&2
  exit 2
fi

resolve() {
  if command -v realpath >/dev/null 2>&1; then
    realpath "$1"
  else
    printf '%s\n' "$1"
  fi
}

new_resolved="$(resolve "$new_file")"
corpus_files=()
for path in "$@"; do
  if [ -d "$path" ]; then
    while IFS= read -r file; do
      corpus_files+=("$file")
    done < <(find "$path" -type f \( -name '*.md' -o -name '*.txt' \) -print)
  elif [ -f "$path" ]; then
    corpus_files+=("$path")
  fi
done

if [ "${#corpus_files[@]}" -eq 0 ]; then
  printf 'empty corpus\n' >&2
  exit 2
fi

# Стемы, а не слова: пауз -> пауза, паузы, паузе, паузу.
watchlist="${MOTIF_WATCHLIST:-пауз|тишин|воздух|расстояни|ритм|свет|тен|глубин|пустот|лини|форм|памят|врем}"
status=0

for stem in ${watchlist//|/ }; do
  if ! grep -qiE "(^|[^[:alpha:]])${stem}[[:alpha:]]*([^[:alpha:]]|$)" "$new_file"; then
    continue
  fi

  count=0
  for file in "${corpus_files[@]}"; do
    if [ "$(resolve "$file")" = "$new_resolved" ]; then
      continue
    fi
    if grep -qiE "(^|[^[:alpha:]])${stem}[[:alpha:]]*([^[:alpha:]]|$)" "$file"; then
      count=$((count + 1))
    fi
  done

  if [ "$count" -ge 2 ]; then
    printf 'MOTIF: "%s" уже встречался в %d предыдущих текстах\n' "$stem" "$count"
    status=1
  fi
done

# Повтор content-слова внутри одного текста.
stopwords=" и что это как для все она они оно его ее их но или да не на в с по из от до за под над о об у к при через без более менее уже еще ещё только также тоже очень можно нужно есть был была были быть этот эта эти тот та те который которая которое которые чтобы потому когда если где там тут себя себе собой свой своя свои весь вся один одна одно два три может надо просто даже самый самая самое самые будет будут нет ли бы же ведь вот вон мы вы ты он она оно они я мой моя мои твой твоя твои наш наша наши ваш ваша ваши "
tmp_freq=$(mktemp)
trap 'rm -f "$tmp_freq"' EXIT

grep -oE '[[:alpha:]]{4,}' "$new_file" | awk '{print tolower($0)}' | sort | uniq -c | sort -rn > "$tmp_freq"

while read -r count word; do
  if [ "$count" -ge 5 ] && ! printf '%s' " $stopwords " | grep -q " $word "; then
    printf 'REPEAT: "%s" — %d раз в одном тексте\n' "$word" "$count"
    status=1
  fi
done < "$tmp_freq"

if [ "$status" -eq 0 ]; then
  printf 'OK: motif not found\n'
fi

exit "$status"
