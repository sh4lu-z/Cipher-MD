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

# Pure Bash/grep/sed extraction (No Node.js or Python required)
CLIENT_ID=$(grep -o '"client_id"[[:space:]]*:[[:space:]]*"[^"]*"' "$CRED_FILE" | head -n 1 | sed 's/.*"client_id"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')
CLIENT_SECRET=$(grep -o '"client_secret"[[:space:]]*:[[:space:]]*"[^"]*"' "$CRED_FILE" | head -n 1 | sed 's/.*"client_secret"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')

if [ -z "$CLIENT_ID" ] || [ -z "$CLIENT_SECRET" ]; then
    echo "❌ Error: Invalid credentials.json format (missing client_id or client_secret)."
    exit 1
fi

PORT=51234
REDIRECT_URI="http://127.0.0.1:$PORT/"
ENCODED_REDIRECT_URI="http%3A%2F%2F127.0.0.1%3A$PORT%2F"
ENCODED_SCOPE="https%3A%2F%2Fmail.google.com%2F%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcontacts%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcalendar%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Ftasks"

AUTH_URL="https://accounts.google.com/o/oauth2/v2/auth?client_id=$CLIENT_ID&redirect_uri=$ENCODED_REDIRECT_URI&response_type=code&scope=$ENCODED_SCOPE&access_type=offline&prompt=consent"

# Pure Bash URL decoder
urldecode() {
    local url_encoded="${1//+/ }"
    printf '%b' "${url_encoded//%/\\x}"
}

# Extract 'code=' from a full URL, HTTP request line, or raw code string
extract_code() {
    local input="$1"
    local raw_code=""
    if [[ "$input" == *"code="* ]]; then
        raw_code=$(printf '%s' "$input" | sed -n 's/.*[?&]code=\([^&#[:space:]]*\).*/\1/p')
        if [ -z "$raw_code" ]; then
            raw_code=$(printf '%s' "$input" | sed -n 's/.*code=\([^&#[:space:]]*\).*/\1/p')
        fi
    else
        raw_code=$(printf '%s' "$input" | tr -d '[:space:]')
    fi
    urldecode "$raw_code"
}

echo "🌐 Opening browser for Google login..."
echo "   (Complete the login in your browser.)"
echo ""
echo "🔗 Login URL:"
echo "$AUTH_URL"
echo ""

if command -v xdg-open &> /dev/null; then
    xdg-open "$AUTH_URL" &> /dev/null &
elif command -v open &> /dev/null; then
    open "$AUTH_URL" &> /dev/null &
elif command -v termux-open-url &> /dev/null; then
    termux-open-url "$AUTH_URL" &> /dev/null &
elif command -v start &> /dev/null; then
    start "$AUTH_URL" &> /dev/null &
fi

HTML_SUCCESS='HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=utf-8\r\nConnection: close\r\n\r\n<html><body style="font-family:Arial;text-align:center;padding:50px;background:#1a1a1a;color:#fff"><h1>Authentication Successful! &#9989;</h1><p>You can close this window and return to the terminal.</p></body></html>'

RAW_CAPTURE=""

# Try catching redirect automatically via netcat (nc) if running on a desktop environment
if command -v nc &> /dev/null && { [ -n "$DISPLAY" ] || [ -n "$WAYLAND_DISPLAY" ] || [[ "$OSTYPE" == "darwin"* ]] || command -v cygpath &> /dev/null; }; then
    echo "⏳ Waiting for browser redirect on port $PORT..."
    echo "   (Press Ctrl+C if you logged in on a different device and want to paste the URL manually)"
    if nc -h 2>&1 | grep -q -- "-N"; then
        RAW_CAPTURE=$({ sleep 1; printf "%b" "$HTML_SUCCESS"; } | nc -l -N 127.0.0.1 "$PORT" 2>/dev/null | head -n 1)
    elif nc -h 2>&1 | grep -q -- "-q"; then
        RAW_CAPTURE=$({ sleep 1; printf "%b" "$HTML_SUCCESS"; } | nc -l -q 1 -p "$PORT" 127.0.0.1 2>/dev/null | head -n 1)
    else
        RAW_CAPTURE=$({ sleep 1; printf "%b" "$HTML_SUCCESS"; } | nc -l -p "$PORT" 127.0.0.1 2>/dev/null | head -n 1)
    fi
fi

CODE=$(extract_code "$RAW_CAPTURE")

# Fallback: If no local listener succeeded (or headless VPS / minimal Linux without nc/python/node), prompt user to paste redirected URL
if [ -z "$CODE" ]; then
    echo ""
    echo "📋 After logging in, your browser will redirect to a URL starting with:"
    echo "   http://127.0.0.1:$PORT/?code=..."
    echo "   (Even if the browser says 'This site can’t be reached', copy that full URL from the address bar!)"
    echo ""
    read -r -p "👉 Paste the redirected URL (or authorization code) here: " USER_INPUT
    CODE=$(extract_code "$USER_INPUT")
fi

if [ -n "$CODE" ]; then
    echo "✅ Code received! Generating token..."

    TOKEN_RESP=$(curl -s -X POST "https://oauth2.googleapis.com/token" \
        --data-urlencode "code=$CODE" \
        --data-urlencode "client_id=$CLIENT_ID" \
        --data-urlencode "client_secret=$CLIENT_SECRET" \
        --data-urlencode "redirect_uri=$REDIRECT_URI" \
        --data-urlencode "grant_type=authorization_code")

    if printf '%s' "$TOKEN_RESP" | grep -q '"access_token"'; then
        printf '%s\n' "$TOKEN_RESP" > token.json

        # Minify JSON using pure tr and sed (no Node/Python needed)
        MINIFIED=$(printf '%s' "$TOKEN_RESP" | tr -d '\r\n' | sed 's/[[:space:]]*"/"/g; s/":[[:space:]]*/":/g; s/,[[:space:]]*/,/g; s/{[[:space:]]*/{/g; s/[[:space:]]*}/}/g')

        echo "--------------------------------------------------"
        echo -e "\033[32m✅ Success! Copy the entire string below and paste it into the 'GOOGLE_TOKEN' variable in Koyeb:\033[0m"
        echo ""
        echo -e "\033[35m$MINIFIED\033[0m"
        echo ""
        echo "--------------------------------------------------"
    else
        echo "❌ Error from Google OAuth server:"
        echo "$TOKEN_RESP"
        exit 1
    fi
else
    echo "❌ Failed to get authorization code."
    exit 1
fi
