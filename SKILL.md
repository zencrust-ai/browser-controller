# BrowserController Skill

Controlla il browser (Safari) su macOS via **AppleScript/JXA**.

## Due Versioni

### 1. AppleScript (Preferita per macOS)
```
browser.scpt          - Script nativo macOS
browser-safari.js     - Wrapper Node.js
```

### 2. Puppeteer (Alternativa)
```
browser-ctrl.js        - Controller Puppeteer
index.js              - Entry point
package.json          - Dependencies
```

## Installazione (AppleScript - già pronto!)

Nessuna installazione necessaria. AppleScript è nativo su macOS.

## Utilizzo AppleScript

```bash
# Apri URL
osascript browser.scpt navigate "https://x.com/zen_crust"

# Clicca elemento
osascript browser.scpt click "[data-testid='tweetTextarea_0']"

# Scrivi testo
osascript browser.scpt type "Ciao da Safari!"

# Aspetta (secondi)
osascript browser.scpt wait 2

# Clicca Post (X)
osavascript browser.scpt post

# Ottieni URL corrente
osascript browser.scpt geturl

# Ottieni titolo pagina
osascript browser.scpt title

# Screenshot
osascript browser.scpt screenshot "/tmp/x-post.png"
```

## Wrapper Node.js

```bash
node browser-safari.js navigate "https://x.com"
node browser-safari.js type "Test post!"
node browser-safari.js wait 1000
node browser-safari.js post
```

## Esempio Completo: Post su X

```bash
#!/bin/bash
# x-post.sh - Script completo per postare su X

cd ~/.openclaw/skills/browser-controller

echo "🚀 Apertura X..."
osascript browser.scpt navigate "https://x.com/zen_crust"

echo "⏳ Attendo caricamento (3s)..."
osascript browser.scpt wait 3

echo "✍️  Scrivo il post..."
osascript browser.scpt type "I'm writing Echoes of Nyx - 80 chapters of sci-fi horror! 👾"

echo "⏳ Aspetto (1s)..."
osascript browser.scpt wait 1

echo "📤 Publico..."
osascript browser.scpt post

echo "✅ Fatto!"
```

## Node.js Example

```javascript
// post-to-x.js
const { exec } = require('child_process');
const path = require('path');

const SCRIPT = path.join(__dirname, 'browser.scpt');

function run(cmd, arg) {
    const fullCmd = arg 
        ? `osascript "${SCRIPT}" ${cmd} "${arg}"`
        : `osascript "${SCRIPT}" ${cmd}`;
    
    return require('child_process').execSync(fullCmd, { encoding: 'utf8' }).trim();
}

async function postToX(text) {
    console.log('🚀 Navigando a X...');
    run('navigate', 'https://x.com/zen_crust');
    
    await new Promise(r => setTimeout(r, 3000));
    console.log('✅ Caricato');
    
    console.log('✍️  Scrivendo post...');
    run('type', text);
    
    await new Promise(r => setTimeout(r, 1000));
    console.log('📤 Pubblicando...');
    run('post');
    
    console.log('✅ Post pubblicato!');
}

postToX("Test da BrowserController! 🚀");
```

## Selettori CSS per X (Twitter)

| Elemento | Selettore |
|----------|-----------|
| Textarea post | `[data-testid='tweetTextarea_0']` |
| Pulsante Post | `[data-testid='tweetButtonInline']` |
| Pulsante Post alt | `[data-testid='tweetButton']` |
| Profile menu | `[data-testid='userActions']` |

## Note

- **AppleScript** è più veloce e stabile su macOS
- Non richiede dipendenze esterne
- Funziona con Safari (browser di default)
- JXA (JavaScript for Automation) per selettori CSS complessi

## Troubleshooting

### "Safari non risponde"
```bash
# Riapri Safari
osascript -e 'tell application "Safari" to activate'
```

### "Permission denied" su screencapture
```bash
# Dai permessi screenshot in System Preferences > Security & Privacy
```

### JavaScript disabilitato
```bash
# Safari > Preferences > Advanced > Show Develop menu
# Develop > Enable JavaScript
```
