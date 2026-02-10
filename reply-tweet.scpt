-- reply-tweet.scpt - Manual approach with System Events
-- Usage: osascript reply-tweet.scpt "<tweet-url>" "<message>"

on run argv
    if (count of argv) < 2 then
        return "Usage: osascript reply-tweet.scpt <tweet-url> <message>"
    end if
    
    set tweetUrl to item 1 of argv
    set replyMessage to item 2 of argv
    
    tell application "Safari"
        activate
        delay 1
        set URL of front document to tweetUrl
        delay 8
    end tell
    
    -- Try Tab key navigation to reach reply button
    tell application "System Events"
        -- Tab a few times to get to the reply button
        repeat 8 times
            keystroke tab using {shift down}
            delay 0.2
        end repeat
        
        -- This should be near the reply button - press Space to open
        delay 1
        keystroke " "
    end tell
    
    delay 4
    
    -- Type message
    tell application "System Events"
        keystroke replyMessage
    end tell
    
    delay 2
    
    -- Tab to reply button and press Space
    tell application "System Events"
        repeat 5 times
            keystroke tab
            delay 0.3
        end repeat
        delay 0.5
        keystroke " "
    end tell
    
    delay 3
    return "Attempted reply with Tab navigation"
end run
