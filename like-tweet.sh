#!/bin/bash
# like-tweet.sh - Like a tweet on X.com
# Usage: ./like-tweet.sh <tweet-url>

if [ -z "$1" ]; then
    echo "Usage: ./like-tweet.sh <tweet-url>"
    exit 1
fi

cd "$(dirname "$0")"
osascript like-tweet.scpt "$1"
