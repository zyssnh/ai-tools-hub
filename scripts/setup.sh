#!/bin/bash
# ============================================================
# First-time setup script
# Usage: ./scripts/setup.sh
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

echo "=== AI Tools Hub — Setup ==="
echo ""

# 1. Check Docker
if ! docker info >/dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi
echo "✅ Docker is running"

# 2. Check Docker Compose
if ! docker compose version >/dev/null 2>&1; then
    echo "❌ Docker Compose not found."
    exit 1
fi
echo "✅ Docker Compose available"

# 3. Create volume directories
echo ""
echo "--- Creating volume directories ---"
mkdir -p volumes/workspace volumes/configs \
         volumes/openclaw-data volumes/hermes-data \
         volumes/opencode-config volumes/cli-tools-home

# 4. .env file
if [ ! -f .env ]; then
    echo ""
    echo "--- Creating .env from .env.example ---"
    cp .env.example .env
    echo "⚠️  Edit .env with your API keys before starting!"
    echo ""
    echo "   vim .env  # or nano .env"
else
    echo "✅ .env already exists"
fi

# 5. Generate passwords
echo ""
echo "--- Generating passwords (add these to .env) ---"
bash scripts/generate-passwords.sh

# 6. Pull pre-built images
echo ""
echo "--- Pulling pre-built images ---"
docker pull ghcr.io/openclaw/openclaw:latest 2>&1 | tail -1
docker pull nousresearch/hermes-agent:latest 2>&1 | tail -1
docker pull ghcr.io/anomalyco/opencode:latest 2>&1 | tail -1

echo ""
echo "=== Setup complete! ==="
echo ""
echo "Next steps:"
echo "  1. Edit .env and add your API keys + generated passwords"
echo "  2. Run: docker compose up -d"
echo "  3. Open http://localhost in browser"
