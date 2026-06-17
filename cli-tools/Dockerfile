# ============================================================
# CLI Tools Container — ttyd + tmux + AI Coding CLI Tools
# ============================================================
FROM debian:bookworm-slim

ARG UID=1000
ARG GID=1000

# System packages & Node.js
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates gnupg git build-essential \
    python3 python3-pip python3-venv \
    tmux vim nano less htop unzip xz-utils jq procps \
    ripgrep bat fd-find \
    && ln -sf /usr/bin/batcat /usr/local/bin/bat \
    && ln -sf /usr/bin/fdfind /usr/local/bin/fd \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
       | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" \
       > /etc/apt/sources.list.d/nodesource.list \
    && apt-get update && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# ttyd — web terminal
ADD https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.x86_64 /usr/local/bin/ttyd
RUN chmod +x /usr/local/bin/ttyd

# Entrypoint — placed at / (outside /home/dev) so volume mounts don't shadow it
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Non-root user
RUN groupadd -g ${GID} dev && \
    useradd -m -u ${UID} -g dev -s /bin/bash dev && \
    mkdir -p /home/dev/.npm-global /home/dev/.local/bin /home/dev/.config /home/dev/.cache && \
    chown -R dev:dev /home/dev

USER dev
ENV HOME=/home/dev
ENV PATH="/home/dev/.npm-global/bin:/home/dev/.local/bin:/home/dev/.cargo/bin:${PATH}"
ENV NPM_CONFIG_PREFIX=/home/dev/.npm-global
ENV UV_CACHE_DIR=/home/dev/.cache/uv

WORKDIR /workspace

# uv — Python package manager (for Kimi Code)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Claude Code — Anthropic official CLI
RUN curl -fsSL https://claude.ai/install.sh | bash

# MiMo Code — Xiaomi AI Coding CLI
RUN npm install -g @mimo-ai/cli 2>/dev/null || \
    curl -fsSL https://mimo.xiaomi.com/install | bash 2>/dev/null || \
    echo "[warn] MiMo Code install skipped"

# Pi Coding Agent — Minimalist AI Coding CLI
RUN npm install -g @mariozechner/pi-coding-agent 2>/dev/null || \
    echo "[warn] Pi install skipped"

# Kimi Code — Moonshot AI Python CLI
RUN uv tool install kimi-cli 2>/dev/null || \
    pip install kimi-cli --break-system-packages 2>/dev/null || \
    echo "[warn] Kimi Code install skipped"

EXPOSE 7681
ENTRYPOINT ["/entrypoint.sh"]
