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
            tell application "System Events" to keystroke text
            return "OK: Typed " & (length of text) & " chars"
            
        else if command is "post" then
            tell front document
                do JavaScript "try { var btn = document.querySelector('[data-testid=\"tweetButtonInline\"]'); if(btn) btn.click(); } catch(e) { }"
            end tell
            return "OK: Post clicked"
            
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
