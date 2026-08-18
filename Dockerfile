FROM node:20-alpine

WORKDIR /home/node/app

# Koyeb එකේ හිර නොවී build වෙන Alpine dependencies (FFmpeg, Git, Chromium සහ Graphics libs)
RUN apk add --no-cache \
    ffmpeg \
    git \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    libstdc++

# Puppeteer භාවිතා කරන්නේ නම් System Chromium එක point කිරීම
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

COPY package*.json ./

RUN npm install --legacy-peer-deps --production

COPY --chown=node:node . .

USER node

CMD ["node", "start.js"]

