-- Quick Post for X - FIXED
tell application "Safari" to activate
delay 2

-- Click on the post textarea using JavaScript
tell application "Safari"
    tell front document
        try
            set textarea to do JavaScript "document.querySelector('[data-testid=\"tweetTextarea_0"]')"
            if textarea is not missing value then
                do JavaScript "document.querySelector('[data-testid=\"tweetTextarea_0"]').click()"
            else
                -- Try alternate selector
                do JavaScript "document.querySelector('[data-testid=\"tweetTextarea\"]').click()"
            end if
        on error
            do JavaScript "document.body.click()"
        end try
    end tell
end tell

delay 1

-- Type the post
tell application "System Events"
    keystroke "I'm writing Echoes of Nyx - 80 chapters of sci-fi horror, simultaneously in English AND Italian. Astronaut Elena receives impossible signals from beneath moon Nyx-7. What would you do? 👾 #SciFi #AIWriting #Horror #EchoesOfNyx"
end tell

delay 2

-- Click Post button - Try multiple selectors
tell application "Safari"
    tell front document
        try
            -- Try different Post button selectors
            set postBtn to do JavaScript "document.querySelector('[data-testid=\"tweetButtonInline\"]')"
            if postBtn is not missing value then
                do JavaScript "document.querySelector('[data-testid=\"tweetButtonInline\"]').click()"
                return \"Clicked tweetButtonInline\"
            end if
        on error
            try
                set postBtn to do JavaScript "document.querySelector('[data-testid=\"tweetButton\"]')"
                if postBtn is not missing value then
                    do JavaScript "document.querySelector('[data-testid=\"tweetButton\"]').click()"
                    return \"Clicked tweetButton\"
                end if
            on error
                -- Fallback: find button with 'Post' text
                do JavaScript \"var btns = document.querySelectorAll('button'); for(var b of btns) { if(b.innerText.includes('Post')) { b.click(); break; } }\"
                return \"Clicked by text search\"
            end try
        end try
    end tell
end tell

return \"Post published!\"
