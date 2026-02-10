#!/bin/bash
# reply-tweet.sh - Reply to a tweet on X.com
# Usage: ./reply-tweet.sh <tweet-url> "<message>"

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: ./reply-tweet.sh <tweet-url> \"<message>\""
    exit 1
fi

cd "$(dirname "$0")"
osascript reply-tweet.scpt "$1" "$2"
