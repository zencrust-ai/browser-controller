#!/usr/bin/env osascript
-- BrowserController for X posting

on run argv
    if (count of argv) < 1 then
        return "Usage: osascript browser.scpt command [args]"
    end if
    
    set command to item 1 of argv
    
    tell application "Safari"
        activate
        
        if command is "navigate" then
            if (count of argv) < 2 then return "Error: Missing URL"
            set url to item 2 of argv
            if (exists front document) then
                set URL of front document to url
            else
                make new document with properties {URL:url}
            end if
            return "OK: " & url
            
        else if command is "wait" then
            if (count of argv) < 2 then return "Error: Missing seconds"
            set secs to item 2 of argv as number
            delay secs
            return "OK: Waited " & secs & "s"
            
        else if command is "type" then
            if (count of argv) < 2 then return "Error: Missing text"
            set text to item 2 of argv
            
            -- Replace | with actual newlines for multiline
            set oldDelim to AppleScript's text item delimiters
            set AppleScript's text item delimiters to "|"
            set textItems to every text item of text
            set AppleScript's text item delimiters to linefeed
            set text to textItems as text
            set AppleScript's text item delimiters to oldDelim
            
            tell application "System Events" to keystroke text
            return "OK: Typed " & (length of text) & " chars"
            
        else if command is "typefile" then
            -- Read text from file
            if (count of argv) < 2 then return "Error: Missing file path"
            set filePath to item 2 of argv
            try
                set text to do shell script "cat " & quoted form of filePath
                do shell script "rm -f " & quoted form of filePath
            on error
                return "Error: Cannot read file"
            end try
            
            tell application "System Events" to keystroke text
            return "OK: Typed " & (length of text) & " chars from file"
            
        else if command is "post" then
            tell front document
                do JavaScript "try { var btn = document.querySelector('[data-testid=\"tweetButtonInline\"]'); if(btn) btn.click(); } catch(e) { }"
            end tell
            return "OK: Post clicked"
            
        else if command is "click" then
            if (count of argv) < 2 then return "Error: Missing selector"
            set selector to item 2 of argv
            tell front document
                do JavaScript "try { var el = document.querySelector('" & selector & "'); if(el) el.click(); } catch(e) { console.log('Click error: ' + e); }"
            end tell
            return "OK: Clicked " & selector
            
        else if command is "geturl" then
            try
                return URL of front document as text
            on error
                return "No document"
            end try
            
        else
            return "Error: Unknown command: " & command
        end if
    end tell
end run
