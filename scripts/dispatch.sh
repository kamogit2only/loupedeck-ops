#!/bin/bash

COMMAND="$1"
LOG="/tmp/loupedeck_dispatch.log"

if [[ -z "$COMMAND" ]]; then
  echo "コマンド名が指定されていません" | tee -a "$LOG"
  exit 1
fi

CATEGORIES=("menu" "input" "edit" "media" "window" "util")

for category in "${CATEGORIES[@]}"; do
  SCRIPT="scripts/${category}/${COMMAND}.sh"
  if [[ -x "$SCRIPT" ]]; then
    echo "$(date): dispatch ${COMMAND} via ${category}" >> "$LOG"
    "$SCRIPT"
    exit 0
  fi
done

echo "$(date): ${COMMAND} not found" >> "$LOG"
echo "実行スクリプトが見つからないか、実行権限がありません"
exit 1
