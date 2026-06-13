#!/usr/bin/env bash
set -e

echo "🤖 Aaron's Mac Bootstrap"

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load utilities
source "$DIR/scripts/utils.sh"

# Preflight Checks
echo "🔎 Running preflight checks..."
keep_sudo_alive
ensure_xcode
ensure_homebrew

# Install apps
echo "📦 Installing applications..."
bash "$DIR/scripts/apps.sh"

# Clone dotfiles
echo "🔗 Setting up dotfiles..."
setup_dotfiles

# Install Oh My Zsh
echo "🐚 Installing Oh My Zsh..."
install_oh_my_zsh

# Apply macOS preferences
echo "⚙️ Applying macOS preferences..."
bash "$DIR/scripts/macos.sh"

# Setup Dock (optional reset)
echo "🧭 Configuring Dock..."
RESET_DOCK=true bash "$DIR/scripts/dock.sh"

echo "🔐 Setting up GitHub SSH..."
bash "$DIR/scripts/github-ssh.sh"

# Services
echo "🚀 Starting services..."
bash "$DIR/scripts/services.sh"

echo "🎉🎉🎉 Setup Complete! 🎉🎉🎉"

exec zsh
