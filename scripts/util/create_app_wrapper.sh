#!/bin/bash
# command: create_app_wrapper
# description: .app ラッパーを生成する


APP_ROOT="apps"
DISPATCH_PATH="$HOME/loupedeck-ops/scripts/dispatch.sh"
YAML_FILE="docs/promptbook.yaml"

mkdir -p "$APP_ROOT"

yq eval 'to_entries[] | .value[] | .command' "$YAML_FILE" | while read -r CMD; do
  [[ -z "$CMD" ]] && continue

  APP_NAME="${CMD}.app"
  APP_DIR="${APP_ROOT}/${APP_NAME}"
  EXECUTABLE="${APP_DIR}/Contents/MacOS/${CMD}"

  mkdir -p "$(dirname "$EXECUTABLE")"

  cat <<SCRIPT > "$EXECUTABLE"
exec "$DISPATCH_PATH" $CMD
SCRIPT

  chmod +x "$EXECUTABLE"
  echo "✅ 作成: $APP_NAME"
done
