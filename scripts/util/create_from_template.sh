#!/bin/bash

# 必須引数：コマンド名と説明
CMD="$1"
DESC="$2"
CATEGORY="$3"

if [[ -z "$CMD" || -z "$DESC" || -z "$CATEGORY" ]]; then
  echo "使い方: $0 <command_name> <description> <category>"
  echo "例: $0 focus_mode \"集中モード切替\" menu"
  exit 1
fi

# ファイルパスとYAML
TARGET="scripts/${CATEGORY}/${CMD}.sh"
YAML_FILE="docs/promptbook.yaml"

# 既に存在するかチェック
if [[ -f "$TARGET" ]]; then
  echo "既に存在します: $TARGET"
  exit 1
fi

# スクリプト生成
mkdir -p "scripts/${CATEGORY}"
cat <<SCRIPT > "$TARGET"
#!/bin/bash
# command: $CMD
# description: $DESC

echo "[INFO] '${CMD}' 実行処理（未実装）"
SCRIPT

chmod +x "$TARGET"
echo "✅ スクリプト作成: $TARGET"

# YAML に追記（末尾に追加）
yq eval ".${CATEGORY} += [{\"command\": \"${CMD}\", \"description\": \"${DESC}\"}]" -i "$YAML_FILE"
echo "✅ promptbook.yaml に追記"

