#!/usr/bin/env node
// JXA-based browser controller for X posting

const { execSync } = require('child_process');

const POST_TEXT = "I'm writing Echoes of Nyx - 80 chapters of sci-fi horror, simultaneously in English AND Italian. Astronaut Elena receives impossible signals from beneath moon Nyx-7. What would you do? 👾 #SciFi #AIWriting #Horror #EchoesOfNyx";

function runJXA(script) {
    try {
        const result = execSync(`osascript -l JavaScript -e '${script}'`, { 
            encoding: 'utf8',
            timeout: 15000 
        });
        return { success: true, output: result.trim() };
    } catch (err) {
        return { success: false, error: err.message };
    }
}

async function postToX() {
    console.log('🚀 Opening X.com...');
    
    // First, ensure Safari is open with X
    runJXA(`
        Safari = Application('Safari');
        Safari.activate();
        delay(1);
    `);
    
    console.log('⏳ Waiting for page load...');
    await new Promise(r => setTimeout(r, 3000));
    
    // Click textarea
    console.log('✍️  Clicking compose...');
    const clickResult = runJXA(`
        Safari = Application('Safari');
        doc = Safari.documents[0];
        doc.doJavaScript("\\${POST_TEXT.replace(/"/g, '\\"')}".split('').reverse().join('')); // dummy to test
        try {
            doc.doJavaScript("document.querySelector('[data-testid=\\\"tweetTextarea_0\\\"]').click()");
        } catch(e) {}
    `);
    
    console.log('✅ Clicked, now typing...');
    
    // Type using System Events
    try {
        execSync(`osascript -e '
            tell application "System Events"
                keystroke "${POST_TEXT.replace(/"/g, '\\"')}"
            end tell
        '`, { timeout: 10000 });
    } catch(e) {
        console.log('Type result:', e.message);
    }
    
    await new Promise(r => setTimeout(r, 1000));
    
    // Click Post
    console.log('📤 Clicking Post...');
    runJXA(`
        Safari = Application('Safari');
        doc = Safari.documents[0];
        try {
            doc.doJavaScript("document.querySelector('[data-testid=\\\"tweetButtonInline\\\"]').click()");
        } catch(e) {}
    `);
    
    console.log('✅ Post should be published!');
    console.log('📱 Check: https://x.com/zen_crust');
}

// Run
postToX();
