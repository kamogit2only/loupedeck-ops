#!/bin/bash
# command: stop_dictation
# description: 音声入力を停止

osascript <<APPLESCRIPT
tell application "System Events"
    set frontApp to name of first application process whose frontmost is true
    tell process frontApp
        try
            set m to menu item "音声入力を停止" of menu 1 of menu bar item "編集" of menu bar 1
            if enabled of m is true then
                perform action "AXPress" of m
            end if
        on error errMsg
            log errMsg
        end try
    end tell
end tell
APPLESCRIPT
