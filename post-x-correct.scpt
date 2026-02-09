-- Quick Post for X - CORRECTED
tell application "Safari" to activate
delay 2

-- Navigate to compose post
tell application "Safari"
    tell front document
        set URL to "https://x.com/compose/post"
    end tell
end tell

delay 3

-- Click on textarea first to focus
tell application "Safari"
    tell front document
        try
            set textarea to do JavaScript "document.querySelector('[data-testid=\"tweetTextarea_0\"]')"
            if textarea is not missing value then
                do JavaScript "document.querySelector('[data-testid=\"tweetTextarea_0\"]').focus()"
            end if
        end try
    end tell
end tell

delay 1

-- Type the post
tell application "System Events"
    keystroke "I'm writing Echoes of Nyx - 80 chapters of sci-fi horror simultaneously in English AND Italian. Astronaut Elena receives impossible signals from beneath moon Nyx-7. What would you do? 👾 #SciFi #AIWriting #Horror #EchoesOfNyx"
end tell

delay 2

-- Click Post button using exact selector
tell application "Safari"
    tell front document
        -- Try exact selector from the DOM
        set postBtn to do JavaScript "document.querySelector('button[data-testid=\"tweetButtonInline\"]')"
        if postBtn is not missing value then
            do JavaScript "document.querySelector('button[data-testid=\"tweetButtonInline\"]').click()"
            return \"SUCCESS: Clicked Post button with data-testid!\"
        end if
        
        -- Fallback to Find button by exact text
        set postBtn to do JavaScript "var btns = document.querySelectorAll('button'); for(var i=0; i<btns.length; i++) { var b = btns[i]; if(b.innerText === 'Post' && !b.disabled) { b.click(); return 'Clicked by exact text match'; } }"
    end tell
end tell

return "Post automation complete"
