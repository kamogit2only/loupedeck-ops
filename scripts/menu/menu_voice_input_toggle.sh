#!/bin/bash
STATE_FILE="$HOME/.chatgpt_voice_state"
[ ! -f "$STATE_FILE" ] && echo "off" > "$STATE_FILE"
STATE=$(cat "$STATE_FILE")
osascript <<APPLESCRIPT
tell application "ChatGPT" to activate
delay 0.2
tell application "System Events"
  tell process "ChatGPT"
    click menu item "${STATE == "off" ? "音声入力を開始" : "音声入力を停止"}" of menu "編集" of menu bar 1
  end tell
end tell
APPLESCRIPT
echo $([[ "$STATE" == "off" ]] && echo "on" || echo "off") > "$STATE_FILE"
