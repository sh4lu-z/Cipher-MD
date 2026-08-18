FROM node:20-bookworm-slim

WORKDIR /home/node/app

# 1. Cross-device linking issue එක සහ doc unpacking fix කිරීම
RUN mkdir -p /var/tmp/apt && \
    echo 'APT::ExtractTemplates::TempDir "/var/tmp/apt";' > /etc/apt/apt.conf.d/01temp && \
    echo "path-exclude /usr/share/doc/*" > /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo "path-exclude /usr/share/man/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc

# 2. Dependencies install කිරීම (TMPDIR එක /var/tmp/apt වලට යොමු කර ඇත)
RUN export TMPDIR=/var/tmp/apt && \
    apt-get update && \
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
    && rm -rf /var/lib/apt/lists/* /var/tmp/apt

# 3. App files copy කිරීම සහ install කිරීම
COPY package*.json ./

RUN npm install --legacy-peer-deps --production

COPY --chown=node:node . .

USER node

CMD ["node", "start.js"]
