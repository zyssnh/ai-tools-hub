#!/bin/bash
# ============================================================
# Generate random passwords for all services
# Usage: ./scripts/generate-passwords.sh
# ============================================================

set -e

generate() {
    echo "$(openssl rand -hex 24)"
}

cat <<EOF
# Generated passwords — $(date)
# Append these to your .env file (or copy-paste individual values)

OPENCLAW_GATEWAY_TOKEN=$(generate)
HERMES_DASHBOARD_PASSWORD=$(generate)
HERMES_API_KEY=$(generate)
TTYD_PASSWORD=$(generate)
EOF
