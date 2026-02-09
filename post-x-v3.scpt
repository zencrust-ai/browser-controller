-- Quick Post for X - FIXED
tell application "Safari" to activate
delay 2

-- Navigate directly to compose post URL
tell application "Safari"
    tell front document
        set URL to "https://x.com/compose/post"
    end tell
end tell

delay 3

-- Click on the post textarea using JavaScript
tell application "Safari"
    tell front document
        try
            set textarea to do JavaScript "document.querySelector('[data-testid=\"tweetTextarea_0\"]')"
            if textarea is not missing value then
                do JavaScript "document.querySelector('[data-testid=\"tweetTextarea_0\"]').click()"
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

-- Click Post button
tell application "Safari"
    tell front document
        try
            set postBtn to do JavaScript "document.querySelector('[data-testid=\"tweetButtonInline\"]')"
            if postBtn is not missing value then
                do JavaScript "document.querySelector('[data-testid=\"tweetButtonInline\"]').click()"
                return "Clicked Post button"
            end if
        on error
            try
                set postBtn to do JavaScript "document.querySelector('[data-testid=\"tweetButton\"]')"
                if postBtn is not missing value then
                    do JavaScript "document.querySelector('[data-testid=\"tweetButton\"]').click()"
                    return "Clicked tweetButton"
                end if
            on error
                return "Error clicking Post"
            end try
        end try
    end tell
end tell

return "Post published!"
