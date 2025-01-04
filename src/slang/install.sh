#!/bin/bash

set -e  # Exit on any error

install_wget() {
    if command -v apt-get &> /dev/null; then
        apt-get update && apt-get install -y wget
    elif command -v yum &> /dev/null; then
        yum install -y wget
    elif command -v apk &> /dev/null; then
        apk add --no-cache wget
    else
        echo "Error: Package manager not found. Please install wget manually."
        exit 1
    fi
}

if ! command -v wget &> /dev/null; then
    echo "wget not found. Installing wget..."
    install_wget
fi

BIN_PATH=/opt/slang

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

# export PATH=$PATH:/opt/slang/bin

# if ! grep -q "/opt/slang/bin" ~/.zshrc; then
#     echo 'export PATH=$PATH:/opt/slang/bin' >> ~/.zshrc
#     echo "Added /opt/slang/bin to PATH in ~/.zshrc"
# fi

# source ~/.zshrc