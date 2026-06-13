#!/usr/bin/env bash
set -e

echo "🚀 Starting login services..."

# Sketchybar
brew services start sketchybar || true

# OmniVM
open -a "OmniWM" || true

# raycast
open -a "Raycast" || true

echo "✅ Services started"
