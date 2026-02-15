#!/bin/bash
# x-post.sh - Post to X.com using AppleScript
# Usage: ./x-post.sh "Your tweet content"

if [ $# -eq 0 ]; then
    echo "Usage: $0 'Your tweet content'"
    exit 1
fi

TWEET="$1"
SCRIPT_DIR="$(dirname "$0")"

osascript "$SCRIPT_DIR/post-real.scpt" "$TWEET"