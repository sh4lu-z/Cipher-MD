#!/bin/bash

echo -e "\e[1;32m===========================================\e[0m"
echo -e "\e[1;36m      CIPHER MD - Core Installer   \e[0m"
echo -e "\e[1;32m===========================================\e[0m"

# Package Update & Install Core Dependencies
if command -v pkg &> /dev/null; then
    # Termux Environment
    echo -e "\e[1;33m[1/2] Updating Termux packages...\e[0m"
    pkg update -y && pkg upgrade -y
    
    echo -e "\e[1;33m[2/2] Requesting storage access & Installing core dependencies...\e[0m"
    termux-setup-storage
    sleep 2
    pkg install nodejs ffmpeg make wget -y
else
    # Regular Linux Environment (Ubuntu/Debian etc.)
    echo -e "\e[1;33m[1/2] Updating System packages...\e[0m"
    sudo apt update -y
    echo -e "\e[1;33m[2/2] Installing core dependencies (NodeJS, npm, FFmpeg)...\e[0m"
    sudo apt install nodejs npm ffmpeg make wget -y
fi

echo -e "\n\e[1;32m===========================================\e[0m"
echo -e "\e[1;32m   SYSTEM DEPENDENCIES INSTALLED!          \e[0m"
echo -e "\e[1;32m===========================================\e[0m\n"

echo -e "\e[1;36mNext steps to start the bot:\e[0m"
echo -e "  1. Run: \e[1;37mnpm install\e[0m"
echo -e "  2. Run: \e[1;37mnode setup.js\e[0m (To create .env)"
echo -e "  3. Run: \e[1;37mnpm start\e[0m\n"
