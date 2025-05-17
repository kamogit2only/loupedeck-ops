#!/bin/bash
# command: update_promptbook
# description: promptbook.md を自動更新


YAML_FILE="docs/promptbook.yaml"
MD_FILE="promptbook.md"

# 初期化
echo "# Loupedeck 操作一覧" > "$MD_FILE"
echo "" >> "$MD_FILE"

# 各カテゴリ（例：menu, ops, util, ...）を順に処理
yq eval 'keys | .[]' "$YAML_FILE" | while read -r category; do
  echo "## $category" >> "$MD_FILE"

  # カテゴリ内の配列の長さを取得（空配列対応のため）
  count=$(yq eval ".${category} | length" "$YAML_FILE")

  if [ "$count" -eq 0 ]; then
    echo "" >> "$MD_FILE"
    continue
  fi

  for i in $(seq 0 $((count - 1))); do
    cmd=$(yq eval ".${category}[${i}].command" "$YAML_FILE")
    desc=$(yq eval ".${category}[${i}].description" "$YAML_FILE")
    echo "- $cmd: $desc" >> "$MD_FILE"
  done

  echo "" >> "$MD_FILE"
done

echo "promptbook.md を更新しました。"
