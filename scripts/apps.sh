#!/usr/bin/env bash
set -e

echo "📦 Installing Brew packages..."

brew update
brew bundle --file Brewfile

echo "✅ Apps installed"
