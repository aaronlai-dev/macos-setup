#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/aaronlai-dev/macos-setup.git"
REPO_DIR="$HOME/.macos-setup"

echo "🚀 Aaron's Mac Installer"

# Ensure Xcode Command Line Tools
if ! xcode-select -p >/dev/null 2>&1; then
  echo "🔧 Installing Xcode Command Line Tools..."
  xcode-select --install

  echo "⏳ Waiting for Xcode Command Line Tools installation..."
  until xcode-select -p >/dev/null 2>&1; do
    sleep 5
  done
fi

# Ensure git exists after CLT install
if ! command -v git >/dev/null 2>&1; then
  echo "❌ git is still not available. Please restart Terminal and try again."
  exit 1
fi

# Clone or force-update repo
if [ -d "$REPO_DIR/.git" ]; then
  echo "🔄 Updating existing macos-setup repo..."
  git -C "$REPO_DIR" fetch origin main
  git -C "$REPO_DIR" reset --hard origin/main
else
  echo "📥 Cloning macos-setup repo..."
  git clone "$REPO_URL" "$REPO_DIR"
fi

cd "$REPO_DIR"

echo "▶️ Running bootstrap..."
chmod +x ./bootstrap.sh
./bootstrap.sh
