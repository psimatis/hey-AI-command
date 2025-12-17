#!/bin/bash
# hey.sh

# Check if ollama is installed
if ! command -v ollama &> /dev/null; then
    echo "Error: ollama is not installed. Please install it first."
    exit 1
fi

# Check if -m flag is used to change model
if [ "$1" = "-m" ]; then
    MODEL="$2"
    # Save the model preference to a file
    echo "$MODEL" > ~/.hey_model
    echo "Model changed to: $MODEL"
    exit 0
fi

# Get the model from config file or use default
if [ -f ~/.hey_model ]; then
    MODEL=$(cat ~/.hey_model)
else
    MODEL="qwen3-coder:latest"
fi

# Check if arguments were provided
if [ $# -eq 0 ]; then
    echo "Usage: hey [OPTIONS] <prompt>"
    echo "Options:"
    echo "  -m MODEL    Change model permanently (default: qwen3-coder:latest)"
    echo ""
    echo "Examples:"
    echo "  hey 'list all the ghost pokemon of generation 1'"
    echo "  hey -m mistral"
    exit 1
fi

# Combine all arguments into a single prompt
prompt="$*"

# Run ollama with the specified model and prompt
ollama run "$MODEL" "$prompt"
