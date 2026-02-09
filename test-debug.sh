#!/bin/bash
# Test script to debug where the text goes

cat > /tmp/x-test.scpt <<'JXASCRIPT'
on run argv
    set msg to item 1 of argv
    
    tell application "Safari"
        activate
        delay 1
        
        set URL of front document to "https://x.com/compose/post"
        delay 4
        
        -- Debug: what elements are there?
        set tweetArea to do JavaScript "
            var ta = document.querySelector('[data-testid=\"tweetTextarea_0\"]');
            if (ta) {
                'Found tweetTextarea_0: ' + ta.tagName + ' id=' + ta.id + ' class=' + (ta.className || 'no-class');
            } else {
                'NOT FOUND tweetTextarea_0';
            }
        " in front document
        
        -- Also check search
        set searchArea to do JavaScript "
            var search = document.querySelector('[data-testid=\"searchBox\"]');
            if (search) {
                'Found searchBox: ' + search.tagName;
            } else {
                'NOT FOUND searchBox';
            }
        " in front document
        
        return {tweetArea, searchArea}
    end tell
end run
JXASCRIPT

echo "=== DEBUG ==="
result=$(osascript /tmp/x-test.scpt "test")
echo "$result"
echo "============="

rm -f /tmp/x-test.scpt
