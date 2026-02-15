#!/bin/bash
# x-post.sh - Post to X.com via AppleScript

CONTENT="$1"

if [ -z "$CONTENT" ]; then
    echo "Usage: $0 'Your tweet content'"
    exit 1
fi

osascript <<EOF
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

tell application "System Events" to keystroke "$CONTENT"
delay 0.5
tell application "System Events" to key code 53 -- Esc
delay 1

tell application "System Events"
    keystroke return using {command down}
end tell

delay 3
return "Done!"
EOF