tell application "Safari"
    activate
    delay 1
    close every document
    delay 0.5
    make new document with properties {URL:"https://x.com/notifications"}
    delay 5
    
    tell front document
        set pageTitle to do JavaScript "document.title"
        set notifCount to do JavaScript "try { document.querySelectorAll('[data-testid=\"notification\"]').length } catch(e) { return 0 }"
    end tell
    
    return "Notifications page loaded: " & pageTitle & " | Items found: " & notifCount
end tell
