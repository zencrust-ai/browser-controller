#!/bin/bash
# GitHub Publisher for BrowserController
# Usage: ./publish-github.sh [github_token]

set -e

REPO_DIR="/Users/zencrust/.openclaw/skkills/browser-controller"
REPO_NAME="browser-controller"
DESCRIPTION="Node.js skill for controlling Safari via AppleScript - for X/Twitter posting"

TOKEN="${1:-$GITHUB_TOKEN}"

echo "🚀 Publishing BrowserController to GitHub..."
echo ""

if [ -z "$TOKEN" ]; then
    echo "❌ GitHub token non trovato!"
    echo ""
    echo "OPZIONE 1 - Usa un token esistente:"
    echo "  ./publish-github.sh YOUR_GITHUB_TOKEN"
    echo ""
    echo "OPZIONE 2 - Crea un token su GitHub:"
    echo "  1. Vai su: https://github.com/settings/tokens"
    echo "  2. Crea nuovo token (classic) con permessi 'repo'"
    echo "  3. Copia il token e usa: ./publish-github.sh ghp_xxxx..."
    echo ""
    exit 1
fi

echo "📦 Configurando remote..."
cd "$REPO_DIR"

# Add remote if not exists
if ! git remote get-url origin &>/dev/null; then
    git remote add origin "https://github.com/\$(gh api user --jq '.login' 2>/dev/null || echo 'username')/$REPO_NAME.git"
    echo "✅ Remote added"
else
    echo "✅ Remote already configured"
fi

echo ""
echo "🔗 Linking repository..."
# Create repo via GitHub API
RESPONSE=$(curl -s -X POST "https://api.github.com/user/repos" \
    -H "Authorization: token $TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    -d "{\"name\":\"$REPO_NAME\",\"description\":\"$DESCRIPTION\",\"private\":false}")

if echo "$RESPONSE" | grep -q '"id"'; then
    echo "✅ Repository created on GitHub!"
else
    echo "⚠️  Repository might already exist or error occurred"
    echo "$RESPONSE" | head -5
fi

echo ""
echo "📤 Pushing to GitHub..."
git branch -M main
git push -u origin main

echo ""
echo "🎉 Done!"
echo "📱 View your repo:"
echo "   https://github.com/\$(gh api user --jq '.login' 2>/dev/null || echo 'username')/$REPO_NAME"
