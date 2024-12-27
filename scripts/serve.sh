#!/bin/bash

# Set the directory to serve (public/)
SCRIPT_DIR=$(dirname "$0")
PROJECT_DIR=$(realpath "$SCRIPT_DIR/..")
PUBLIC_DIR="$PROJECT_DIR/public"

# Default port to serve
PORT=8000

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "Error: Python3 is not installed. Please install it and try again."
    exit 1
fi

# Start the HTTP server
echo "Serving files from: $PUBLIC_DIR"
echo "Access your project at: http://localhost:$PORT"

cd "$PUBLIC_DIR" || exit
python3 -m http.server "$PORT"