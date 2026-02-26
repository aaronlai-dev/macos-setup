#!/usr/bin/env bash
set -e

echo "🚀 Aaron's Mac Bootstrap"

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load utilities
source "$DIR/scripts/utils.sh"

# Preflight Checks
echo "🔎 Running preflight checks..."
ensure_xcode
ensure_homebrew

# Install apps
echo "📦 Installing applications..."
bash "$DIR/scripts/apps.sh"

# Install Oh My Zsh (idempotent)
echo "🐚 Installing Oh My Zsh..."
install_oh_my_zsh

# Clone dotfiles
echo "🔗 Setting up dotfiles..."
setup_dotfiles

# Apply macOS preferences
echo "⚙️ Applying macOS preferences..."
bash "$DIR/scripts/macos.sh"

# Setup Dock (optional reset)
echo "🧭 Configuring Dock..."
RESET_DOCK=true bash "$DIR/scripts/dock.sh"

# Reload shell
echo "🔄 Reloading shell..."
exec zsh

echo "🎉 Setup Complete!"
