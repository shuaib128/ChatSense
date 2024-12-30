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

# Generate env.js from .env if it exists
ENV_FILE="$PROJECT_DIR/.env"
ENV_JS_FILE="$PUBLIC_DIR/env.js"

if [ -f "$ENV_FILE" ]; then
    echo "Generating $ENV_JS_FILE from $ENV_FILE"
    echo "window.env = {" > "$ENV_JS_FILE"
    while IFS='=' read -r key value; do
        # Skip comments and empty lines
        [[ "$key" =~ ^#.*$ || -z "$key" ]] && continue
        # Write key-value pair to env.js
        echo "  \"$key\": \"$value\"," >> "$ENV_JS_FILE"
    done < "$ENV_FILE"
    # Remove the trailing comma and close the object
    sed -i '' -e '$ s/,$//' "$ENV_JS_FILE"
    echo "};" >> "$ENV_JS_FILE"
else
    echo "No .env file found. Skipping env.js generation."
fi

# Start the HTTP server
echo "Serving files from: $PUBLIC_DIR"
echo "Access your project at: http://localhost:$PORT"

cd "$PUBLIC_DIR" || exit
python3 -m http.server "$PORT"
