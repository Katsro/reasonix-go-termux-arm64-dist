#!/bin/bash
# Reasonix Go 一键安装脚本
# 用法: curl -fsSL https://raw.githubusercontent.com/Katsro/reasonix-go-dist/main/install.sh | bash

set -e

REPO="Katsro/reasonix-go-dist"
CMD_NAME="reasonixgo"
TMP_DIR=$(mktemp -d)

cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

# 当前仅测试过 Termux (android/arm64) 环境
is_arm64=false
case "$ARCH" in arm64|aarch64) is_arm64=true ;; esac
if [ "$OS" != "linux" ] || [ "$is_arm64" != "true" ] || [ ! -d /data/data/com.termux ]; then
    echo "❌ 当前仅支持 Termux (android/arm64) 环境"
    echo "   检测到: OS=$OS ARCH=$ARCH"
    exit 1
fi
ARCH="arm64"

BIN_URL="https://github.com/$REPO/releases/latest/download/reasonixgo-${OS}-${ARCH}"
echo "Downloading $BIN_URL ..."
curl -fsSL "$BIN_URL" -o "$TMP_DIR/$CMD_NAME"
chmod +x "$TMP_DIR/$CMD_NAME"

INSTALL_DIR="${HOME}/.local/bin"
mkdir -p "$INSTALL_DIR"
mv "$TMP_DIR/$CMD_NAME" "$INSTALL_DIR/$CMD_NAME"

echo ""
echo "✅ Installed: $INSTALL_DIR/$CMD_NAME"
echo ""
echo "Make sure $INSTALL_DIR is in your PATH:"
echo "  export PATH=\"$INSTALL_DIR:\$PATH\""
echo ""
echo "Test: $CMD_NAME --version"
