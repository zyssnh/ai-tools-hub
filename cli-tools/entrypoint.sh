#!/bin/bash
# ============================================================
# Entrypoint — Start ttyd with tmux multi-window session
# ============================================================

SESSION="main"

# ── Ensure tmux session exists ─────────────────────────
if ! tmux has-session -t "$SESSION" 2>/dev/null; then
    # Create main session with workspace as first window
    tmux new-session -d -s "$SESSION" -c /workspace -n "work"

    # Claude Code window
    tmux new-window -t "$SESSION" -n "claude" -c /workspace <<'EOF'
clear
cat <<'WELCOME'
╔══════════════════════════════════════════╗
║  🟠 Claude Code (Anthropic)              ║
║  Run: claude                             ║
║  First use requires OAuth: claude login  ║
╚══════════════════════════════════════════╝
WELCOME
exec bash
EOF

    # MiMo Code window
    tmux new-window -t "$SESSION" -n "mimo" -c /workspace <<'EOF'
clear
cat <<'WELCOME'
╔══════════════════════════════════════════╗
║  🔵 MiMo Code (Xiaomi)                   ║
║  Run: mimo                               ║
╚══════════════════════════════════════════╝
WELCOME
exec bash
EOF

    # Kimi Code window
    tmux new-window -t "$SESSION" -n "kimi" -c /workspace <<'EOF'
clear
cat <<'WELCOME'
╔══════════════════════════════════════════╗
║  🟣 Kimi Code (Moonshot AI)              ║
║  Run: kimi                               ║
╚══════════════════════════════════════════╝
WELCOME
exec bash
EOF

    # Pi window
    tmux new-window -t "$SESSION" -n "pi" -c /workspace <<'EOF'
clear
cat <<'WELCOME'
╔══════════════════════════════════════════╗
║  🟢 Pi Coding Agent                      ║
║  Run: pi                                 ║
╚══════════════════════════════════════════╝
WELCOME
exec bash
EOF

    # Select workspace window as default
    tmux select-window -t "$SESSION:0"
fi

# ── Start ttyd ────────────────────────────────────────
exec ttyd \
    -W \
    -p 7681 \
    -b /terminal \
    -c "${TTYD_USERNAME:-admin}:${TTYD_PASSWORD:-changeme}" \
    tmux new-session -A -s "$SESSION"
