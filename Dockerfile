FROM ubuntu:22.04

WORKDIR /home/node/app

ENV DEBIAN_FRONTEND=noninteractive

# Install Node.js 20, ffmpeg and other dependencies
RUN apt-get update && \
    apt-get install -y curl ca-certificates && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y \
    nodejs \
    ffmpeg \
    git \
    unzip \
    libgl1 \
    libglib2.0-0 \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

COPY package*.json ./

RUN npm install --legacy-peer-deps --production

COPY . .

CMD ["node", "start.js"]
