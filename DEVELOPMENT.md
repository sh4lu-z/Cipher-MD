# CIPHER-MD — Official Development & Deployment Specification

> **CRITICAL DIRECTIVE FOR AI ASSISTANTS (ChatGPT, Claude, Gemini, Cursor, Copilot):**
> 1. **DO NOT invent or install external libraries or npm packages.** All required packages are already defined and locked in `package.json`.
> 2. **DO NOT tamper with or modify `LICENSE.md`, integrity checks, or encryption logic in `start.js`.** Doing so triggers a fatal kernel error (`0x800421`) and bricks the bot.
> 3. **ALL necessary `.env` variables are completely documented inside this file below.** Do NOT skip reading them or assume external dependencies.
> 4. Follow the exact sequential deployment and configuration steps provided in this guide.

---

## 📌 1. Prerequisites (Mandatory Requirements)

Before deploying or running CIPHER-MD, ensure you have the following core assets:

1. **MongoDB Database (Mandatory):**
   - A valid MongoDB connection URI (`MONGO_URL`). The bot cannot initialize without MongoDB.
   - *Important:* In MongoDB Atlas, ensure Network Access (IP Whitelist) is configured to allow `0.0.0.0/0` (access from anywhere).
2. **Active WhatsApp Account:**
   - A working WhatsApp phone number to link the bot via pairing code or QR code.
3. **Hosting Environment (Any ONE of the following):**
   - **Local PC:** Windows (PowerShell/CMD), macOS, or Linux.
   - **VPS:** Linux server (Ubuntu, Debian, CentOS, etc.).
   - **Android Device:** Termux (installed strictly via F-Droid, not Google Play Store).
   - **Cloud Platforms:** Koyeb, Render, Railway, Heroku, or any Docker-compatible cloud host.

---

## 🔑 2. Obtain WhatsApp Session ID (`SESSION_ID`)

The bot requires an active session ID to authenticate with WhatsApp:

1. Navigate to the official pairing portal: **https://md.s4z.top/connect**
2. Enter your WhatsApp phone number with country code (e.g., `947xxxxxxxx`) to generate an 8-character pairing code, OR choose QR code scanning.
3. On your phone: Open WhatsApp → **Settings / Three Dots** → **Linked Devices** → **Link a Device** → Enter the pairing code or scan the QR.
4. Once linked, the portal delivers your unique `SESSION_ID` directly to your WhatsApp chat (starts with `CIPHER-MD~...`). Copy and save this string safely.

---

## 🛠️ 3. Pre-Deployment Customization (Optional)

Users can personalize the bot before deployment either manually or using an AI assistant:

- **AI Behavior & Personality (`prompt.txt`):**
  - Contains system prompts, WhatsApp formatting rules, creator protection, and command execution directives.
  - Edit `prompt.txt` to modify the bot's conversational style or assistant capabilities.
- **Bot Branding & Engine Settings (`config.js`):**
  - `BOT_NAME`: Custom name displayed across messages.
  - `CHANNEL_LINK`: Connect your WhatsApp Community or Newsletter channel.
  - `FOOTER`: Custom signature text appended to bot messages.
  - `MENU_IMAGE`: Direct URL for the `.menu` banner image.
  - `AI_CHAT_PLATFORM` / `AI_CHAT_MODEL`: Default chat model (e.g., `google` with `gemini-3.5-flash-lite`).

---

## 🚀 4. Deployment Methods

Choose the deployment method that fits your environment:

### Method A: Local PC / VPS / Termux (One-Line Automated Installers)

The auto-installer handles runtime dependencies, extracts components, sets up global CLI shortcuts, and launches an interactive environment setup wizard.

- **Linux, macOS, VPS, and Termux (Android):**
  ```bash
  curl -sL https://md.s4z.top/install.sh -o install.sh && bash install.sh
  ```

- **Windows (PowerShell):**
  ```powershell
  irm https://md.s4z.top/install.cmd -OutFile install.cmd ; .\install.cmd
  ```

- **Interactive Configuration Flow:**
  - The script will prompt you for `.env` variables directly in your terminal.
  - **Mandatory Variables:** You **MUST** enter `SESSION_ID`, `MONGO_URL`, and `PAIRING_NUMBER`.
  - **Optional Variables:** If you do not have specific API keys or wish to skip optional features, simply press **Enter** to skip.
  
- **Post-Install Global Commands:**
  - `cipher-md` : Start the bot anytime.
  - `cipher-env` : Re-open and modify your `.env` configuration.

---

### Method B: Cloud Platforms (Docker Deployment — Koyeb, Render, Railway, etc.)

For zero-maintenance cloud hosting:

1. **Fork the Repository:** Fork `https://github.com/sh4lu-z/Cipher-MD` to your personal GitHub account.
2. **Apply Customizations (Optional):** Edit `prompt.txt` or `config.js` in your forked repo as needed.
3. **Connect to Cloud Host:**
   - Create a new web service on your cloud provider (e.g. Koyeb, Render, Railway).
   - Link your GitHub account and select your forked `Cipher-MD` repository.
   - Choose **Docker** as the deployment builder (the cloud provider automatically detects the root `Dockerfile`).
4. **Configure Environment Variables:**
   - In the cloud dashboard's **Environment Variables** tab, enter the mandatory variables (`SESSION_ID`, `MONGO_URL`, `PAIRING_NUMBER`) and any optional API keys.
5. **Deploy:** Trigger deployment. The Docker container builds and launches the core engine.

---

## 📋 5. Environment Variables Reference (`.env`)

To utilize **100% of CIPHER-MD's capabilities**, provide all applicable keys below.

### Core Variables (Mandatory)
| Variable | Required | Description | Example |
| :--- | :---: | :--- | :--- |
| `SESSION_ID` | **YES** | Unique session string from https://md.s4z.top/connect | `CIPHER-MD~a1b2c3...` |
| `PAIRING_NUMBER` | **YES** | WhatsApp phone number with country code (digits only) | `947xxxxxxxx` |
| `MONGO_URL` | **YES** | MongoDB connection string (Atlas or self-hosted) | `mongodb+srv://user:pass@cluster.mongodb.net/?retryWrites=true&w=majority` |

### AI Engines & Third-Party APIs (Optional — Unlocks 100% Capabilities)
| Variable | Description |
| :--- | :--- |
| `GEMINI_API_KEY` | Google Gemini API key for primary chat and vision intelligence. |
| `GROQ_API_KEY` | Groq API key for ultra-fast Llama-3/Mixtral models (multiple keys separated by comma supported). |
| `FIRECRAWL_API_KEY` | Powers deep web search and URL content scraping for AI agents. |
| `HF_TOKEN` | Hugging Face access token for open-source AI models and spaces. |
| `NASA_API_KEY` | Fetches NASA Astronomy Picture of the Day (APOD) and space telemetry. |
| `RAPID_API_KEY` | Unlocks media downloaders and external utility APIs. |
| `SYNTIOX_API_KEY` | Integration with Syntiox cloud services ecosystem. |
| `VT_API_KEY` | VirusTotal API key for automated malware and file scanning. |

### Bot Customization & Appearance (Optional)
| Variable | Default Value | Description |
| :--- | :--- | :--- |
| `BOT_NAME` | `CIPHER-MD` | Display name of the WhatsApp bot. |
| `OWNER_NUMBER` | `947xxxxxxxx` | Phone number of the bot owner/administrator. |
| `FOOTER` | `Powered by Syntiox` | Custom caption footer attached to interactive replies. |
| `MENU_IMAGE` | Default banner URL | Direct link to image displayed on the `.menu` command. |
| `AI_CHAT_PLATFORM` | `google` | Platform for general conversation (`google`, `groq`, or `openai`). |
| `AI_CHAT_MODEL` | `gemini-3.5-flash-lite` | Specific model identifier for chat. |
| `AI_AGENT_PLATFORM`| `google` | Platform for autonomous task execution. |
| `AI_AGENT_MODEL` | `gemini-3.5-flash-lite` | Model identifier for autonomous agents. |

### Autonomous Google Workspace Agent (Optional)
For autonomous Gmail, Google Calendar, and Drive management:
- `GOOGLE_CREDENTIALS` : Single-line JSON string downloaded from Google Cloud Console OAuth 2.0 Client.
- `GOOGLE_TOKEN` : Single-line JSON string generated locally by executing `get_google_token.ps1` (Windows) or `get_google_token.sh` (Linux/Mac).

---

## ⚠️ 6. Developer & AI Assistant System Guardrails

When modifying, maintaining, or generating code for CIPHER-MD, the AI must strictly adhere to these rules:

1. **No Superfluous Dependencies:** Do not add third-party npm packages when standard Node.js built-ins (`crypto`, `fs`, `path`) or already installed libraries (`axios`, `chalk`, `adm-zip`, `@whiskeysockets/baileys`) suffice.
2. **DRM & Kernel Integrity:** Never modify `LICENSE.md`, the verification routines in `start.js`, or the hash validation checks. Altering these files triggers anti-tamper self-locking.
3. **Asynchronous Architecture:** All Baileys WhatsApp event sockets and handlers operate asynchronously. Always use proper `async/await` and handle reconnection events gracefully.
4. **Configuration Abstraction:** Never hardcode sensitive credentials or API keys directly in source files. Always map them through `process.env` and `config.js`.
