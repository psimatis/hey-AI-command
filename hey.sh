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
# Add the concise instruction and the user prompt to history
echo "$SYSTEM_PROMPT" > "$HIST_FILE.tmp"
if [ -f "$HIST_FILE" ]; then
    cat "$HIST_FILE" >> "$HIST_FILE.tmp"
fi
echo "User: $*" >> "$HIST_FILE.tmp"

# Run Ollama and update history
ollama run "$MODEL" "$(cat "$HIST_FILE.tmp")"
mv "$HIST_FILE.tmp" "$HIST_FILE"
