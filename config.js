const fs = require('fs');
if (fs.existsSync('config.env')) require('dotenv').config({ path: './config.env' });

module.exports = {

    OWNER_NUMBER: process.env.OWNER_NUMBER || "", 
    OWNER_PHONE: process.env.OWNER_PHONE || "",      
    PAIRING_NUMBER: process.env.PAIRING_NUMBER || "", 
    BOT_NAME: process.env.BOT_NAME || "Cipher",
    LICENSE_KEY: process.env.LICENSE_KEY || "",
    CHANNEL_LINK: "https://whatsapp.com/channel/0029Vb6o3EiGJP8CoA3Olr28",
    FOOTER: process.env.FOOTER || "\n\n> ©︎ ᴄɪᴘʜᴇʀ ᴍᴅ ⚡︎",
    MONGO_URL: process.env.MONGO_URL || '',
    MENU_IMAGE: process.env.MENU_IMAGE || "https://i.ibb.co/Fqkx25c5/balloon-Minimalist-Desktop-Wallpaper-1.png",



    // ============================================================
    // 🛑 SYSTEM CONFIG 
    // ============================================================
    FILES: {
        bannedUsers: "./database/banned_users.json",
        badWords: "./database/bad_words.json",
        settings: "./database/bot_settings.json",
        videoUsage: "./database/video_usage.json",
        authFolder: "auth_info_baileys",
        mediaCacheDir: "./media_cache",
        songCacheDir: "./media_cache/songs",
        videoCacheDir: "./media_cache/videos",
        stickerCacheDir: "./media_cache/stickers",
        groupsDir: "./database/groups/" 
    },
      
    // 🌐 BROWSER HEADERS
    BROWSER_HEADERS: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36',
        'Accept': 'application/json, text/plain, */*',
        'Referer': 'https://google.com'
    }
};

const _0x_p3 = "SEC_P3:[117, 95, 122]";









