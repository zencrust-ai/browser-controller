#!/usr/bin/env node
/**
 * BrowserController - Node.js Wrapper for AppleScript
 * Controlla Safari via osascript commands
 * 
 * Usage: node browser-safari.js navigate "https://x.com"
 */

const { execSync, exec } = require('child_process');
const path = require('path');

const SCRIPT_PATH = path.join(__dirname, 'browser-jxa.scpt');

class SafariController {
    constructor() {
        this.browser = 'Safari';
    }

    run(command, ...args) {
        const cmdArgs = args.map(a => `"${a}"`).join(' ');
        const fullCmd = `osascript "${SCRIPT_PATH}" ${command} ${cmdArgs}`;
        
        try {
            const result = execSync(fullCmd, { encoding: 'utf8', timeout: 10000 });
            return { success: true, output: result.trim() };
        } catch (err) {
            return { success: false, error: err.message, output: err.stdout };
        }
    }

    async navigate(url) {
        return this.run('navigate', url);
    }

    async click(selector) {
        return this.run('click', selector);
    }

    async type(text) {
        return this.run('type', text);
    }

    async wait(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
    }

    async screenshot(filepath) {
        return this.run('screenshot', filepath);
    }

    async getHTML() {
        return this.run('gethtml');
    }

    async post() {
        return this.run('post');
    }

    async close() {
        return this.run('close');
    }

    // Combined: Navigate and wait
    async navigateAndWait(url, waitMs = 2000) {
        await this.navigate(url);
        await this.wait(waitMs);
    }

    // Combined: Fill form and post
    async postToX(text, waitMs = 1000) {
        await this.type(text);
        await this.wait(waitMs);
        return await this.post();
    }
}

// CLI interface
async function main() {
    const args = process.argv.slice(2);
    
    if (args.length === 0) {
        console.log(`
╔════════════════════════════════════════════════════════════╗
║           BrowserController - Safari/JXA                    ║
╚════════════════════════════════════════════════════════════╝

Usage:
  node browser-safari.js <command> [args]

Commands:
  navigate <url>        Apri URL
  click <selector>      Clicca elemento CSS
  type <text>           Scrivi testo
  wait <ms>             Aspetta millisecondi
  screenshot <path>     Salva screenshot
  gethtml               Ottieni HTML pagina
  post                  Clicca pulsante Post (X)
  close                 Chiudi scheda

Examples:
  node browser-safari.js navigate "https://x.com"
  node browser-safari.js type "Ciao da Safari!"
  node browser-safari.js post

Combine with wait():
  node browser-safari.js navigate "https://x.com"
  node browser-safari.js wait 2000
  node browser-safari.js type "Test post!"
  node browser-safari.js wait 1000
  node browser-safari.js post
`);
        return;
    }

    const ctrl = new SafariController();
    const command = args[0];
    const commandArgs = args.slice(1);

    try {
        const result = await ctrl[command](...commandArgs);
        console.log(JSON.stringify(result, null, 2));
    } catch (err) {
        console.error('Error:', err.message);
    }
}

// Test function
async function testXPost() {
    const ctrl = new SafariController();
    
    console.log('🧪 Test: Post su X');
    
    await ctrl.navigate('https://x.com/zen_crust');
    console.log('✅ Navigato a X');
    
    await ctrl.wait(2000);
    console.log('✅ Aspettato 2s');
    
    // In production, this would be the full post workflow
    await ctrl.close();
    console.log('✅ Chiuso');
}

if (require.main === module) {
    // If called with --test flag, run test
    if (process.argv.includes('--test')) {
        testXPost();
    } else {
        main();
    }
}

module.exports = SafariController;
