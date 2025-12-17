# hey Command

A simple tool to run AI models on your terminal.

## Installation

1. Install Ollama first: https://ollama.com/download
2. Download the script:
```bash
wget https://raw.githubusercontent.com/yourusername/hey-command/main/hey.sh
```

3. Make it executable and move to PATH:
```bash
chmod +x hey.sh
sudo mv hey.sh /usr/local/bin/hey
```

## Usage

### Basic usage:
```bash
hey 'list ghost pokemon from generation 1'
```

### Change default model:
```bash
hey -m mistral
```

## Examples
```bash
hey 'list ghost pokemon from generation 1'
hey -m mistral
hey 'explain quantum computing'
```

## Notes
- Requirements: Ollama
- Default model: qwen3-coder:latest
```
