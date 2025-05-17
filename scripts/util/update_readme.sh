#!/bin/bash

YAML_FILE="docs/promptbook.yaml"
README_FILE="README.md"

echo "# Loupedeck操作スクリプト集" > "$README_FILE"
echo "" >> "$README_FILE"
echo "このリポジトリは Loupedeck 用のカスタム操作スクリプトを集約・整理し、" >> "$README_FILE"
echo "YAMLベースで定義・Markdownで表示・.app化によるLoupedeck連携を実現しています。" >> "$README_FILE"
echo "" >> "$README_FILE"
echo "## 利用可能な操作一覧（自動生成）" >> "$README_FILE"
echo "" >> "$README_FILE"

# 各カテゴリを順に処理
yq eval 'keys | .[]' "$YAML_FILE" | while read -r category; do
  echo "### $category" >> "$README_FILE"

  count=$(yq eval ".${category} | length" "$YAML_FILE")
  if [ "$count" -eq 0 ]; then
    echo "_（このカテゴリにはまだ定義がありません）_" >> "$README_FILE"
    echo "" >> "$README_FILE"
    continue
  fi

  echo "| コマンド | 説明 |" >> "$README_FILE"
  echo "|----------|------|" >> "$README_FILE"

  for i in $(seq 0 $((count - 1))); do
    cmd=$(yq eval ".${category}[${i}].command" "$YAML_FILE")
    desc=$(yq eval ".${category}[${i}].description" "$YAML_FILE")
    echo "| \`$cmd\` | $desc |" >> "$README_FILE"
  done

  echo "" >> "$README_FILE"
done

echo "README.md を更新しました。"
