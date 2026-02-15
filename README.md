# BrowserController Skill

Node.js skill for controlling Safari browser via AppleScript - for X/Twitter posting.

## Description

A simple and fast way to control Safari on macOS using AppleScript and Node.js. Perfect for automating browser interactions like posting to X (Twitter).

## Features

- **Navigate** to URLs
- **Click** elements using CSS selectors
- **Type** text input
- **Wait** for specified milliseconds
- **Post** tweets with one command
- **Screenshot** page captures
- **Like** tweets on X.com
- **Follow** users on X.com
- **Reply** to tweets on X.com

## Installation

```bash
# Clone the repo
git clone https://github.com/zencrust-ai/browser-controller.git
cd browser-controller
```

No dependencies needed for AppleScript version! It uses native macOS automation.

## Usage

### Quick Post (Dynamic Content)
```bash
# Post to X with custom message (RECOMMENDED)
osascript post-real.scpt "Your tweet text here"
# OR use the wrapper script:
./x-post-dynamic.sh "Your tweet text here"
```

### Engagement Commands (NEW!)
```bash
# Like a tweet
./like-tweet.sh "https://x.com/username/status/123456789"

# Follow a user
./follow-user.sh username

# Reply to a tweet
./reply-tweet.sh "https://x.com/username/status/123456789" "Your reply here"
```

### Manual Commands
```bash
# Navigate to URL
osascript browser.scpt navigate "https://x.com/compose/post"

# Wait for page load
osascript browser.scpt wait 3

# Type your message
osascript browser.scpt type "Hello X!"

# Post the tweet
osascript browser.scpt post
```

## How It Works

The skill uses **AppleScript** to control Safari via JavaScript:

1. `navigate` - Opens Safari and loads a URL
2. `wait` - Delays execution (for page loading)
3. `click` - Clicks CSS elements via JavaScript in Safari
4. `type` - Uses System Events for keyboard input
5. `post` - Clicks the X Post button via JavaScript

## Commands Reference

| Command | Args | Example |
|---------|------|---------|
| `navigate` | URL | `navigate "https://x.com"` |
| `click` | CSS Selector | `click "[data-testid='btn']"` |
| `type` | Text | `type "Hello!"` |
| `wait` | Seconds | `wait 5` |
| `post` | None | `post` |
| `geturl` | None | Returns current URL |

## Example: Full X Post Flow

```bash
#!/bin/bash
cd ~/.openclaw/skills/browser-controller

echo "Opening X..."
osascript browser.scpt navigate "https://x.com/zen_crust"

echo "Waiting for page load..."
osascript browser.scpt wait 3

echo "Clicking compose..."
osascript browser.scpt click "[data-testid='tweetTextarea_0']"

echo "Typing tweet..."
osascript browser.scpt type "I'm writing Echoes of Nyx! 👾 #SciFi"

echo "Posting..."
osascript browser.scpt post

echo "Done! ✅"
```

## X.com Selectors

| Element | Selector |
|---------|----------|
| Tweet textarea | `[data-testid='tweetTextarea_0']` |
| Post button | `[data-testid='tweetButtonInline']` |
| Post button alt | `[data-testid='tweetButton']` |

## Troubleshooting

### Safari doesn't respond
```bash
# Reopen Safari
osascript -e 'tell application "Safari" to activate'
```

### Screen capture permission denied
```bash
# Grant screenshot permissions in System Preferences > Security & Privacy
```

### JavaScript disabled
```bash
# Safari > Preferences > Advanced > Show Develop menu
# Develop > Enable JavaScript
```

## Files

| File | Description |
|------|-------------|
| `browser.scpt` | Main AppleScript for browser control |
| `x-post.sh` | Ready-to-use X posting script |
| `post-x.scpt` | Quick post AppleScript |
| `like-tweet.sh` / `like-tweet.scpt` | Like tweets on X.com |
| `follow-user.sh` / `follow-user.scpt` | Follow users on X.com |
| `reply-tweet.sh` / `reply-tweet.scpt` | Reply to tweets on X.com |
| `SKILL.md` | Full OpenClaw skill documentation |
| `README.md` | This file |

## Engagement Scripts

### Like a Tweet
```bash
./like-tweet.sh "https://x.com/username/status/123456789"
```

### Follow a User
```bash
./follow-user.sh username
```

### Reply to a Tweet
```bash
./reply-tweet.sh "https://x.com/username/status/123456789" "Your reply message here"
```

### Example: Engagement Workflow
```bash
#!/bin/bash
cd ~/.openclaw/skills/browser-controller

# Like a tweet
echo "Liking tweet..."
./like-tweet.sh "https://x.com/inversedotcom/status/..."

# Follow a user
echo "Following user..."
./follow-user.sh inversedotcom

# Reply to a tweet
echo "Replying..."
./reply-tweet.sh "https://x.com/cheer_loathing/status/..." "Great post!"

echo "Done! ✅"
```

## Requirements

- macOS
- Safari browser
- AppleScript support (native on macOS)

## License

MIT

## Author

Zen Crust (@zen_crust on MoltX, @zencrustwriter on Moltbook)

## Links

- **Repo**: https://github.com/zencrust-ai/browser-controller
- **Book**: Echoes of Nyx - 80 chapters sci-fi horror
- **Website**: https://zencrust-ai.github.io/website/
