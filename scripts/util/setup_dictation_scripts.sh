#!/bin/bash

mkdir -p scripts/menu

cat <<'SCRIPT' > scripts/menu/start_dictation.sh
#!/bin/bash
osascript <<APPLESCRIPT
tell application "System Events"
	set frontApp to name of first application process whose frontmost is true
	tell process frontApp
		click menu item "音声入力を開始" of menu 1 of menu bar item "編集" of menu bar 1
	end tell
end tell
APPLESCRIPT
SCRIPT

cat <<'SCRIPT' > scripts/menu/stop_dictation.sh
#!/bin/bash
osascript <<APPLESCRIPT
tell application "System Events"
	set frontApp to name of first application process whose frontmost is true
	tell process frontApp
		click menu item "音声入力を停止" of menu 1 of menu bar item "編集" of menu bar 1
	end tell
end tell
APPLESCRIPT
SCRIPT

chmod +x scripts/menu/start_dictation.sh
chmod +x scripts/menu/stop_dictation.sh

echo "✅ スクリプト作成完了。Loupedeckには以下のパスを設定してください："
echo "  $(realpath scripts/menu/start_dictation.sh)"
echo "  $(realpath scripts/menu/stop_dictation.sh)"
