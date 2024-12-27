#!/bin/bash

# Set up directory paths
SCRIPT_DIR=$(dirname "$0")
PROJECT_DIR=$(realpath "$SCRIPT_DIR/..")
SRC_DIR="$PROJECT_DIR/src"
BUILD_DIR="$PROJECT_DIR/build"
PUBLIC_DIR="$PROJECT_DIR/public"

# Ensure the build and public directories exist
mkdir -p "$BUILD_DIR"
mkdir -p "$PUBLIC_DIR"

# Check if the source file exists
if [ ! -f "$SRC_DIR/main.c" ]; then
    echo "Error: Source file '$SRC_DIR/main.c' not found!"
    exit 1
fi

echo "Source file found: $SRC_DIR/main.c"

# Use a default EXPORTED_FUNCTIONS value
# If all functions need to be exported, replace with wildcard logic like "_*"
EXPORTED_FUNCTIONS="['_greet', '_add']"  # Add your known functions or automate this part

# Compile the C code into WebAssembly
emcc "$SRC_DIR/main.c" \
    -o "$BUILD_DIR/main.js" \
    -s MODULARIZE=1 \
    -s EXPORT_NAME='MyModule' \
    -s EXPORTED_FUNCTIONS="$EXPORTED_FUNCTIONS"

if [ $? -ne 0 ]; then
    echo "Error: WebAssembly compilation failed!"
    exit 1
fi

echo "Build complete. Files are in the 'build/' directory."

# Copy the compiled WebAssembly files to the public directory
cp "$BUILD_DIR/main.js" "$BUILD_DIR/main.wasm" "$PUBLIC_DIR"

if [ $? -ne 0 ]; then
    echo "Error: Failed to copy files to the public directory!"
    exit 1
fi

echo "Copied build artifacts to the 'public/' directory successfully."