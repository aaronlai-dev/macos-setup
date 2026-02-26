#!/usr/bin/env bash
set -e

echo "🚀 Aaron's Mac Bootstrap"

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DIR/scripts/utils.sh"

ensure_xcode
ensure_homebrew

# Install apps
bash "$DIR/scripts/apps.sh"

# Install Oh My Zsh (idempotent)
install_oh_my_zsh

# Clone dotfiles
setup_dotfiles

# Apply macOS preferences
bash "$DIR/scripts/macos.sh"

# Setup Dock (optional reset)
RESET_DOCK=true bash "$DIR/scripts/dock.sh"

echo "🎉 Setup Complete!"