-- like-tweet.scpt - Like a tweet on X.com
-- Usage: osascript like-tweet.scpt <tweet-url>

on run argv
    set tweetUrl to item 1 of argv
    
    tell application "Safari"
        activate
        delay 1
        
        -- Open tweet
        set URL of front document to tweetUrl
        delay 5
        
        -- Wait for page to load
    end tell
    
    tell application "Safari"
        delay 2
        tell front document
            -- Try multiple selectors for the like button
            try
                do JavaScript "
                    var btn = document.querySelector('[data-testid=\"like\"]') || 
                              document.querySelector('[aria-label*=\"Like\"]') ||
                              document.querySelector('.r-1yz5n4 .r-1p0dtai svg');
                    if (btn) {
                        btn.click();
                        'Liked!';
                    } else {
                        'Button not found';
                    }
                "
            on error
                return "Error finding like button"
            end try
        end tell
    end tell
    
    delay 2
    return "Like attempted!"
end run
