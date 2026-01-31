const https = require('https');
const fs = require('fs');
const path = require('path');

// Cargar .env manualmente
function loadEnv() {
    try {
        const envPath = path.join(__dirname, '..', '.env');
        const content = fs.readFileSync(envPath, 'utf8');
        const env = {};
        content.split('\n').forEach(line => {
            if (line.includes('=') && !line.startsWith('#')) {
                const [key, value] = line.trim().split('=', 2);
                env[key] = value;
            }
        });
        return env;
    } catch (e) {
        console.error("Error loading .env:", e.message);
        process.exit(1);
    }
}

const config = loadEnv();
const token = config.SUPABASE_ACCESS_TOKEN;

if (!token) {
    console.error("Error: SUPABASE_ACCESS_TOKEN not found in .env");
    process.exit(1);
}

const options = {
    hostname: 'api.supabase.com',
    path: '/v1/projects',
    method: 'GET',
    headers: {
        'Authorization': `Bearer ${token}`,
        'User-Agent': 'IAmazing-Dashboard/1.0'
    }
};

console.log("Connecting to Supabase Management API...");

const req = https.request(options, (res) => {
    let data = '';

    res.on('data', (chunk) => {
        data += chunk;
    });

    res.on('end', () => {
        if (res.statusCode === 200) {
            try {
                const projects = JSON.parse(data);
                console.log(`SUCCESS: Found ${projects.length} projects.`);
                console.log("-".repeat(40));
                projects.forEach(p => {
                    console.log(`ID: ${p.id}`);
                    console.log(`Name: ${p.name}`);
                    console.log(`Status: ${p.status}`);
                    console.log(`Region: ${p.region}`);
                    console.log("-".repeat(40));
                });
            } catch (e) {
                console.error("Error parsing JSON:", e.message);
            }
        } else {
            console.error(`Error: HTTP ${res.statusCode}`);
            console.error(data);
        }
    });
});

req.on('error', (e) => {
    console.error(`Request error: ${e.message}`);
});

req.end();
