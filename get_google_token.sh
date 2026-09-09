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

# Since we want this to work natively without dependencies, we use grep to extract client_id and secret
CLIENT_ID=$(grep -o '"client_id"[^,]*' "$CRED_FILE" | head -n 1 | cut -d '"' -f 4)
CLIENT_SECRET=$(grep -o '"client_secret"[^,]*' "$CRED_FILE" | head -n 1 | cut -d '"' -f 4)

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

# Function to run the local server using python3 if available (highly reliable)
run_python_server() {
    python3 -c "
import urllib.request, urllib.parse, http.server, sys
class Handler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(b'<html><body style=\"font-family:Arial;text-align:center;padding:50px;background:#1a1a1a;color:#fff\"><h1>Authentication Successful! \\xe2\\x9c\\x85</h1><p>You can close this window now.</p></body></html>')
        if 'code=' in self.path:
            query = urllib.parse.parse_qs(urllib.parse.urlparse(self.path).query)
            print(query['code'][0])
        sys.exit(0)
http.server.HTTPServer(('127.0.0.1', $PORT), Handler).handle_request()
" 2>/dev/null
}

# Function to run local server using bash + netcat as fallback
run_nc_server() {
    # MacOS and Linux have slightly different nc behaviors
    RESPONSE="HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<html><body style='font-family:Arial;text-align:center;padding:50px;background:#1a1a1a;color:#fff'><h1>Authentication Successful! ✅</h1><p>You can close this window now.</p></body></html>"
    
    if nc -h 2>&1 | grep -q '\-l'; then
        # BSD Netcat (Mac)
        REQ=$(echo -e "$RESPONSE" | nc -l $PORT)
    else
        # GNU Netcat (Linux)
        REQ=$(echo -e "$RESPONSE" | nc -l -p $PORT -q 1)
    fi
    echo "$REQ" | grep -o 'code=[^ &]*' | head -n 1 | cut -d '=' -f 2
}

# Try Python3 first, fallback to Netcat
CODE=""
if command -v python3 &> /dev/null; then
    CODE=$(run_python_server)
elif command -v nc &> /dev/null; then
    CODE=$(run_nc_server)
else
    echo "❌ Error: Neither python3 nor netcat (nc) are installed. Cannot start local listener."
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
    
    # Minify JSON
    MINIFIED=$(echo "$TOKEN_RESP" | tr -d ' \n\r')
    
    echo "--------------------------------------------------"
    echo -e "\033[32m✅ Success! Copy the entire string below and paste it into the 'GOOGLE_TOKEN' variable in Koyeb:\033[0m"
    echo ""
    echo -e "\033[35m$MINIFIED\033[0m"
    echo ""
    echo "--------------------------------------------------"
else
    echo "❌ Failed to get authorization code."
fi
