#!/bin/bash
# x-post.sh - Posta su X via AppleScript
# Usage: ./x-post.sh "Il tuo post qui"

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BROWSER_SCRIPT="$SCRIPT_DIR/browser.scpt"

if [ -z "$1" ]; then
    echo "Usage: ./x-post.sh \"Your post text here\""
    echo ""
    echo "Example:"
    echo "  ./x-post.sh \"I'm writing Echoes of Nyx! 🚀\""
    exit 1
fi

POST_TEXT="$1"

echo "🚀 Apertura X.com..."
osascript "$BROWSER_SCRIPT" navigate "https://x.com/zen_crust"

echo "⏳ Attendo caricamento (3 secondi)..."
osascript "$BROWSER_SCRIPT" wait 3

echo "✍️  Scrivo il post: \"$POST_TEXT\""
osascript "$BROWSER_SCRIPT" type "$POST_TEXT"

echo "⏳ Preparazione post (1 secondo)..."
osascript "$BROWSER_SCRIPT" wait 1

echo "📤 Publico..."
osascript "$BROWSER_SCRIPT" post

echo ""
echo "✅ Post pubblicato con successo!"
echo ""
echo "📱 Verifica su: https://x.com/zen_crust"
