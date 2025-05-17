#!/bin/bash
# command: start_dictation
# description: 音声入力を開始

# command: start_dictation

osascript <<APPLESCRIPT
tell application "System Events"
	set frontApp to name of first application process whose frontmost is true
	tell process frontApp
		click menu item "音声入力を開始" of menu 1 of menu bar item "編集" of menu bar 1
	end tell
end tell
APPLESCRIPT
