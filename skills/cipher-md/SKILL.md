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
