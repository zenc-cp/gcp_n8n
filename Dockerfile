FROM docker.n8n.io/n8nio/n8n:latest

USER root

# Install pnpm globally
RUN npm install -g pnpm

# Set PNPM_HOME and add to PATH
ENV PNPM_HOME=/root/.local/share/pnpm
ENV PATH="$PNPM_HOME:$PATH"

# Manually create PNPM_HOME directory to fix setup error
RUN mkdir -p $PNPM_HOME

# Setup pnpm directories with force to bypass shell config check
RUN pnpm setup --force

# Install the community node
RUN pnpm add -g n8n-nodes-playwright-persistent

# Install system deps for Playwright (chromium and libs)
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
