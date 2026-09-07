FROM node:20-bullseye-slim
WORKDIR /home/node/app

RUN echo "====== STEP 1: STARTING APT-GET UPDATE ======"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ffmpeg \
    git \
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

RUN echo "====== STEP 1: APT-GET SUCCESS ======"

COPY package*.json ./

RUN echo "====== STEP 2: STARTING NPM INSTALL ======"

RUN npm install --legacy-peer-deps --production --verbose

RUN echo "====== STEP 2: NPM INSTALL SUCCESS ======"

COPY . .
RUN chown -R node:node /home/node/app
USER node

RUN echo "====== STEP 3: BUILD FINISHED SUCCESSFULLY ======"

CMD ["node", "start.js"]
