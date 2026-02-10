-- follow-user.scpt - Follow a user on X.com
-- Usage: osascript follow-user.scpt <username>

on run argv
    set username to item 1 of argv
    
    tell application "Safari"
        activate
        delay 1
        
        -- Open user profile
        set URL of front document to "https://x.com/" & username
        delay 5
    end tell
    
    tell application "Safari"
        delay 2
        tell front document
            try
                do JavaScript "
                    var btn = document.querySelector('[data-testid=\"UserFollowButton\"]') ||
                              document.querySelector('[data-testid=\"followButton\"]') ||
                              document.querySelector('[role=\"button\"][tabindex=\"0\"]:not([aria-pressed=\"true\"])');
                    if (btn) {
                        btn.click();
                        'Followed!';
                    } else {
                        'Button not found or already following';
                    }
                "
            on error
                return "Error finding follow button"
            end try
        end tell
    end tell
    
    delay 2
    return "Follow attempted!"
end run
