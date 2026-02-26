#!/usr/bin/env bash

if [ "$RESET_DOCK" != "true" ]; then
  echo "Skipping Dock reset"
  exit 0
fi

echo "📌 Resetting Dock..."

defaults write com.apple.dock persistent-apps -array

add_to_dock () {
  defaults write com.apple.dock persistent-apps -array-add "
  <dict>
    <key>tile-data</key>
    <dict>
      <key>file-data</key>
      <dict>
        <key>_CFURLString</key>
        <string>$1</string>
        <key>_CFURLStringType</key>
        <integer>0</integer>
      </dict>
    </dict>
  </dict>"
}

add_to_dock "/Applications/Arc.app"
add_to_dock "/Applications/Visual Studio Code.app"
add_to_dock "/System/Applications/System Settings.app"
add_to_dock "/Applications/Obsidian.app"
add_to_dock "/Applications/Ghostty.app"

killall Dock

echo "✅ Dock configured"
