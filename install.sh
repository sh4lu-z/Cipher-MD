#!/bin/bash

if [ ! -t 0 ]; then
    echo "================================================================="
    echo "[ERROR] This script requires interactive user input."
    echo "Please do not run it by piping (e.g. curl ... | bash)."
    echo "Instead, download and run it:"
    echo "curl -O https://cipher-md.syntiox.top/install.sh && bash install.sh"
    echo "================================================================="
    exit 1
fi

TARGET_DIR="$HOME/.sh4lu-z/CIPHER MD"
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR" || exit

echo "Downloading Cipher-MD..."
curl -L -o Cipher-MD.zip https://github.com/sh4lu-z/Cipher-MD/archive/refs/heads/main.zip

if [ -f "Cipher-MD-main/.env" ]; then
    echo "[INFO] Backing up existing .env file..."
    cp "Cipher-MD-main/.env" ".env.backup"
fi

CLEAN_INSTALL="Y"
if [ -d "Cipher-MD-main/node_modules" ]; then
    echo ""
    echo "[INFO] Existing node_modules found."
    read -p "Do you want to do a clean install and re-download all modules? (Y/N): " CLEAN_INSTALL
fi

if [[ "$CLEAN_INSTALL" == "Y" || "$CLEAN_INSTALL" == "y" ]]; then
    if [ -d "Cipher-MD-main" ]; then
        echo "Removing old files for a clean install..."
        rm -rf "Cipher-MD-main"
    fi
else
    echo "Keeping existing node_modules. Only missing/updated modules will be downloaded."
fi

echo "Extracting files..."
unzip -o -q Cipher-MD.zip || {
    echo "unzip command not found. Please install unzip first."
    exit 1
}
rm Cipher-MD.zip
cd Cipher-MD-main || exit

if [ -f "../.env.backup" ]; then
    echo "[INFO] Restoring backed up .env file..."
    cp "../.env.backup" ".env"
    rm "../.env.backup"
fi

CREATE_ENV="Y"
if [ -f ".env" ]; then
    echo ""
    echo "[WARNING] An existing .env file was found."
    read -p "Do you want to overwrite it? (Y/N): " OVERWRITE_ENV
    if [[ "$OVERWRITE_ENV" != "Y" && "$OVERWRITE_ENV" != "y" ]]; then
        CREATE_ENV="N"
        echo "Skipping .env setup..."
    fi
fi

if [ "$CREATE_ENV" == "Y" ]; then
    echo ""
    echo "Please enter the following Environment Variables."
    echo "(If a variable is not needed, just press Enter to skip it)"
    echo ""
    
    while true; do
        read -p "Your WhatsApp Session ID (Required): " SESSION_ID
        if [ -n "$SESSION_ID" ]; then
            break
        else
            echo "Session ID cannot be empty."
        fi
    done

    read -p "Number to get pairing code (Required): " PAIRING_NUMBER
    read -p "MongoDB Database URL (Required): " MONGO_URL
    
    echo ""
    echo "--- Optional Variables ---"
    read -p "Owner's phone number (Optional): " OWNER_NUMBER
    read -p "Bot Name: " BOT_NAME
    read -p "Footer Text: " FOOTER
    read -p "Menu Image URL: " MENU_IMAGE
    read -p "Groq API Key (comma separated): " GROQ_API_KEY
    read -p "Gemini API Key: " GEMINI_API_KEY
    read -p "Firecrawl API Key: " FIRECRAWL_API_KEY
    read -p "HuggingFace Token: " HF_TOKEN
    read -p "NASA API Key: " NASA_API_KEY
    read -p "Rapid API Key: " RAPID_API_KEY
    read -p "Syntiox API Key: " SYNTIOX_API_KEY
    read -p "VirusTotal API Key: " VT_API_KEY
    read -p "AI Chat Platform (default: google): " AI_CHAT_PLATFORM
    read -p "AI Chat Model (default: gemini-3.1-flash-lite): " AI_CHAT_MODEL
    read -p "AI Agent Platform (default: google): " AI_AGENT_PLATFORM
    read -p "AI Agent Model (default: gemini-3.1-flash-lite): " AI_AGENT_MODEL
    echo ""
    echo "[Agentic Tasks - Emails, Calendar, etc.]"
    read -p "Google Credentials JSON (Paste as single line): " GOOGLE_CREDENTIALS
    read -p "Google Token JSON (Paste as single line): " GOOGLE_TOKEN

    cat <<EOF > .env
SESSION_ID="$SESSION_ID"
PAIRING_NUMBER="$PAIRING_NUMBER"
MONGO_URL="$MONGO_URL"
EOF

    [ -n "$OWNER_NUMBER" ] && echo "OWNER_NUMBER=\"$OWNER_NUMBER\"" >> .env
    [ -n "$BOT_NAME" ] && echo "BOT_NAME=\"$BOT_NAME\"" >> .env
    [ -n "$FOOTER" ] && echo "FOOTER=\"$FOOTER\"" >> .env
    [ -n "$MENU_IMAGE" ] && echo "MENU_IMAGE=\"$MENU_IMAGE\"" >> .env
    [ -n "$GROQ_API_KEY" ] && echo "GROQ_API_KEY=\"$GROQ_API_KEY\"" >> .env
    [ -n "$GEMINI_API_KEY" ] && echo "GEMINI_API_KEY=\"$GEMINI_API_KEY\"" >> .env
    [ -n "$FIRECRAWL_API_KEY" ] && echo "FIRECRAWL_API_KEY=\"$FIRECRAWL_API_KEY\"" >> .env
    [ -n "$HF_TOKEN" ] && echo "HF_TOKEN=\"$HF_TOKEN\"" >> .env
    [ -n "$NASA_API_KEY" ] && echo "NASA_API_KEY=\"$NASA_API_KEY\"" >> .env
    [ -n "$RAPID_API_KEY" ] && echo "RAPID_API_KEY=\"$RAPID_API_KEY\"" >> .env
    [ -n "$SYNTIOX_API_KEY" ] && echo "SYNTIOX_API_KEY=\"$SYNTIOX_API_KEY\"" >> .env
    [ -n "$VT_API_KEY" ] && echo "VT_API_KEY=\"$VT_API_KEY\"" >> .env
    [ -n "$AI_CHAT_PLATFORM" ] && echo "AI_CHAT_PLATFORM=\"$AI_CHAT_PLATFORM\"" >> .env
    [ -n "$AI_CHAT_MODEL" ] && echo "AI_CHAT_MODEL=\"$AI_CHAT_MODEL\"" >> .env
    [ -n "$AI_AGENT_PLATFORM" ] && echo "AI_AGENT_PLATFORM=\"$AI_AGENT_PLATFORM\"" >> .env
    [ -n "$AI_AGENT_MODEL" ] && echo "AI_AGENT_MODEL=\"$AI_AGENT_MODEL\"" >> .env
    [ -n "$GOOGLE_CREDENTIALS" ] && echo "GOOGLE_CREDENTIALS='$GOOGLE_CREDENTIALS'" >> .env
    [ -n "$GOOGLE_TOKEN" ] && echo "GOOGLE_TOKEN='$GOOGLE_TOKEN'" >> .env
fi

DESKTOP_PATH="$HOME/Desktop/Cipher MD"
mkdir -p "$DESKTOP_PATH"

echo "Checking for Git and FFmpeg..."
PACKAGES_TO_INSTALL=""
if ! command -v git &> /dev/null; then
    PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL git"
fi
if ! command -v ffmpeg &> /dev/null; then
    PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL ffmpeg"
fi
if [ -n "$PACKAGES_TO_INSTALL" ]; then
    echo "Installing missing packages: $PACKAGES_TO_INSTALL"
    if command -v apt &> /dev/null; then
        sudo apt update && sudo apt install -y $PACKAGES_TO_INSTALL
    elif command -v pkg &> /dev/null; then
        pkg install -y $PACKAGES_TO_INSTALL
    fi
fi

echo "Checking for Node.js..."
if ! command -v node &> /dev/null; then
    echo "Node.js is not installed. Attempting to install Node.js automatically..."
    if command -v apt &> /dev/null; then
        echo "Installing via apt (may prompt for sudo password)..."
        sudo apt update && sudo apt install -y nodejs npm
    elif command -v pkg &> /dev/null; then
        echo "Installing via pkg (Termux)..."
        pkg install -y nodejs
    fi
fi

if command -v node &> /dev/null; then
    echo "Node.js is available. Using Node..."
    echo "Installing dependencies..."
    npm install || {
        echo "[ERROR] npm install failed. Please check your internet connection and try again."
        exit 1
    }

    echo "Setting up global commands and Desktop shortcuts..."
    
    BIN_PATH="$HOME/.local/bin"
    mkdir -p "$BIN_PATH"
    
    if [[ ":$PATH:" != *":$BIN_PATH:"* ]]; then
        echo "Adding $BIN_PATH to PATH..."
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
        if [ -f "$HOME/.zshrc" ]; then
            echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
        fi
        export PATH="$HOME/.local/bin:$PATH"
    fi
    
    echo "#!/bin/bash" > "$BIN_PATH/cipher-md"
    echo "cd \"$(pwd)\"" >> "$BIN_PATH/cipher-md"
    echo "node start.js" >> "$BIN_PATH/cipher-md"
    chmod +x "$BIN_PATH/cipher-md"
    
    echo "#!/bin/bash" > "$BIN_PATH/cipher-env"
    echo "nano \"$(pwd)/.env\"" >> "$BIN_PATH/cipher-env"
    chmod +x "$BIN_PATH/cipher-env"
    
    BOTRUN_PATH="$DESKTOP_PATH/cipher-md.sh"
    echo "#!/bin/bash" > "$BOTRUN_PATH"
    echo "cipher-md" >> "$BOTRUN_PATH"
    chmod +x "$BOTRUN_PATH"

    EDIT_ENV_PATH="$DESKTOP_PATH/cipher-env.sh"
    echo "#!/bin/bash" > "$EDIT_ENV_PATH"
    echo "cipher-env" >> "$EDIT_ENV_PATH"
    chmod +x "$EDIT_ENV_PATH"

    # AI Agent Integration
    if [ -d "skills" ]; then
        cp -r skills "$DESKTOP_PATH/" 2>/dev/null || true
    fi
    cp *.md "$DESKTOP_PATH/" 2>/dev/null || true

    echo "Setup complete! Starting the bot..."
    node start.js
    exit 0
fi

echo "Node.js could not be installed. Checking for Docker..."
if command -v docker &> /dev/null; then
    echo "Docker is installed. Using Docker..."
    echo "Building Docker image..."
    docker build -t cipher-md .
    
    echo "Starting Docker container..."
    # Remove existing container if it exists
    docker rm -f cipher-md &> /dev/null
    docker run -d --name cipher-md --env-file .env cipher-md

    echo "Setting up global commands and Desktop shortcuts..."
    
    BIN_PATH="$HOME/.local/bin"
    mkdir -p "$BIN_PATH"
    
    echo "#!/bin/bash" > "$BIN_PATH/cipher-md"
    echo "docker start cipher-md" >> "$BIN_PATH/cipher-md"
    chmod +x "$BIN_PATH/cipher-md"
    
    echo "#!/bin/bash" > "$BIN_PATH/cipher-env"
    echo "nano \"$(pwd)/.env\"" >> "$BIN_PATH/cipher-env"
    echo "echo 'After saving, please restart the Docker container to apply changes.'" >> "$BIN_PATH/cipher-env"
    chmod +x "$BIN_PATH/cipher-env"
    
    echo "#!/bin/bash" > "$BIN_PATH/cipher-stop"
    echo "docker stop cipher-md" >> "$BIN_PATH/cipher-stop"
    chmod +x "$BIN_PATH/cipher-stop"
    
    echo "#!/bin/bash" > "$BIN_PATH/cipher-restart"
    echo "docker restart cipher-md" >> "$BIN_PATH/cipher-restart"
    chmod +x "$BIN_PATH/cipher-restart"
    
    BOTRUN_PATH="$DESKTOP_PATH/cipher-md.sh"
    echo "#!/bin/bash" > "$BOTRUN_PATH"
    echo "cipher-md" >> "$BOTRUN_PATH"
    chmod +x "$BOTRUN_PATH"

    EDIT_ENV_PATH="$DESKTOP_PATH/cipher-env.sh"
    echo "#!/bin/bash" > "$EDIT_ENV_PATH"
    echo "cipher-env" >> "$EDIT_ENV_PATH"
    chmod +x "$EDIT_ENV_PATH"

    BOTSTOP_PATH="$DESKTOP_PATH/cipher-stop.sh"
    echo "#!/bin/bash" > "$BOTSTOP_PATH"
    echo "cipher-stop" >> "$BOTSTOP_PATH"
    chmod +x "$BOTSTOP_PATH"

    BOTRESTART_PATH="$DESKTOP_PATH/cipher-restart.sh"
    echo "#!/bin/bash" > "$BOTRESTART_PATH"
    echo "cipher-restart" >> "$BOTRESTART_PATH"
    chmod +x "$BOTRESTART_PATH"

    # AI Agent Integration
    AGENT_SKILL_DIR="$DESKTOP_PATH/Cipher-MD"
    mkdir -p "$AGENT_SKILL_DIR"
    
    cat <<EOF > "$AGENT_SKILL_DIR/SKILL.md"
---
name: manage-cipher-md
description: Manages the Cipher-MD WhatsApp Bot. Use this skill to start, stop, restart the bot or edit the environment variables.
---

# Cipher-MD Management Skill
You are in a workspace that manages a Cipher-MD WhatsApp Bot.

## Available Commands
- \`cipher-md\`: Starts the bot.
- \`cipher-env\`: Opens the \`.env\` file for editing.
- \`cipher-stop\`: Stops the bot (Docker only).
- \`cipher-restart\`: Restarts the bot (Docker only).
EOF

    cat <<EOF > "$DESKTOP_PATH/AGENTS.md"
# Cipher-MD Agent Workspace
This workspace contains shortcuts and documentation for the Cipher-MD bot.
Please refer to the skill at \`Cipher-MD/SKILL.md\` for management commands.
EOF

    cp *.md "$DESKTOP_PATH/" 2>/dev/null || true

    echo "Setup complete! Bot is running in Docker background."
    exit 0
fi

echo "Error: Neither Node.js nor Docker is installed. Please install one of them to run the bot."
exit 1
