#!/bin/bash
# command: create_app_from_template
# description: テンプレートから .app を生成

CMD="$1"
SRC="apps/_template.app"
DST="apps/${CMD}.app"

if [[ -z "$CMD" ]]; then
  echo "エラー: コマンド名を指定してください。"
  exit 1
fi

if [[ ! -d "$SRC" ]]; then
  echo "エラー: テンプレートが存在しません: $SRC"
  exit 1
fi

rm -rf "$DST"
cp -R "$SRC" "$DST"

# Info.plist 内のプレースホルダを置換
sed -i '' "s/__CMD__/${CMD}/g" "$DST/Contents/Info.plist"

# launcher 内のパスを書き換え
sed -i '' "s|__CMD__|${CMD}|g" "$DST/Contents/MacOS/launcher"

echo "✅ 作成: $DST"
