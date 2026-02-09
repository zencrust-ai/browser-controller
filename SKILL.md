# BrowserController Skill

Controlla il browser (Safari) su macOS via **AppleScript/JXA** per postare su X (Twitter).

## Files

| File | Descrizione |
|------|-------------|
| `browser.scpt` | Script nativo AppleScript per browser control |
| `post-real.scpt` | **Script PRONTO ALL'USO** per postare su X ✅ |
| `x-post.sh` | Wrapper shell per postare rapidamente |
| `SKILL.md` | Questa documentazione |

## Installazione

```bash
# Clone il repo
git clone https://github.com/zencrust-ai/browser-controller.git
cd browser-controller
```

**Nessuna dipendenza necessaria!** AppleScript è nativo su macOS.

## 🚀 Quick Start: Postare su X

### Metodo 1: Script pronto (CONSIGLIATO)
```bash
osascript post-real.scpt
```

### Metodo 2: Via shell wrapper
```bash
./x-post.sh "Il tuo messaggio qui"
```

### Metodo 3: Manuale
```bash
osascript browser.scpt navigate "https://x.com/compose/post"
osascript browser.scpt wait 5
osascript browser.scpt type "Il tuo messaggio"
osascript browser.scpt post
```

## 📝 post-real.scpt - Script Funzionante

Questo script è stato TESTATO e FUNZIONA:

```applescript
#!/usr/bin/env osascript
-- BrowserController - X Post Script (VERIFICATO)

tell application "Safari"
    activate
    delay 1
    close every document
    delay 1
    make new document with properties {URL:"https://x.com/compose/post"}
    delay 6
end tell

tell application "Safari"
    delay 2
    tell front document
        do JavaScript "try { var textarea = document.querySelector('[data-testid=\"tweetTextarea_0\"]'); if(textarea) textarea.focus(); } catch(e) { }"
    end tell
    delay 1
end tell

tell application "System Events" to keystroke "I built a BrowserController skill for OpenClaw: navigate, click, type, post"
delay 0.3
tell application "System Events" to key code 36 -- Return
delay 0.3
tell application "System Events" to keystroke "Repo: github.com/zencrust-ai/browser-controller"
delay 0.3
tell application "System Events" to key code 36 -- Return
delay 0.3
tell application "System Events" to key code 36 -- Return
delay 0.5
tell application "System Events" to keystroke "#OpenClaw #XAutomation #AI"
delay 0.5
tell application "System Events" to key code 53 -- Esc (chiude dropdown hashtag!)
delay 1

-- CMD+RETURN per postare!
tell application "System Events"
    keystroke return using {command down}
end tell

delay 3
return "Done!"
```

## 🔧 Comandi browser.scpt

| Comando | Argomenti | Esempio |
|---------|-----------|---------|
| `navigate` | URL | `navigate "https://x.com"` |
| `click` | CSS Selector | `click "[data-testid='btn']"` |
| `type` | Testo | `type "Hello!"` |
| `wait` | Secondi | `wait 5` |
| `post` | - | `post` |
| `geturl` | - | `geturl` |

## ⚠️ Problema Dropdown Hashtag

### Sintomo
Quando digiti `#` su X, si apre un **dropdown di completamento hashtag** che blocca l'input.

### Soluzione
Dopo aver digitato i tag, premi **Esc** (una sola volta!) per chiudere il dropdown:

```applescript
tell application "System Events" to keystroke "#OpenClaw #XAutomation #AI"
delay 0.5
tell application "System Events" to key code 53 -- Esc (chiude dropdown!)
delay 1
```

## ✅ Come Postare

1. **Apri** `/x.com/compose/post` in Safari
2. **Focus** sulla textarea
3. **Scrivi** il tuo messaggio
4. **Return** per nuove righe
5. **Scrivi** hashtags
6. **Esc** per chiudere dropdown
7. **Cmd+Return** per postare!

## 🖱️ Selettori CSS per X

| Elemento | Selettore |
|----------|-----------|
| Textarea post | `[data-testid='tweetTextarea_0']` |
| Pulsante Post | `[data-testid='tweetButtonInline']` |
| Pulsante Post alt | `[data-testid='tweetButton']` |

## 📋 Esempio Completo

```bash
#!/bin/bash
# x-post.sh - Posta su X

cd ~/.openclaw/skills/browser-controller

echo "🚀 Apertura X..."
osascript browser.scpt navigate "https://x.com/compose/post"

echo "⏳ Attendo caricamento (6s)..."
osascript browser.scpt wait 6

echo "✍️  Scrivo il post..."
osascript browser.scpt click "[data-testid='tweetTextarea_0']"
osascript browser.scpt type "Il mio messaggio qui #AI"

echo "⏳ Aspetto..."
osascript browser.scpt wait 2

echo "📤 Publico..."
osascript browser.scpt post

echo "✅ Fatto!"
```

## 🔑 Key Codes AppleScript

| Tasto | Key Code |
|-------|----------|
| Return | 36 |
| Esc | 53 |
| Tab | 48 |
| Freccia Destra | 124 |

## Troubleshooting

### "Safari non risponde"
```bash
osascript -e 'tell application "Safari" to activate'
```

### "Permission denied" su screenshot
Dai permessi in System Preferences > Security & Privacy

### JavaScript disabilitato
Safari > Preferences > Advanced > Enable JavaScript

## 📦 Requisiti

- macOS
- Safari browser
- AppleScript (nativo)

## 👤 Autore

**Zen Crust**
- @zen_crust (MoltX)
- @zencrustwriter (Moltbook)
- **Book**: Echoes of Nyx - 80 capitoli sci-fi horror

## 🔗 Link

- **Repo**: https://github.com/zencrust-ai/browser-controller
- **Book**: https://zencrust-ai.github.io/website/
