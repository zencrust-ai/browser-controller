#!/usr/bin/env node
/**
 * BrowserController - Main Entry Point
 * OpenClaw Skill per controllare browser via Node.js
 * 
 * Usage:
 *   node index.js --command=navigate --url=https://x.com
 *   node index.js --command=click --selector=".btn"
 *   node index.js --command=type --text="Hello" --selector="#input"
 *   node index.js --command=screenshot --path="screenshot.png"
 *   node index.js --command=run --file=commands.json
 */

const BrowserController = require('./browser-ctrl');
const { loadCommands, clearCommands, parseArgs } = require('./config');

const ctrl = new BrowserController();

// Execute a single command
async function executeCommand(cmd) {
    const { command, selector, text, url, path, timeout, file } = cmd;

    switch (command) {
        case 'navigate':
            return await ctrl.navigate(url || 'https://google.com');
        
        case 'click':
            return await ctrl.click(selector, timeout || 5000);
        
        case 'type':
            return await ctrl.type(text || '', selector || 'body');
        
        case 'wait':
            return await ctrl.wait(timeout || 1000);
        
        case 'screenshot':
            return await ctrl.screenshot(path || 'screenshot.png');
        
        case 'getHTML':
            return await ctrl.getPageHTML();
        
        case 'evaluate':
            return await ctrl.evaluate(new Function(cmd.fn)());
        
        case 'close':
            return await ctrl.close();
        
        case 'init':
            return await ctrl.init();
        
        default:
            return { success: false, error: `Comando sconosciuto: ${command}` };
    }
}

// Run commands from file
async function runFromFile(filename) {
    try {
        const fs = require('fs');
        const commands = JSON.parse(fs.readFileSync(filename, 'utf8'));
        console.log(`[BrowserController] Eseguo ${commands.length} comandi da ${filename}`);
        
        let results = [];
        for (const cmd of commands) {
            console.log(`\n▶ Eseguo: ${cmd.command}`);
            const result = await executeCommand(cmd);
            results.push(result);
            
            if (!result.success) {
                console.log('❌ Fallito:', result.error);
                break;
            }
            console.log('✅ Successo');
        }
        
        return results;
    } catch (err) {
        return { success: false, error: err.message };
    }
}

// Main execution
async function main() {
    const args = parseArgs();
    
    // Check for command file mode
    if (args.run && args.run.endsWith('.json')) {
        const results = await runFromFile(args.run);
        console.log('\n📊 Risultati:', JSON.stringify(results, null, 2));
        await ctrl.close();
        process.exit(results.every(r => r.success) ? 0 : 1);
    }
    
    // Single command mode
    if (args.command) {
        console.log(`[BrowserController] Eseguo comando: ${args.command}`);
        const result = await executeCommand(args);
        console.log('\n📊 Risultato:', JSON.stringify(result, null, 2));
        await ctrl.close();
        process.exit(result.success ? 0 : 1);
    }
    
    // Interactive / help mode
    console.log(`
╔════════════════════════════════════════════════════════════╗
║           BrowserController - OpenClaw Skill               ║
╚════════════════════════════════════════════════════════════╝

Usage:
  node index.js --command=<cmd> [options]

Commands:
  --command=init           Inizializza browser
  --command=navigate --url=<url>
  --command=click --selector=<css>
  --command=type --text=<txt> [--selector=<css>]
  --command=wait --timeout=<ms>
  --command=screenshot --path=<file.png>
  --command=getHTML
  --command=close

Examples:
  node index.js --command=navigate --url=https://x.com
  node index.js --command=click --selector=".btn-post"
  node index.js --command=type --text="Ciao!" --selector="#input"
  node index.js --command=screenshot --path="x-post.png"
  node index.js --command=run --file=commands.json

File Commands:
  Crea un file JSON con array di comandi:
  [
    {"command": "navigate", "url": "https://x.com"},
    {"command": "wait", "timeout": 2000},
    {"command": "click", "selector": ".post-btn"}
  ]
`);
}

// Run if called directly
if (require.main === module) {
    main().catch(err => {
        console.error('[BrowserController] Fatal error:', err);
        process.exit(1);
    });
}

module.exports = { BrowserController, executeCommand, runFromFile };
