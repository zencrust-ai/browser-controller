#!/bin/bash
# x-post.sh - Posta su X via Safari
# Usage: ./x-post.sh "Your message"

MSG="$1"

if [ -z "$MSG" ]; then
    echo "Usage: ./x-post.sh \"Your message\""
    exit 1
fi

echo "Opening X.com..."
osascript -e "tell application \"Safari\" to activate"
osascript -e "tell application \"Safari\" to set URL of front document to \"https://x.com/compose/post\""
echo "Waiting 4 seconds..."
osascript -e "delay 4"

# Give focus to Safari window by clicking on it
echo "Focusing on page..."
osascript -e "tell application \"System Events\" to tell process \"Safari\" to click at {100, 200}"

# Now click on the tweet box using a separate script to avoid backtick issues
echo "Clicking tweet box..."
cat > /tmp/click-ta.scpt <<'ENDSCRIPT'
tell application "Safari"
    do JavaScript "document.body.click();" in front document
    delay 0.5
    
    set js to "var main = document.querySelector('[data-testid=\"primaryColumn\"]'); if (main) { var ta = main.querySelector('[data-testid=\"tweetTextarea_0\"]'); if (ta) { ta.click(); ta.focus(); } }"
    do JavaScript js in front document
end tell
ENDSCRIPT
osascript /tmp/click-ta.scpt
osascript -e "delay 0.5"

# Type the message
echo "Typing message..."
osascript -e "tell application \"System Events\" to keystroke \"$MSG\""
osascript -e "delay 1"

# Click post button
echo "Posting..."
cat > /tmp/click-btn.scpt <<'ENDSCRIPT'
tell application "Safari"
    set js to "var btn = document.querySelector('[data-testid=\"tweetButtonInline\"]'); if (btn) btn.click();"
    do JavaScript js in front document
end tell
ENDSCRIPT
osascript /tmp/click-btn.scpt

echo ""
echo "Posted!"
echo "Check: https://x.com/zen_crust"

rm -f /tmp/click-ta.scpt /tmp/click-btn.scpt
