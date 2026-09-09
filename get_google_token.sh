#!/bin/bash

echo "========================================="
echo "   Cipher-MD Google Token Generator      "
echo "========================================="

# Find credentials.json
CRED_FILE=""
for file in "credentials.json" "../credentials.json" "../../credentials.json"; do
    if [ -f "$file" ]; then
        CRED_FILE=$file
        break
    fi
done

if [ -z "$CRED_FILE" ]; then
    echo "❌ Error: Could not find 'credentials.json'."
    echo "Please put 'credentials.json' in this folder and try again."
    exit 1
fi

echo "✅ Found credentials at: $CRED_FILE"

# Extract client_id and client_secret
if command -v node &> /dev/null; then
    CLIENT_ID=$(node -e "const d=require(require('path').resolve('$CRED_FILE')); const c=d.installed||d.web||{}; console.log(c.client_id||'')")
    CLIENT_SECRET=$(node -e "const d=require(require('path').resolve('$CRED_FILE')); const c=d.installed||d.web||{}; console.log(c.client_secret||'')")
elif command -v python3 &> /dev/null; then
    CLIENT_ID=$(python3 -c "import json; d=json.load(open('$CRED_FILE')); print(d.get('installed', d.get('web', {})).get('client_id', ''))")
    CLIENT_SECRET=$(python3 -c "import json; d=json.load(open('$CRED_FILE')); print(d.get('installed', d.get('web', {})).get('client_secret', ''))")
else
    echo "❌ Error: Node.js or Python3 is required to parse credentials.json."
    exit 1
fi

if [ -z "$CLIENT_ID" ] || [ -z "$CLIENT_SECRET" ]; then
    echo "❌ Error: Invalid credentials.json format."
    exit 1
fi

PORT=51234
REDIRECT_URI="http://127.0.0.1:$PORT/"
SCOPE="https://mail.google.com/ https://www.googleapis.com/auth/contacts"
ENCODED_SCOPE="https%3A%2F%2Fmail.google.com%2F%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcontacts"

AUTH_URL="https://accounts.google.com/o/oauth2/v2/auth?client_id=$CLIENT_ID&redirect_uri=$REDIRECT_URI&response_type=code&scope=$ENCODED_SCOPE&access_type=offline&prompt=consent"

echo "🌐 Opening browser for Google login..."
echo "   (Browser will open automatically. Complete the login to catch the code.)"

if command -v xdg-open &> /dev/null; then
    xdg-open "$AUTH_URL" &> /dev/null
elif command -v open &> /dev/null; then
    open "$AUTH_URL" &> /dev/null
else
    echo "⚠️ Could not open browser automatically. Please manually open this URL:"
    echo "$AUTH_URL"
fi

echo "Waiting for authentication on port $PORT..."

# Function to run the local server using python3 if available
run_python_server() {
    python3 -c "
import urllib.request, urllib.parse, http.server, sys
class Handler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        is_success = 'code=' in self.path
        if is_success:
            self.wfile.write(b'<html><body style=\"font-family:Arial;text-align:center;padding:50px;background:#1a1a1a;color:#fff\"><h1>Authentication Successful! \\xe2\\x9c\\x85</h1><p>You can close this window now.</p></body></html>')
            query = urllib.parse.parse_qs(urllib.parse.urlparse(self.path).query)
            print(query['code'][0])
        else:
            self.wfile.write(b'<html><body style=\"font-family:Arial;text-align:center;padding:50px;background:#330000;color:#fff\"><h1>Authentication Failed \\xe2\\x9d\\x8c</h1><p>Failed to get authorization code. Please check terminal.</p></body></html>')
        sys.exit(0)
http.server.HTTPServer(('127.0.0.1', $PORT), Handler).handle_request()
" 2>/dev/null
}

# Function to run local server using Node.js as fallback
run_node_server() {
    node -e "
const http = require('http');
const server = http.createServer((req, res) => {
    res.writeHead(200, {'Content-Type': 'text/html'});
    if (req.url.includes('code=')) {
        res.end('<html><body style=\"font-family:Arial;text-align:center;padding:50px;background:#1a1a1a;color:#fff\"><h1>Authentication Successful! ✅</h1><p>You can close this window now.</p></body></html>');
        console.log(new URL(req.url, 'http://localhost').searchParams.get('code'));
    } else {
        res.end('<html><body style=\"font-family:Arial;text-align:center;padding:50px;background:#330000;color:#fff\"><h1>Authentication Failed ❌</h1><p>Failed to get authorization code. Please check terminal.</p></body></html>');
    }
    server.close();
    process.exit(0);
});
server.listen($PORT);
" 2>/dev/null
}

# Try Python3 first, fallback to Node.js
CODE=""
if command -v python3 &> /dev/null; then
    CODE=$(run_python_server)
elif command -v node &> /dev/null; then
    CODE=$(run_node_server)
else
    echo "❌ Error: Neither python3 nor node are installed. Cannot start local listener."
    exit 1
fi

if [ -n "$CODE" ]; then
    echo "✅ Code received! Generating token..."
    
    # Exchange code for token using curl
    TOKEN_RESP=$(curl -s -X POST https://oauth2.googleapis.com/token \
        -d "code=$CODE" \
        -d "client_id=$CLIENT_ID" \
        -d "client_secret=$CLIENT_SECRET" \
        -d "redirect_uri=$REDIRECT_URI" \
        -d "grant_type=authorization_code")
    
    echo "$TOKEN_RESP" > token.json
    
    # Minify JSON safely
    if command -v node &> /dev/null; then
        MINIFIED=$(node -e "console.log(JSON.stringify(JSON.parse(process.argv[1])))" "$TOKEN_RESP")
    elif command -v python3 &> /dev/null; then
        MINIFIED=$(python3 -c "import sys, json; print(json.dumps(json.loads(sys.argv[1]), separators=(',', ':')))" "$TOKEN_RESP")
    else
        MINIFIED=$(echo "$TOKEN_RESP" | tr -d '\n\r')
    fi
    
    echo "--------------------------------------------------"
    echo -e "\033[32m✅ Success! Copy the entire string below and paste it into the 'GOOGLE_TOKEN' variable in Koyeb:\033[0m"
    echo ""
    echo -e "\033[35m$MINIFIED\033[0m"
    echo ""
    echo "--------------------------------------------------"
else
    echo "❌ Failed to get authorization code."
fi
