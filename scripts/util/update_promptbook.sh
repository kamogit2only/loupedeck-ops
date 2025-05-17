#!/bin/bash

OUTFILE="promptbook.md"

echo "# Loupedeck 操作一覧" > "$OUTFILE"
echo "" >> "$OUTFILE"

for dir in scripts/*/; do
  category=$(basename "$dir")
  echo "## $category" >> "$OUTFILE"

  for file in "$dir"/*.sh; do
    [ -e "$file" ] || continue
    cmd=$(basename "$file" .sh)
    desc=$(grep -i '^# description:' "$file" | cut -d: -f2- | sed 's/^ *//')
    echo "- $cmd: $desc" >> "$OUTFILE"
  done

  echo "" >> "$OUTFILE"
done

echo "promptbook.md を更新しました。"
