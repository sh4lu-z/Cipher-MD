# CIPHER-MD - AI Development & Setup Guide

This document is a comprehensive guide specifically designed for **AI Assistants and Developers** working on the CIPHER-MD WhatsApp Bot. It contains the exact architecture, environment setup, and system rules required to set up and develop for this bot.

## 📌 1. Project Overview
- **Name:** CIPHER-MD
- **Type:** Advanced WhatsApp AI Bot Core Engine
- **Base Library:** `@whiskeysockets/baileys` (for WhatsApp connection)
- **AI Platforms:** Google (Gemini), Groq, OpenAI
- **Key Features:** Autonomous AI Agents (Web browsing, Gmail/Calendar management, Document parsing), Speech-to-Text, Media Processing (Stickers, Image Generation).

> **🛑 CRITICAL: DRM & INTEGRITY PROTOCOL**
> The bot contains a built-in DRM mechanism. **DO NOT** tamper with the core engine protection, source code integrity checks, or the `LICENSE.md` file. Doing so will trigger a self-lock and halt the bot's operation.

---

## ⚙️ 2. Complete Setup Instructions

### Step 1: Prerequisites
- **Node.js:** v18.0.0 or higher
- **FFmpeg & Sharp:** Required for media processing (Stickers, Audio, Video).
- **Database:** MongoDB (Mandatory for core data).

### Step 2: WhatsApp Session Setup
The bot requires a valid WhatsApp session to run.
1. The user must obtain a `SESSION_ID` via [Syntiox Connect](https://cipher-md.syntiox.top/connect).
2. The user will use their `PAIRING_NUMBER` to link the bot to their WhatsApp account.

### Step 3: Environment Configuration (`.env`)
The `.env` file must be created based on `sample.env`. 

> **💡 AI GUIDANCE:** If you (the AI) need to see ALL exact required and optional `.env` variables for this project, you MUST read the official sample environment file here: `https://raw.githubusercontent.com/sh4lu-z/Cipher-MD/main/sample.env`

Below are the most critical variables the AI should know about:

**Core Variables (Required):**
- `SESSION_ID` : The unique WhatsApp session string.
- `PAIRING_NUMBER` : Phone number used to get the pairing code (e.g., 947xxxxxxxx).
- `MONGO_URL` : MongoDB connection string.

**AI & Third-Party APIs (Optional but recommended):**
- `GEMINI_API_KEY` : For Google Gemini models.
- `GROQ_API_KEY` : For Groq models (can be comma-separated).
- `FIRECRAWL_API_KEY`, `HF_TOKEN`, `NASA_API_KEY`, `RAPID_API_KEY`, `SYNTIOX_API_KEY`, `VT_API_KEY`.

**Bot Customization:**
- `BOT_NAME`, `OWNER_NUMBER`, `FOOTER`, `MENU_IMAGE`.
- `AI_CHAT_PLATFORM` & `AI_AGENT_PLATFORM`: Can be `google`, `groq`, or `openai`.
- `AI_CHAT_MODEL` & `AI_AGENT_MODEL`: Specific model names (e.g., `gemini-3.1-flash-lite`).

**Agentic Tasks (Google Services integration):**
For Gmail, Calendar, and Drive integrations, the following must be provided as single-line JSON strings:
- `GOOGLE_CREDENTIALS` : (Obtained from Google Cloud Console)
- `GOOGLE_TOKEN` : (Generated locally)

> **How to get the `GOOGLE_TOKEN`:**
> After obtaining your `GOOGLE_CREDENTIALS`, you must generate the `GOOGLE_TOKEN` on your local PC. 
> Download the script `get_google_token.ps1` (for Windows) or `get_google_token.sh` (for Linux/Mac) from the repository and run it. 
> This script will open your browser for Google login, and then it will generate and display the exact single-line JSON string you need to paste as your `GOOGLE_TOKEN`.

### Step 4: Installation & Deployment
There are multiple ways to deploy and run the bot based on your environment.

#### Auto Installer (Recommended for VPS / Local PC)
The Auto Installer automatically sets up the bot and creates handy shortcuts for you on your Desktop (inside a "cipher md" folder) and as Global Terminal Commands!
- **macOS / Linux & Termux:**
  ```bash
  curl -sL https://cipher-md.syntiox.top/install.sh -o install.sh && bash install.sh
  ```
- **Windows PowerShell:**
  ```powershell
  irm https://cipher-md.syntiox.top/install.cmd -OutFile install.cmd ; .\install.cmd
  ```
- **Windows CMD:**
  ```cmd
  curl -sL https://cipher-md.syntiox.top/install.cmd -o install.cmd && install.cmd && del install.cmd
  ```

#### Post-Installation Shortcuts
After using the Auto Installer, use these global terminal commands:
- `cipher-md` : Starts the bot (or the Docker container if using Docker).
- `cipher-env` : Opens `.env` file for editing.
*(If using Docker, `cipher-stop` and `cipher-restart` are also available).*

#### Manual Deployment (Node.js)
1. **Install dependencies:** `npm install`
2. **Generate Google Tokens (Optional):** Run `get_google_token.ps1` (Windows) or `get_google_token.sh` (Linux) if agentic tasks are needed.
3. **Start Bot:** `npm start` (executes `node start.js`).

#### Other Platforms
- **Termux (Android):** Download from F-Droid, update packages, and run the Linux auto-installer.
- **Docker:** `docker-compose up -d`
- **Cloud Hosting:** Deploy directly via 1-click buttons for Koyeb, Heroku, or Railway (see official docs).

---

## 🧠 3. Developer & AI Assistant Guidelines

When writing code or assisting with CIPHER-MD, the AI must follow these rules:

1. **Baileys Asynchronous Flow:** All Baileys socket events and message handlers are asynchronous. Always use `async/await`.
2. **Configuration Management:** Global configs are handled in `config.js`. Do not hardcode values in scripts; always map them from `.env` through `config.js`.
3. **Media Handling:** Rely on `ffmpeg` and `sharp` for image/video/audio manipulation as defined in `package.json`.
4. **Agentic Features:** When building agents, ensure you parse the `GOOGLE_CREDENTIALS` and `GOOGLE_TOKEN` correctly from the environment.
5. **Prompting & Logic:** Core AI instructions are managed in `prompt.txt`. Update this file if the core behavior of the AI agent needs modification.

---

## 🛠️ 4. Troubleshooting & Common Errors

If you encounter issues during deployment or development, consider the following fixes:

1. **Session ID Errors / Bot Not Connecting:**
   - **Fix:** If the `SESSION_ID` is invalid or expired, go to Linked Devices in WhatsApp on your phone, log out of the bot's session, and generate a new `SESSION_ID` from the Connect page.

2. **MongoDB Connection Issues:**
   - **Fix:** Ensure your MongoDB Network Access (IP Whitelist) is set to `0.0.0.0/0` (Allow access from anywhere). If it is restricted to your local IP, cloud deployments (Koyeb/Heroku/Docker) will fail to connect.

---
*End of Development Guide*
