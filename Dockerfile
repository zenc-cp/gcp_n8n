FROM docker.n8n.io/n8nio/n8n:latest

USER root

# Install pnpm globally
RUN npm install -g pnpm

# Install the community node using pnpm to satisfy only-allow
RUN pnpm add -g n8n-nodes-playwright

# Install system deps for Playwright (chromium browser and libs)
RUN apk add --no-cache \
    ca-certificates \
    harfbuzz \
    nss \
    freetype \
    ttf-freefont \
    chromium

# Tell Playwright to use the system chromium
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=true \
    PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH=/usr/bin/chromium-browser

USER node
