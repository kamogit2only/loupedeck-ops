#!/bin/bash

YAML_FILE="docs/promptbook.yaml"
COMMAND="$1"

if [[ -z "$COMMAND" || "$COMMAND" == "--help" ]]; then
  echo "使用可能なコマンド一覧:"
  yq eval 'to_entries[] | .key as $cat | .value[] | "- \(.command): \(.description) [カテゴリ: \($cat)]"' "$YAML_FILE"
  exit 0
fi

# 対応スクリプトを探す（サブフォルダ問わず）
SCRIPT_PATH=$(find scripts -type f -name "${COMMAND}.sh" | head -n 1)

if [[ -z "$SCRIPT_PATH" ]]; then
  echo "エラー: コマンド '${COMMAND}' は定義されていないか、スクリプトが存在しません。"
  exit 1
fi

# 実行権限がなければ付与
chmod +x "$SCRIPT_PATH"

# 実行
"$SCRIPT_PATH"
