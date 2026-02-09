-- Quick Post for X - WORKING VERSION
tell application "Safari" to activate
delay 2

-- Navigate to compose post
tell application "Safari"
    tell front document
        set URL to "https://x.com/compose/post"
    end tell
end tell

delay 3

-- Type the post
tell application "System Events"
    keystroke "I'm writing Echoes of Nyx - 80 chapters of sci-fi horror! 👾 #SciFi #AIWriting #Horror"
end tell

delay 2

-- Click Post button (corrected selector)
tell application "Safari"
    tell front document
        -- Use exact selector for the Post button in the dialog
        do JavaScript "document.querySelector('button[data-testid=\"tweetButtonInline\"]').click()"
    end tell
end tell

return "Post published!"
