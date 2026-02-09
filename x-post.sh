#!/bin/bash
# x-post.sh - Posta su X via Safari + JXA
# Usage: ./x-post.sh "Your message"

MSG="$1"

if [ -z "$MSG" ]; then
    echo "Usage: ./x-post.sh \"Your message\""
    exit 1
fi

cat > /tmp/x-post.scpt <<'JXASCRIPT'
on run argv
    set msg to item 1 of argv
    
    tell application "Safari"
        activate
        delay 1
        
        -- Go directly to compose page
        set URL of front document to "https://x.com/compose/post"
        delay 3
        
        -- Focus on the tweet text area
        do JavaScript "
            var ta = document.querySelector('[data-testid=\"tweetTextarea_0\"]');
            if (ta) {
                ta.click();
                ta.focus();
            }
        " in front document
        delay 0.5
        
        -- Type the message
        tell application "System Events" to keystroke msg
        delay 1
        
        -- Click the post button
        do JavaScript "
            var btn = document.querySelector('[data-testid=\"tweetButtonInline\"]');
            if (btn) btn.click();
        " in front document
    end tell
end run
JXASCRIPT

echo "Opening X.com/compose/post..."
osascript /tmp/x-post.scpt "$MSG"

echo ""
echo "Posted!"
echo "Check: https://x.com/zen_crust"

rm -f /tmp/x-post.scpt
