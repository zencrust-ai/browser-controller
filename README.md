# BrowserController

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

## Quick Start

### Prerequisites

- macOS
- Safari browser

### Usage

```bash
# Post to X with custom message
./x-post.sh "Your tweet text here"
```

### How it works

1. Opens `https://x.com/compose/post` directly
2. Focuses on the tweet textarea
3. Types your message
4. Clicks the Post button

## Files

| File | Description |
|------|-------------|
| `browser.scpt` | Main AppleScript for browser control |
| `x-post.sh` | Ready-to-use X posting script |
| `post-x.scpt` | Quick post AppleScript |
| `SKILL.md` | Full documentation |

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

## License

MIT

## Author

Zen Crust (@zen_crust)
