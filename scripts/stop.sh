#!/bin/bash
# ============================================================
# Stop all AI Tools services
# Usage: ./scripts/stop.sh
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

echo "Stopping all services..."
docker compose down
echo "✅ All services stopped"

echo ""
echo "Data in ./volumes/ is preserved."
echo "To wipe everything: docker compose down -v"
