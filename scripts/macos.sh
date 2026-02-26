#!/usr/bin/env bash

echo "⚙️ Applying macOS defaults..."

# Key repeat
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 24
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 64
defaults write com.apple.dock show-recents -bool false

# Menu bar auto-hide
defaults write NSGlobalDomain _HIHideMenuBar -bool true

# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Restart
killall Dock 2>/dev/null || true
killall Finder 2>/dev/null || true

echo "✅ macOS defaults applied"
