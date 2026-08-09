---
name: manage-cipher-md
description: Manages the Cipher-MD WhatsApp Bot. Use this skill to start, stop, restart the bot or edit the environment variables.
---

# Cipher-MD Management Skill

You are in a workspace that manages a Cipher-MD WhatsApp Bot. The bot has been installed globally on this system.

## Available Commands

- `cipher-md`: Starts the bot (or Docker container).
- `cipher-env`: Opens the `.env` file for editing. After saving, restart the bot.
- `cipher-stop`: Stops the bot (Docker only).
- `cipher-restart`: Restarts the bot (Docker only).

## Instructions for Agents

1. **Start the Bot**: If the user wants to start or run the bot, execute the `cipher-md` command in the terminal.
2. **Edit Settings**: If the user wants to change environment variables or settings, run `cipher-env`. This opens the `.env` file in the default text editor (e.g., Notepad/nano).
3. **Stop the Bot**: If running via Docker, you can stop the container by running `cipher-stop`.
4. **Restart the Bot**: If running via Docker, you can restart the container by running `cipher-restart`.

## Environment Variables (`.env`) Reference

When the user asks you to update settings or environment variables, use the `cipher-env` command and edit the variables according to this list:

- **SESSION_ID**: The WhatsApp Session ID (Required).
- **PAIRING_NUMBER**: The phone number used to get the pairing code (Required, format: 947xxxxxxxx).
- **MONGO_URL**: MongoDB Database connection URL (Required).
- **OWNER_NUMBER**: The bot owner's phone number (Optional, format: 947xxxxxxxx).
- **GROQ_API_KEY**: Groq API Key (Optional, can be comma-separated for multiple).
- **GEMINI_API_KEY**: Gemini AI API Key (Optional).
- **FIRECRAWL_API_KEY**: Firecrawl API Key (Optional).
- **HF_TOKEN**: HuggingFace Token (Optional).
- **NASA_API_KEY**: NASA API Key (Optional).
- **RAPID_API_KEY**: RapidAPI Key (Optional).
- **SYNTIOX_API_KEY**: Syntiox API Key (Optional).
- **VT_API_KEY**: VirusTotal API Key (Optional).
- **BOT_NAME**: Name of the WhatsApp Bot (Optional, default: CIPHER-MD).
- **FOOTER**: Footer text for messages (Optional, default: Powered by Syntiox).
- **MENU_IMAGE**: Direct link for the menu image (Optional).
- **AI_CHAT_PLATFORM**: Platform for AI chat (google, groq, openai).
- **AI_CHAT_MODEL**: Model for AI chat (e.g., gemini-3.1-flash-lite).
- **AI_AGENT_PLATFORM**: Platform for AI agent.
- **AI_AGENT_MODEL**: Model for AI agent.
- **GOOGLE_CREDENTIALS**: Google API credentials (JSON format in single line).
- **GOOGLE_TOKEN**: Google API token (JSON format in single line).

---

> [!WARNING]
> **END-USER LICENSE AGREEMENT (EULA) & PERMISSIONS**
> According to the End-User License Agreement (`LICENSE.md`), AI Agents DO NOT have permission to modify the core source code of this bot unless explicitly authorized by the developer (`sh4lu-z`). Your role as an agent is strictly limited to **starting, stopping, and configuring environment variables**. Do not attempt to de-obfuscate, reverse engineer, or rewrite the core bot logic.
