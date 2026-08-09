# 📖 Cipher MD - Group Wiki

Welcome to the **Cipher MD Group Wiki**. This documentation provides a comprehensive, in-depth guide on every feature, command, and automated system managed by the bot inside WhatsApp groups.

> [!IMPORTANT]
> **Admin Privileges Required:** Most of the moderation commands (such as `.kick`, `.mute`, `.delete`) require the bot's phone number to be promoted to **Group Admin** in WhatsApp.

---

## 📑 Table of Contents (පටුන)

1. [🛡️ Security & Protection (Anti-Systems)](#1-security--protection-anti-systems)
2. [👥 Group Administration (ගෲප් පාලනය)](#2-group-administration-ගරප-පලනය)
3. [⚠️ Warning System (අවවාද කිරීම)](#3-warning-system-අවවද-කරම)
4. [⚙️ Automation & Auto-Media (ස්වයංක්‍රීය පද්ධති)](#4-automation--auto-media-සවයකරය-පදධත)
5. [📈 Market & Crypto System (වෙළඳපොළ සහ ක්‍රිප්ටෝ)](#5-market--crypto-system-වළඳපළ-සහ-කරපට)
6. [📰 Live News System (පුවත්)](#6-live-news-system-පවත)
7. [🚀 NASA Space System (අභ්‍යවකාශ තොරතුරු)](#7-nasa-space-system-අභයවකශ-තරතර)
8. [🕹️ Fun, Utilities & Games (විනෝදාත්මක)](#8-fun-utilities--games-වනදතමක)
9. [🔒 Bot Control & Dashboard (බොට් පාලනය)](#9-bot-control--dashboard-බට-පලනය)

---

## 🛡️ 1. Security & Protection (Anti-Systems)

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

## 👥 2. Group Administration (ගෲප් පාලනය)

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

## ⚠️ 3. Warning System (අවවාද කිරීම)

A fully integrated warning system stored directly in the database.

* **`.warn @user`** - Adds 1 warning to the tagged user. 
  > [!CAUTION]
  > Once a user accumulates **3 warnings**, they are automatically kicked.
* **`.resetwarn @user`** - Resets the user's warnings back to 0.
* **`.mywarns`** - A public command that allows anyone to check how many warnings they currently have.

---

## ⚙️ 4. Automation & Auto-Media (ස්වයංක්‍රීය පද්ධති)

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

## 📈 5. Market & Crypto System (වෙළඳපොළ සහ ක්‍රිප්ටෝ)

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

## 📰 6. Live News System (පුවත්)

Automatically fetch and send the latest news from Sri Lanka (Esana News).

* **`.news on`** - Activates the Auto News system in your group. Whenever a new breaking news is posted, the bot will instantly forward it to the group with the cover image.
* **`.news off`** - Deactivates the Auto News system.
* **`.news test`** - Instantly fetches the latest news article as a test.

---

## 🚀 7. NASA Space System (අභ්‍යවකාශ තොරතුරු)

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

## 🕹️ 8. Fun, Utilities & Games (විනෝදාත්මක)

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

## 🔒 9. Bot Control & Dashboard (බොට් පාලනය)

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
