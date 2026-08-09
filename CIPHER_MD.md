# 📖 Cipher MD - Main Bot Wiki

Welcome to the **Cipher MD Main Wiki**. This guide covers all the core commands, AI features, fun commands, and utility tools available across the entire bot. 

*(For Group Management specific commands like `.kick` or Anti-Link, refer to the [Group Wiki](group_logic_wiki.md))*

---

## 📑 Table of Contents (පටුන)

1. [🤖 Artificial Intelligence (AI System)](#1-artificial-intelligence-ai-system)
2. [📋 Menus & Dashboards](#2-menus--dashboards)
3. [🔧 Core Utility Commands](#3-core-utility-commands)
4. [🎬 Media, Movies & Downloads](#4-media-movies--downloads)
5. [🎉 Entertainment & Fun](#5-entertainment--fun)
6. [👑 Owner Only Commands](#6-owner-only-commands)

---

## 🤖 1. Artificial Intelligence (AI System)

Cipher MD is equipped with an advanced Llama-based AI Router (Groq API) that automatically understands English, Sinhala, and Singlish. 

### 💬 Conversational AI
The bot does not need a specific command to chat. Simply mention the bot or reply to its messages to start a conversation.
* **Auto-Routing:** The AI automatically categorizes your request (Coding, Translation, Math, General Chat, Medical, etc.) and applies the correct persona.
* **Master Mode:** If the Bot Owner talks to it, it recognizes them as "Master".
* **Memory Clearing:** 
  * `#clear` - Command to clear the AI's short-term memory session (Owner only or specific context).

### ⚙️ AI Modes
* **Normal AI Mode (`ai_chat`):** Standard conversational AI for general knowledge and chat.
* **Agent AI Mode (`ai_agent`):** Can perform advanced reasoning and tasks.

*(AI modes can be toggled via the main settings panel in `index`).*

---

## 📋 2. Menus & Dashboards

How to navigate and control the bot's features using the built-in system panels.

### 📜 Main Command Menus
* **`.menu` / `.cmd`** - Displays the Main Global Menu with a list of core features and their toggle status (🌍 Public / 🔒 Private).
  * Shows status of: Song, Video, TikTok, FB, Spotify, Weather, Sticker, Auto-React, System Engine, AI Modes.
* **`.cmd group` / `.menu group`** - Displays the Group Global Panel with group-specific toggles.
  * Shows status of: Welcome, Games, Rank, Extras, Playlist, etc.

*(When you use these commands, the bot replaces system variables with visually appealing emojis (✅/❌) to show exactly what is currently active in the database).*

---

## 🔧 3. Core Utility Commands

Tools to make life easier directly from WhatsApp.

### 🔍 Search & OS Tools
* **`.google <query>`** - Performs a Google search and returns the top result link.
* **`.define <word>`** - Dictionary search with phonetic pronunciation and examples.
* **`.true <number>`** - Truecaller search to identify unknown callers globally (e.g., `.true 9477xxxxxxx`).
* **`.github <username>`** - GitHub Stalker. Shows bio, public repos, followers, and account creation date.

### 🛡️ Security & Links
* **`.safe <link>` / `.safefull <link>`** - Cyber Security Audit. Scans URLs for viruses, phishing, and malware using 60+ security engines.
* **`.short <link>`** - Link Shortener. Compresses long URLs using multiple backup servers.
* **`.qr <text/link>`** - Generates a scannable QR Code from your text or link.

### 📈 Data & Math (Syntiox Graph Engine)
* **`.graph <equation>`** - Generates math graphs (e.g., `.graph x^2 + 5x`).
* **`.graph <type> <labels> = <values>`** - Generates data charts (pie, bar, line, scatter). 
  * *Example:* `.graph pie Win, Mac, Linux = 60, 30, 10`

---

## 🎬 4. Media, Movies & Downloads

Advanced modules for downloading and manipulating media (`media_logic.js`, `movie_logic.js`).

### 🍿 Movie Downloader
* **`.movie <Movie Name>`** - Searches for a movie and returns available qualities.
  * *Features:* Direct Google Drive upload, Instant Play links (VLC/MX Player compatible), bypasses 2GB WhatsApp limits by providing external links.

### 📥 Video, Audio & File Downloaders
* **`.ss <url>` / `.sv <url>`** - General Song and Video downloader.
* **`.tiktok <url>`** - Downloads TikTok videos without the watermark.
* **`.glink <url>` / `.mega <url>`** - Downloads files directly from Google Drive and Mega.nz.
* **`.apk <app name>`** - Searches and downloads Android APK files.
* **`.xvdl <video link>`** - Dedicated downloader for adult/NSFW videos (e.g., PornHub, XVideos) with quality selection.

### 🎧 Cipher Audio Studio
Reply to an audio file and type one of these commands to add effects:
* **`.bass`** (or `.bass 50`, `.bass edm/car/slap`)
* **`.8d`, `.slow`, `.reverse`, `.deep`, `.nightcore`, `.blown`, `.robot`, `.surround`**
* **`.trim <start_sec> <end_sec>`** - Trims the audio file (e.g., `.trim 30 90`).

### 🖼️ Image Tools
* **`.img enhance`** - Upscales and improves image quality to 4K (Reply to an image).
* **`.img gen <style> <prompt>`** - AI Image Generation (e.g., `.img gen 3d a cute cat`).
* **`.img scan`** - Security scan on images to reveal hidden details.

---

## 🎉 5. Entertainment & Fun

Keep the group engaged and active.

### 🎂 Birthday System (`birthday_logic.js`)
* Fully automated Birthday tracking logic. The bot can remember birthdays and automatically sends beautifully formatted wishes when the day arrives.

### 🧠 Trivia & Facts
* **`.fact`** - Sends amazing, random true facts about the world.
* **`.quiz`** - Generates an interactive space-themed WhatsApp poll quiz.

### ✨ Styling & Customization
* **`.fancy <style_number> <text>`** - Converts normal text into aesthetic fancy fonts.
* **`.getdp <mention/number>`** - Extracts and sends the high-quality profile picture of the requested user.

---

## 👑 6. Owner Only Commands

Powerful commands restricted strictly to the bot owner.

* **`.system`** - Displays a comprehensive System Dashboard showing Network Speed (Ping, DL/UL), RAM usage, CPU Cores, and Server Uptime.
* **`.ramcheck`** - Views the top 15 running processes and their RAM usage on the host server.
* **`.clear`** - Cleans all past messages on the bot's side.
* **`.reset`** - Instantly fetches the latest code from the server and Force Restarts the bot without waiting.
* **`.sbc <message>`** - Human-Style Broadcast. Sends a message to all groups and users safely to prevent WhatsApp bans.
* **`.addchannel <tag> <link>`** - Adds a WhatsApp channel to the bot's database with a tag.
* **`.send <tag> <caption>`** - Forwards a replied image directly to a saved channel.
