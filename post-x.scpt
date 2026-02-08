-- Quick Post for X
tell application "Safari" to activate
delay 2

-- Click on the post textarea using JavaScript
tell application "Safari"
    tell front document
        try
            do JavaScript "var a = document.querySelector('[data-testid=\"tweetTextarea_0\"]'); if(a) a.click();"
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

delay 1

-- Click Post button
tell application "Safari"
    tell front document
        try
            do JavaScript "var b = document.querySelector('[data-testid=\"tweetButtonInline\"]'); if(b) b.click();"
        on error
            return "Error clicking post button"
        end try
    end tell
end tell

return "Post published!"
