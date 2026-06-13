#!/usr/bin/env bash

echo "⚙️ Applying macOS defaults..."

# Key repeat: fastest possible
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Mouse / trackpad sensitivity: slightly reduced
defaults write NSGlobalDomain com.apple.mouse.scaling -float 1.5
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 1.5

# Disable Spotlight keyboard shortcuts so Raycast can use Cmd+Space
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "
<dict>
  <key>enabled</key><false/>
</dict>
"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 65 "
<dict>
  <key>enabled</key><false/>
</dict>
"

# Remap Caps Lock → Escape
hidutil property --set '{
  "UserKeyMapping": [
    {
      "HIDKeyboardModifierMappingSrc": 0x700000039,
      "HIDKeyboardModifierMappingDst": 0x700000029
    }
  ]
}' >/dev/null 2>&1 || echo "⚠️ Failed to remap Caps Lock"

# Set Globe/Fn key to "Do Nothing"
defaults write com.apple.HIToolbox AppleFnUsageType -int 0

# Disable "click wallpaper to reveal desktop"
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false

# Repository root
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Wallpaper
WALLPAPER="$DIR/wallpapers/big-sur-horizon.jpg"

if [ -f "$WALLPAPER" ]; then
    echo "🖼️ Setting wallpaper..."
    osascript <<EOF
tell application "System Events"
    tell every desktop
        set picture to POSIX file "$WALLPAPER"
    end tell
end tell
EOF
else
    echo "ℹ️ Wallpaper not found at $WALLPAPER"
fi

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

# Restart affected services
killall Dock 2>/dev/null || true
killall Finder 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

echo "✅ macOS defaults applied"
