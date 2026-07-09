#!/bin/bash
# Reasonix Go 一键安装/卸载脚本
# 安装: curl -fsSL https://raw.githubusercontent.com/Katsro/reasonix-go-termux-arm64-dist/main/install.sh | bash
# 卸载: curl -fsSL https://raw.githubusercontent.com/Katsro/reasonix-go-termux-arm64-dist/main/install.sh | bash -s -- --uninstall

set -e

CMD_NAME="reasonixgo"
INSTALL_DIR="${PREFIX}/bin"

# 卸载
if [ "$1" = "--uninstall" ]; then
    if [ -f "$INSTALL_DIR/$CMD_NAME" ]; then
        rm -f "$INSTALL_DIR/$CMD_NAME"
        echo "✅ Uninstalled: $INSTALL_DIR/$CMD_NAME"
    else
        echo "⚠️  Not found: $INSTALL_DIR/$CMD_NAME"
    fi
    exit 0
fi

# 安装
REPO="Katsro/reasonix-go-termux-arm64-dist"
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

mv "$TMP_DIR/$CMD_NAME" "$INSTALL_DIR/$CMD_NAME"

echo ""
echo "✅ Installed: $INSTALL_DIR/$CMD_NAME"
echo ""
echo "Uninstall: curl -fsSL https://raw.githubusercontent.com/Katsro/reasonix-go-termux-arm64-dist/main/install.sh | bash -s -- --uninstall"
echo "Test:      $CMD_NAME --version"
