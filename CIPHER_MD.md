# 📖 Cipher MD - Complete Wiki

Welcome to the **Cipher MD Complete Wiki**. This guide covers all the core commands, AI features, fun commands, utility tools, and group management features available across the entire bot.

---

## 📑 Table of Contents (පටුන)

1. [🤖 Artificial Intelligence (AI System)](#1-artificial-intelligence-ai-system)
2. [📋 Menus & Dashboards](#2-menus--dashboards)
3. [🔧 Core Utility Commands](#3-core-utility-commands)
4. [🎬 Media, Movies & Downloads](#4-media-movies--downloads)
5. [🎉 Entertainment & Fun](#5-entertainment--fun)
6. [👑 Owner Only Commands](#6-owner-only-commands)
7. [🛡️ Security & Protection (Anti-Systems)](#7-security--protection-anti-systems)
8. [👥 Group Administration (ගෲප් පාලනය)](#8-group-administration-ගරප-පලනය)
9. [⚠️ Warning System (අවවාද කිරීම)](#9-warning-system-අවවද-කරම)
10. [⚙️ Automation & Auto-Media (ස්වයංක්‍රීය පද්ධති)](#10-automation--auto-media-සවයකරය-පදධත)
11. [📈 Market & Crypto System (වෙළඳපොළ සහ ක්‍රිප්ටෝ)](#11-market--crypto-system-වළඳපළ-සහ-කරපට)
12. [📰 Live News System (පුවත්)](#12-live-news-system-පවත)
13. [🚀 NASA Space System (අභ්‍යවකාශ තොරතුරු)](#13-nasa-space-system-අභයවකශ-තරතර)
14. [🕹️ Group Fun, Utilities & Games (විනෝදාත්මක)](#14-group-fun-utilities--games-වනදතමක)
15. [🔒 Bot Control & Dashboard (බොට් පාලනය)](#15-bot-control--dashboard-බට-පලනය)
16. [🔗 Official Links & Resources (නිල සබැඳි)](#16-official-links--resources-නල-සබඳ)

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

---

## 🛡️ 7. Security & Protection (Anti-Systems)

These systems automatically monitor the group and punish users who violate the rules.

### 🔗 Anti-Link System
* **Command:** `.antilink` (Alias: `.alink`)
* **Description:** Automatically deletes any WhatsApp group links or untrusted links sent by members.
* **Whitelist (Allowed Links):** 
  > [!NOTE]
  > Links from trusted platforms are **ignored** and will NOT be deleted. These include:
  > *Google, YouTube, Facebook, Instagram, Twitter, TikTok, Telegram, Discord, Reddit, Github, StackOverflow, Vercel, Heroku, Firebase, Mediafire, Mega, Drive, ChatGPT, Deepseek*

### 🤬 Anti-Badword (Profanity Filter)
* **Command:** `.antibadword` (Alias: `.abw`)
* **Description:** Deletes messages containing offensive words.
* **How to Add Words:**
  Use the `.addbadword` command followed by the words separated by commas.
  ```text
  .addbadword ugly, stupid, idiot
  ```
  > [!TIP]
  > Words added here are saved directly to the Global Database and apply immediately.

### 🌊 Anti-Flood (Spam Protection)
* **Command:** `.antiflood` (Alias: `.aflood`)
* **Description:** Prevents users from spamming the group with messages.
* **How it works:** If a normal user sends more than **5 messages within 3 seconds**, the bot will instantly delete their messages and **Kick** them from the group.

### 🎭 Anti-Fake
* **Command:** `.antifake` (Alias: `.afake`)
* **Description:** Provides security against virtual or foreign numbers. It immediately kicks any user whose number starts with `+212`, `+92`, or `+1`.

### 👻 Anti-Ghost (Spam Tagging)
* **Command:** `.antighost` (Alias: `.aghost`)
* **Description:** Prevents annoying mass-tagging. If a normal user tags more than **5 people** in a single message, the bot will delete it.

### 🤖 Anti-Bot Systems
* **Light Mode (`.antibot` / `.abot1`):** Deletes messages sent by other bots in the group.
* **Hard Mode (`.antibothard` / `.abot2`):** Deletes messages from other bots AND kicks the bot sender immediately.

### ⌨️ Anti-Command Blocker
* **Command:** `.anticmd` (Alias: `.acmd`)
* **Description:** Restricts bot usage to Admins only. If a normal member tries to use commands (like `.ping`), they receive a warning.
  > [!WARNING]
  > Users are automatically **Kicked** upon reaching 3 command warnings.

---

## 👥 8. Group Administration (ගෲප් පාලනය)

Commands for Group Admins to manage members and group details easily.

### 👢 Member Control
* **`.kick @user`** (Aliases: `.k`, `.remove`) - Removes the tagged user from the group.
* **`.add 9471XXXXXXX`** (Alias: `.a`) - Adds the specified number to the group.
* **`.promote @user`** (Alias: `.p`) - Promotes a normal user to Admin.
* **`.demote @admin`** (Alias: `.d`) - Demotes an Admin to a normal user.

### 🔇 Mute Controls
* **`.mute`** (Alias: `.mt`) - Closes the group (Only Admins can send messages).
* **`.unmute`** (Alias: `.umt`) - Opens the group for all members.
* **`.tempmute <minutes>`** - Temporarily closes the group and automatically opens it after the given time.
  ```text
  .tempmute 10
  ```

### 📢 Tagging & Announcements
* **`.hidetag <message>`** (Alias: `.h`) - Tags everyone in the group without showing their numbers (Invisible tagging).
* **`.tagall <message>`** - Tags everyone by explicitly displaying their `@numbers` in a list.
* **`.tagadmins <message>`** - Tags only the Admins. Useful for reporting issues.

### ⚙️ Group Settings
* **`.setname <New Name>`** - Changes the Group's Subject.
* **`.setdesc <New Description>`** - Changes the Group's Description.
* **`.setwelcome <Message>`** - Updates the custom message sent when someone joins.
* **`.glink`** - Retrieves the current invite link.
* **`.revoke`** - Resets/Changes the invite link.
* **`.resetgroup`** - Erases all configurations and resets the group back to default settings.

### 🗑️ Message Deletion
* **`.delete`** (Alias: `.del`) - Reply to any message with `.del` and the bot will delete it.

---

## ⚠️ 9. Warning System (අවවාද කිරීම)

A fully integrated warning system stored directly in the database.

* **`.warn @user`** - Adds 1 warning to the tagged user. 
  > [!CAUTION]
  > Once a user accumulates **3 warnings**, they are automatically kicked.
* **`.resetwarn @user`** - Resets the user's warnings back to 0.
* **`.mywarns`** - A public command that allows anyone to check how many warnings they currently have.

---

## ⚙️ 10. Automation & Auto-Media (ස්වයංක්‍රීය පද්ධති)

These are background tasks the bot handles automatically once enabled.

### 👋 Welcome System
* **`.welcome`** (Alias: `.wel`) - Toggles the Welcome Image & Message for new members.
* **`.wcdesc`** - When enabled, the bot will also send the group's rules (Group Description) alongside the welcome message.

### 📥 Auto Media Downloaders
When enabled, simply pasting a link triggers the bot to download it automatically:
* **`.autotiktok`** (`.att`) - Auto downloads TikTok videos.
* **`.autofb`** (`.afb`) - Auto downloads Facebook videos.
* **`.autospotify`** (`.asp`) - Auto downloads Spotify songs.
* **`.playlist`** (`.plist`) - Pasting a YouTube Playlist link will automatically extract and download the first 10 songs.

### 🗣️ Auto Translate
* **Command:** `.autotranslate <target_language>`
* **Description:** Automatically detects the language of foreign messages and translates them to your specified language.
  ```text
  .autotranslate en   (Translates foreign text to English)
  .autotranslate si   (Translates foreign text to Sinhala)
  .autotranslate off  (Disables auto-translation)
  ```

---

## 📈 11. Market & Crypto System (වෙළඳපොළ සහ ක්‍රිප්ටෝ)

A fully-featured market tracking system with visual charts and history tracking.

> [!NOTE]
> Some features may require **Premium Access/Permissions** assigned by the Bot Owner via the `.market` master command.

### 🪙 Crypto & Market Indicators
* **`.crypto on/off`** - Enables or disables automated Crypto tracking (Pumps & Dumps, Top 20 Binance).
  
  **Currently Tracked Coins (Top 20):**
  ```javascript
  const coins = [
      'btcusdt', 'ethusdt', 'bnbusdt', 'solusdt', 'xrpusdt',
      'dogeusdt', 'adausdt', 'trxusdt', 'maticusdt', 'shibusdt',
      'ltcusdt', 'dotusdt', 'avaxusdt', 'linkusdt', 'uniusdt',
      'atomusdt', 'ftmusdt', 'nearusdt', 'sandusdt', 'manausdt'
  ];
  ```
* **`.fear`** (Alias: `.fg`) - Displays the current **Fear & Greed Index** for Crypto, complete with a historical chart.

### 💰 Finance & Forex Rates
* **`.dollar`** (Alias: `.forex`) - Fetches the live CBSL Exchange Rate (USD to LKR) and visualizes the past rate history as a chart.
* **`.gold`** (Alias: `.goldprice`) - Fetches the live spot price of Gold per Ounce and calculates the 24K and 22K prices per Pound (පවුම) in Sri Lanka.

### 📉 Colombo Stock Exchange (CSE)
* **`.cse`** (Alias: `.stock`) - Gets the latest data from the Colombo Stock Exchange (ASPI & S&P SL20 Index), along with a visual trend chart.

### 🤖 Arbitrage & NFTs
* **`.arb <on/off/coin_name>`** - Scans multiple exchanges for Arbitrage opportunities on a given coin (e.g., `.arb BTC`).
* **`.nft <on/off/slug>`** - Tracks real-time NFT collection statistics via OpenSea (e.g., `.nft boredapeyachtclub`).

---

## 📰 12. Live News System (පුවත්)

Automatically fetch and send the latest news from Sri Lanka (Esana News).

* **`.news on`** - Activates the Auto News system in your group. Whenever a new breaking news is posted, the bot will instantly forward it to the group with the cover image.
* **`.news off`** - Deactivates the Auto News system.
* **`.news test`** - Instantly fetches the latest news article as a test.

---

## 🚀 13. NASA Space System (අභ්‍යවකාශ තොරතුරු)

Brings the universe into your WhatsApp group! Sends random, educational space facts and images automatically or via command.

* **`.nasa on`** - Activates the NASA automatic updates for the group. The bot will send random Space features.
* **`.nasa off`** - Deactivates the NASA automatic updates.

**Features inside the NASA System include:**
* 🌌 **Astronomy Picture of the Day (APOD):** Breathtaking space images with detailed explanations.
* 🔴 **Mars Rover Feed:** Random pictures from Curiosity on Mars.
* ☄️ **Asteroid Radar:** Reports on near-earth hazardous objects.
* 🌍 **EPIC:** Photos of Earth taken from a million miles away.
* 🌗 **Moon Phase:** Current lunar cycle and mood.
* 🛰️ **ISS Tracker Live:** Real-time speed and coordinates of the Space Station.
* 🔥 **Solar Flare Warnings:** Real-time updates on Sun activity.
* ❓ **NASA Space Quiz:** Interactive space-themed WhatsApp Polls to test your knowledge!

---

## 🕹️ 14. Group Fun, Utilities & Games (විනෝදාත්මක)

Commands available for all users (if `.games` and `.extras` are enabled).

### 💤 AFK (Away From Keyboard)
* **`.afk <reason>`** (Alias: `.setafk`) - Sets your status to AFK. If anyone tags you while you are away, the bot will notify them.
  ```text
  .afk Sleeping, do not disturb!
  ```
  *Your AFK status is automatically removed the next time you send a message.*

### 🛠️ Utilities
* **`.ginfo`** - Displays an advanced dashboard of Group Information (Owner, Admin count, total members).
* **`.conv <value> <from> <to>`** - Unit Converter.
  ```text
  .conv 10 kg lbs  (Converts 10 Kilograms to Pounds)
  ```
* **`.poll <Question> | <Opt1>, <Opt2>`** - Generates a WhatsApp native poll.
* **`.pick <Opt1>, <Opt2>`** - Asks the bot to randomly pick a choice for you.

### 🎮 Games
* **`.math`** - Generates a simple math puzzle for the group to solve.
* **`.ship @user`** - A fun "Love Calculator" between you and the tagged user.

---

## 🔒 15. Bot Control & Dashboard (බොට් පාලනය)

Commands exclusively for Group Admins to control the bot's behavior.

### 🎛️ Admin Panel
* **Command:** `.panel` (Alias: `.admin`)
* **Description:** Generates a visually appealing dashboard showing all active/inactive features in the group, and sends it directly to your Inbox (Private Message).

### ⏰ Auto Timer
* **Command:** `.auto <Start_Time>,<End_Time>`
* **Description:** Sets a schedule for when the bot should be active in the group.
  ```text
  .auto 07:30,22:00
  ```
* **`.timer on/off`** - Quickly toggles the configured schedule on or off.

### 🔓 Lock / Unlock State
* **`.lock @BotName`** - Puts the bot in sleep mode for the group. It will stop responding to normal users.
* **`.unlock @BotName`** - Wakes the bot up.

### 💻 Cyber Hack (Terminal Simulation)
* **Command:** `.hack @user`
* **Description:** A purely cosmetic, visual simulation of a "Cyber Attack" on the tagged user. It edits the message dynamically to look like a hacking terminal. Only for Admins to have fun.

---

## 🔗 16. Official Links & Resources (නිල සබැඳි)

* 🌐 **Official Website:** [https://cipher-md.syntiox.top/](https://cipher-md.syntiox.top/)
* 📖 **Main Documentation:** [README.md](https://github.com/sh4lu-z/Cipher-MD/blob/main/README.md)
* 📜 **License:** [LICENSE.md](https://github.com/sh4lu-z/Cipher-MD/blob/main/LICENSE.md)
* 🛡️ **Security Policy:** [SECURITY.md](https://github.com/sh4lu-z/Cipher-MD/blob/main/SECURITY.md)
* 🤝 **Code of Conduct:** [CODE_OF_CONDUCT.md](https://github.com/sh4lu-z/Cipher-MD/blob/main/CODE_OF_CONDUCT.md)
