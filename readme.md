# hey Command

A simple tool to run AI models in your terminal with built-in history.

## Installation

1. **Install Ollama**: https://ollama.com/download
2. **Setup**: Run the script once to install it globally:
   bash hey.sh

## Features

- **Auto-Installation**: Moves itself to /usr/local/bin.
- **Model Selection**: Allows switching LLMs.
- **Contextual History**: Remembers your conversation until reboot or manual clear.

## Usage

### Basic usage:
hey 'your question here'

### Change default model:
hey -m model-name

### Clear conversation history:
hey -c

## Examples
hey 'list ghost pokemon from generation 1'
hey -m llama3
hey 'explain quantum computing'

## Notes
- **Requirements**: Ollama
- **Default model**: qwen3-coder:latest
- **History**: Stored in /tmp (cleared on system reboot).
