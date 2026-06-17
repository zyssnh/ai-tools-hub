#!/bin/bash
# ============================================================
# Start all AI Tools services
# Usage: ./scripts/start.sh [service-name]
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

if [ ! -f .env ]; then
    echo "❌ .env file not found. Run ./scripts/setup.sh first."
    exit 1
fi

echo "=== Starting AI Tools Hub ==="

if [ -z "$1" ]; then
    docker compose up -d
    echo ""
    echo "All services starting..."
    echo "Check status: docker compose ps"
    echo "View logs:    docker compose logs -f"
else
    docker compose up -d "$1"
    echo "Service '$1' starting..."
fi

echo ""
echo "Access points:"
echo "  Landing:   http://localhost"
echo "  OpenClaw:  http://localhost/openclaw/"
echo "  Hermes:    http://localhost/hermes/"
echo "  OpenCode:  http://localhost/opencode/"
echo "  Terminal:  http://localhost/terminal/"
