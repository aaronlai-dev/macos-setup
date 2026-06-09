#!/usr/bin/env bash
set -e

echo "🚀 Starting login services..."

# Sketchybar
brew services start sketchybar || true

# yabai
yabai --start-service || yabai --restart-service || true

# skhd
skhd --start-service || skhd --restart-service || true

# raycast
open -a "Raycast" || true

echo "✅ Services started"
