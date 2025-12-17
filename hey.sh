#!/bin/bash

# --- AUTO-INSTALLER ---
if [[ "$0" != "/usr/local/bin/hey" ]]; then
    chmod +x "$0"
    sudo cp "$0" /usr/local/bin/hey
    sudo chmod 755 /usr/local/bin/hey
    echo "Installed successfully to /usr/local/bin/hey"
    exit 0
fi

# --- CONFIG & HISTORY ---
MODEL_CONF="$HOME/.hey_model"
HIST_FILE="/tmp/hey_history_conversation"
MODEL=$( [ -f "$MODEL_CONF" ] && cat "$MODEL_CONF" || echo "qwen3-coder:latest" )
SYSTEM_PROMPT="Instruction: Be concise and direct. No fluff."

# --- FLAGS ---
if [ "$1" = "-m" ]; then
    echo "$2" > "$MODEL_CONF"
    echo "Model changed to: $2"
    exit 0
fi

if [ "$1" = "-c" ]; then
    rm -f "$HIST_FILE"
    echo "History cleared."
    exit 0
fi

if [ $# -eq 0 ]; then
    echo "Usage: hey 'message'"
    exit 1
fi

# --- EXECUTION ---
# Create temp context with system prompt
echo "$SYSTEM_PROMPT" > "$HIST_FILE.tmp"

# Append existing history if it exists
if [ -f "$HIST_FILE" ]; then
    cat "$HIST_FILE" >> "$HIST_FILE.tmp"
fi

# Add current user prompt
echo "User: $*" >> "$HIST_FILE.tmp"

# Run Ollama and capture response
RESPONSE=$(ollama run "$MODEL" "$(cat "$HIST_FILE.tmp")")

# Output response to terminal
echo "$RESPONSE"

# Update permanent history with the exchange
{
    echo "User: $*"
    echo "Assistant: $RESPONSE"
} >> "$HIST_FILE"

# Clean up
rm -f "$HIST_FILE.tmp"