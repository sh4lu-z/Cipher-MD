const fs = require('fs');
if (fs.existsSync('config.env')) require('dotenv').config({ path: './config.env' });

module.exports = {
    // 👑 OWNER DETAILS
    OWNER_NUMBER: process.env.OWNER_NUMBER || "", 
    OWNER_PHONE: process.env.OWNER_PHONE || "",      
    PAIRING_NUMBER: process.env.PAIRING_NUMBER || "", 

    // 🤖 BOT SETTINGS
    BOT_NAME: process.env.BOT_NAME || "Cipher",
    LICENSE_KEY: process.env.LICENSE_KEY || "",
    
    // 🔗 LINKS & FOOTER
    CHANNEL_LINK: "https://whatsapp.com/channel/0029Vb6o3EiGJP8CoA3Olr28",
    FOOTER: process.env.FOOTER || "\n\n> ©︎ ᴄɪᴘʜᴇʀ ᴍᴅ ⚡︎",

    // 🛢️ DATABASE & MEDIA
    MONGO_URL: process.env.MONGO_URL || '',
    MENU_IMAGE: process.env.MENU_IMAGE || "https://i.ibb.co/Fqkx25c5/balloon-Minimalist-Desktop-Wallpaper-1.png",
};

const _0x_p3 = "SEC_P3:[117, 95, 122]";
