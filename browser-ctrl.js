/**
 * BrowserController Class
 * Controlla browser con Puppeteer
 */

const puppeteer = require('puppeteer');
const { saveState, loadState } = require('./config');

class BrowserController {
    constructor() {
        this.browser = null;
        this.page = null;
        this.state = loadState();
    }

    async init() {
        if (this.state.initialized && this.browser) {
            console.log('[BrowserController] Riutilizzo browser esistente');
            this.browser = this.state.browser;
            // In production, you'd reconnect to existing browser
            return true;
        }

        console.log('[BrowserController] Avvio nuovo browser...');
        this.browser = await puppeteer.launch({
            headless: true,
            args: [
                '--no-sandbox',
                '--disable-setuid-sandbox',
                '--disable-dev-shm-usage',
                '--disable-gpu'
            ]
        });

        this.page = await this.browser.newPage();
        await this.page.setViewport({ width: 1280, height: 800 });

        this.state.initialized = true;
        this.state.browser = true; // Flag instead of object
        saveState(this.state);

        console.log('[BrowserController] Browser avviato');
        return true;
    }

    async navigate(url) {
        if (!this.page) await this.init();
        console.log(`[BrowserController] Navigando a: ${url}`);
        await this.page.goto(url, { waitUntil: 'networkidle0' });
        return { success: true, url };
    }

    async click(selector, timeout = 5000) {
        if (!this.page) await this.init();
        
        try {
            await this.page.waitForSelector(selector, { timeout });
            await this.page.click(selector);
            console.log(`[BrowserController] Click su: ${selector}`);
            return { success: true, selector };
        } catch (err) {
            console.error(`[BrowserController] Errore click ${selector}:`, err.message);
            return { success: false, error: err.message };
        }
    }

    async type(text, selector = 'body') {
        if (!this.page) await this.init();
        
        try {
            await this.page.waitForSelector(selector, { timeout: 5000 });
            await this.page.click(selector);
            await this.page.keyboard.type(text);
            console.log(`[BrowserController] Testo inserito (${text.length} chars)`);
            return { success: true, length: text.length };
        } catch (err) {
            console.error('[BrowserController] Errore typing:', err.message);
            return { success: false, error: err.message };
        }
    }

    async wait(ms) {
        console.log(`[BrowserController] Aspetto ${ms}ms...`);
        await new Promise(resolve => setTimeout(resolve, ms));
        return { success: true, waited: ms };
    }

    async screenshot(path) {
        if (!this.page) await this.init();
        
        try {
            await this.page.screenshot({ path, fullPage: true });
            console.log(`[BrowserController] Screenshot salvato: ${path}`);
            return { success: true, path };
        } catch (err) {
            console.error('[BrowserController] Errore screenshot:', err.message);
            return { success: false, error: err.message };
        }
    }

    async getPageHTML() {
        if (!this.page) await this.init();
        const html = await this.page.content();
        console.log(`[BrowserController] HTML ottenuto (${html.length} chars)`);
        return { success: true, htmlLength: html.length, html: html.substring(0, 1000) + '...' };
    }

    async evaluate(fn) {
        if (!this.page) await this.init();
        
        try {
            const result = await this.page.evaluate(fn);
            console.log(`[BrowserController] Evaluate eseguito`);
            return { success: true, result };
        } catch (err) {
            console.error('[BrowserController] Errore evaluate:', err.message);
            return { success: false, error: err.message };
        }
    }

    async close() {
        if (this.browser) {
            await this.browser.close();
            this.browser = null;
            this.page = null;
            this.state.initialized = false;
            this.state.browser = false;
            saveState(this.state);
            console.log('[BrowserController] Browser chiuso');
        }
        return { success: true };
    }
}

module.exports = BrowserController;
