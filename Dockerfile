FROM node:20-alpine

RUN apk add --no-cache \
    ffmpeg \
    git \
    unzip \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    libstdc++

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

WORKDIR /home/node/app
COPY package*.json ./
RUN npm install --legacy-peer-deps --production
COPY --chown=node:node . .
USER node

CMD ["node", "--require", "./patch.js", "start.js"]
