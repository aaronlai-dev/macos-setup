#!/usr/bin/env bash
set -e

echo "📦 Installing Brew packages..."

brew update

echo "🤝 Trusting third-party taps..."
brew trust FelixKratz/formulae
brew trust koekeishiya/formulae
brew trust BarutSRB/tap
brew trust webstonehq/tap

brew bundle --file Brewfile

echo "✅ Apps installed"
