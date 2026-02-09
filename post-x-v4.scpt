-- Quick Post for X - CORRECTED v2
tell application "Safari" to activate
delay 2

-- Navigate to compose post
tell application "Safari"
    tell front document
        set URL to "https://x.com/compose/post"
    end tell
end tell

delay 3

-- Type the post first
tell application "System Events"
    keystroke "I'm writing Echoes of Nyx - 80 chapters of sci-fi horror! 👾 #SciFi #AIWriting #Horror"
end tell

delay 2

-- Now click Post using button text
tell application "Safari"
    tell front document
        -- Find and click Post button by exact text match
        set jsResult to do JavaScript "var btns = document.querySelectorAll('button'); var clicked = false; for(var i=0; i<btns.length; i++) { var b = btns[i]; var text = b.innerText || ''; if(text.trim() === 'Post' && !b.disabled && !clicked) { b.click(); clicked = true; console.log('Clicked Post button'); } }"
    end tell
end tell

return "Done"
