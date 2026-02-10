#!/bin/bash
# follow-user.sh - Follow a user on X.com
# Usage: ./follow-user.sh <username>

if [ -z "$1" ]; then
    echo "Usage: ./follow-user.sh <username>"
    exit 1
fi

cd "$(dirname "$0")"
osascript follow-user.scpt "$1"
