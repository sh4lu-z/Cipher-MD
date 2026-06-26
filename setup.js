const readline = require('readline');
const fs = require('fs');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

const ENV_FILE = '.env';

const vars = [
    { name: 'SESSION_ID', prompt: 'Your WhatsApp Session ID | ඔබගේ WhatsApp Session ID එක: ' },
    { name: 'PAIRING_NUMBER', prompt: 'Number to get pairing code (ex: 947xxxxxxxx): ' },
    { name: 'OWNER_NUMBER', prompt: "Owner's phone number (ex: 947xxxxxxxx): " },
    { name: 'MONGO_URL', prompt: 'MongoDB Database connection URL: ' },
    { name: 'GROQ_API_KEY_1', prompt: 'Router Key for module identification: ' },
    { name: 'GROQ_API_KEY_2', prompt: 'Main Chat API Key: ' },
    { name: 'GROQ_API_KEY_3', prompt: 'Backup API Key: ' },
    { name: 'VT_API_KEY', prompt: 'VirusTotal API Key for scanning files: ' }
];

console.log('\n==========================================');
console.log('   ⚠️ [ CIPHER-MD ENV SETUP ] ⚠️');
console.log('==========================================\n');

// Clear existing .env
fs.writeFileSync(ENV_FILE, '');

let currentStep = 0;

function askNext() {
    if (currentStep < vars.length) {
        const v = vars[currentStep];
        rl.question(`\x1b[33m${v.prompt}\x1b[0m\n➔ `, (answer) => {
            fs.appendFileSync(ENV_FILE, `${v.name}=${answer}\n`);
            console.log(`\x1b[32m✔ Saved ${v.name}\x1b[0m\n`);
            currentStep++;
            askNext();
        });
    } else {
        console.log('\x1b[32m==========================================\x1b[0m');
        console.log('\x1b[36m ✔ Successfully created .env file!\x1b[0m');
        console.log('\x1b[32m==========================================\x1b[0m');
        console.log('You can now run the bot using "npm start"\n');
        rl.close();
    }
}

askNext();
