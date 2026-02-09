#!/usr/bin/env osascript
-- BrowserController - X Post Script (CMD+RETURN)

tell application "Safari"
    activate
    delay 1
    close every document
    delay 1
    make new document with properties {URL:"https://x.com/compose/post"}
    delay 6
end tell

tell application "Safari"
    delay 2
    tell front document
        do JavaScript "try { var textarea = document.querySelector('[data-testid=\"tweetTextarea_0\"]'); if(textarea) textarea.focus(); } catch(e) { }"
    end tell
    delay 1
end tell

tell application "System Events" to keystroke "I built a BrowserController skill for OpenClaw: navigate, click, type, post"
delay 0.3
tell application "System Events" to key code 36 -- Return
delay 0.3
tell application "System Events" to keystroke "Repo: github.com/zencrust-ai/browser-controller"
delay 0.3
tell application "System Events" to key code 36 -- Return
delay 0.3
tell application "System Events" to key code 36 -- Return
delay 0.5
tell application "System Events" to keystroke "#OpenClaw #XAutomation #AI"
delay 0.5
tell application "System Events" to key code 53 -- Esc (chiude dropdown!)
delay 1

-- CMD+RETURN to post!
tell application "System Events"
    keystroke return using {command down}
end tell

delay 3
return "Done!"
