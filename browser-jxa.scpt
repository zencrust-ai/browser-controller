#!/usr/bin/env osascript
(**
 * BrowserController - AppleScript Version
 * Controlla Safari/Chrome via JavaScript for Automation (JXA)
 * 
 * Usage: osascript browser-jxa.scpt navigate "https://x.com"
 *        osascript browser-jxa.scpt click "button[aria-label='Post']"
 *        osascript browser-jxa.scpt type "Hello world!"
 *        osascript browser-jxa.scpt screenshot "/tmp/screen.png"
 *)

on run argv
    if (count of argv) < 1 then
        display dialog "Usage: osascript browser-jxa.scpt <command> [args]" buttons {"OK"} default button 1
        return
    end if
    
    set command to item 1 of argv
    set args to {}
    if (count of argv) > 1 then
        set args to items 2 thru (count of argv) of argv
    end if
    
    -- Load browser helper
    tell application "System Events"
        tell process "Safari"
            -- Commands
            if command is "navigate" then
                set url to item 1 of args
                tell application "Safari" to set URL of front document to url
                return "OK: Navigated to " & url
                
            else if command is "click" then
                set selector to item 1 of args
                -- JXA for complex selectors
                set js to "document.querySelector('" & selector & "').click()"
                tell application "Safari"
                    do JavaScript js in front document
                end tell
                return "OK: Clicked " & selector
                
            else if command is "type" then
                set text to item 1 of args
                tell application "System Events" to keystroke text
                return "OK: Typed " & (length of text) & " chars"
                
            else if command is "wait" then
                set seconds to item 1 of args
                delay seconds
                return "OK: Waited " & seconds & " seconds"
                
            else if command is "screenshot" then
                set path to item 1 of args
                tell application "Safari"
                    tell front document
                        set theWindow to window 1
                    end tell
                end tell
                -- Use screencapture for simplicity
                do shell script "screencapture -t png " & quoted form of path
                return "OK: Screenshot saved to " & path
                
            else if command is "gethtml" then
                tell application "Safari"
                    set html to do JavaScript "document.documentElement.outerHTML" in front document
                end tell
                return html
                
            else if command is "post" then
                -- X/Twitter specific: Click Post button
                tell application "Safari"
                    -- Try multiple selectors for X Post button
                    try
                        do JavaScript "document.querySelector('[data-testid=\"tweetButtonInline\"]').click()" in front document
                    on error
                        try
                            do JavaScript "document.querySelector('[data-testid=\"tweetButton\"]').click()" in front document
                        on error
                            do JavaScript "document.querySelectorAll('div[role=\"button\"]').forEach(b => { if(b.innerText.includes('Post')) b.click() })" in front document
                        end try
                    end try
                end tell
                return "OK: Posted"
                
            else if command is "close" then
                tell application "Safari" to close front document
                return "OK: Closed"
                
            else
                return "ERROR: Unknown command: " & command
            end if
        end tell
    end tell
end run
