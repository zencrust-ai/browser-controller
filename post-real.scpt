-- post-real.scpt - Dynamic content version
-- Usage: osascript post-real.scpt "Your tweet content here"

on run argv
    set tweetContent to item 1 of argv
    
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
    
    tell application "System Events" to keystroke tweetContent
    delay 0.5
    tell application "System Events" to key code 53 -- Esc
    delay 1
    
    tell application "System Events"
        keystroke return using {command down}
    end tell
    
    delay 3
    return "Done!"
end run
