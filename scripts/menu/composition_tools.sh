#!/bin/bash
# command: composition_tools
# description: 作文ツールを表示

# command: composition_tools

osascript <<APPLESCRIPT
tell application "System Events"
	set frontApp to name of first application process whose frontmost is true
end tell

tell application frontApp to activate

delay 0.3

tell application "System Events"
	tell process frontApp
		set m to menu item "作文ツールを表示" of menu 1 of menu item "作文ツール" of menu 1 of menu bar item "編集" of menu bar 1
		perform action "AXPress" of m
	end tell
end tell
APPLESCRIPT
