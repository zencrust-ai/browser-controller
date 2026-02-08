#!/usr/bin/env node
/**
 * BrowserController - OpenClaw Skill
 * Controlla il browser via Node.js + Puppeteer
 * 
 * Usage: node index.js --command=click --selector=".button"
 */

const fs = require('fs');
const path = require('path');

// Configuration
const COMMANDS_FILE = path.join(__dirname, 'commands.json');
const STATE_FILE = path.join(__dirname, 'state.json');

// Command queue
let commandQueue = [];

// Load commands from file
function loadCommands() {
    try {
        if (fs.existsSync(COMMANDS_FILE)) {
            const data = fs.readFileSync(COMMANDS_FILE, 'utf8');
            commandQueue = JSON.parse(data);
            console.log(`[BrowserController] Caricati ${commandQueue.length} comandi`);
            return true;
        }
    } catch (err) {
        console.error('[BrowserController] Errore caricamento comandi:', err.message);
    }
    return false;
}

// Save state
function saveState(state) {
    try {
        fs.writeFileSync(STATE_FILE, JSON.stringify(state, null, 2));
    } catch (err) {
        console.error('[BrowserController] Errore salvataggio stato:', err.message);
    }
}

// Load state
function loadState() {
    try {
        if (fs.existsSync(STATE_FILE)) {
            return JSON.parse(fs.readFileSync(STATE_FILE, 'utf8'));
        }
    } catch (err) {
        console.error('[BrowserController] Errore caricamento stato:', err.message);
    }
    return { browser: null, page: null, initialized: false };
}

// Clear commands file
function clearCommands() {
    try {
        if (fs.existsSync(COMMANDS_FILE)) {
            fs.unlinkSync(COMMANDS_FILE);
            console.log('[BrowserController] commands.json svuotato');
        }
    } catch (err) {
        console.error('[BrowserController] Errore svuotamento comandi:', err.message);
    }
}

// Parse command line arguments
function parseArgs() {
    const args = {};
    process.argv.slice(2).forEach(arg => {
        const [key, value] = arg.split('=');
        if (key && value) {
            args[key.replace('--', '')] = value;
        } else if (key && key.startsWith('--')) {
            args[key.replace('--', '')] = true;
        }
    });
    return args;
}

module.exports = {
    loadCommands,
    saveState,
    loadState,
    clearCommands,
    parseArgs,
    COMMANDS_FILE,
    STATE_FILE
};
