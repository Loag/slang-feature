#!/bin/bash

set -e  # Exit on any error

BIN_PATH=/opt/slang/bin/slangc

mkdir -p $BIN_PATH

OS=$(uname | tr '[:upper:]' '[:lower:]')

case "$OS" in
    darwin) OS="macos" ;;
    linux) OS="linux" ;;
    windows) OS="windows" ;;
    *) echo "Unsupported operating system: $OS"; exit 1 ;;
esac

ARCH=$(uname -m)

case "$ARCH" in
    arm64) ARCH="aarch64" ;;
    x86_64)  ARCH="x86_64" ;; 
    *) echo "Unsupported arch: $ARCH"; exit 1 ;;
esac

VERSION="2024.17"
URL="https://github.com/shader-slang/slang/releases/download/v${VERSION}/slang-${VERSION}-${OS}-${ARCH}.tar.gz"

echo "Downloading slang from $URL..."

wget -O slang.tar.gz "$URL"

tar -xvzf slang.tar.gz -C /opt/slang

# not sure if this is necesary
chmod +x /opt/slang/bin/slangc

if ! grep -q "$BIN_PATH" ~/.zshrc; then
    echo 'export PATH="$PATH:/path/to/installed/tool"' >> ~/.zshrc
    echo "Added $BIN_PATH to PATH in ~/.zshrc"
fi
