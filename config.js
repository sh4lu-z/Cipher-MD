const fs = require('fs');
require('dotenv').config({ quiet: true });

module.exports = {

    BOT_NAME: process.env.BOT_NAME || "Cipher",

    CHANNEL_LINK: "https://whatsapp.com/channel/0029Vb6o3EiGJP8CoA3Olr28",

    FOOTER: "\n\n> ©︎ ᴄɪᴘʜᴇʀ ᴍᴅ ⚡︎",

    MENU_IMAGE: process.env.MENU_IMAGE || "https://i.ibb.co/Fqkx25c5/balloon-Minimalist-Desktop-Wallpaper-1.png",

    // --- [ AI PLATFORM CONFIGURATION ] ---
    // Platforms: 'google', 'groq', 'openai'
    AI_CHAT_PLATFORM: process.env.AI_CHAT_PLATFORM || "google",
    AI_CHAT_MODEL: process.env.AI_CHAT_MODEL || "gemini-3.1-flash-lite",

    AI_AGENT_PLATFORM: process.env.AI_AGENT_PLATFORM || "google",
    AI_AGENT_MODEL: process.env.AI_AGENT_MODEL || "gemini-3.1-flash-lite",

};

const _0x_p3 = "SEC_P3:[117, 95, 122]";










