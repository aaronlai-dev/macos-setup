#!/usr/bin/env bash
set -e

echo "🔐 Setting up GitHub SSH key..."

KEY="$HOME/.ssh/id_ed25519"
EMAIL="aaronlai185@gmail.com"

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

if [ ! -f "$KEY" ]; then
  ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY" -N ""
fi

eval "$(ssh-agent -s)"

touch "$HOME/.ssh/config"

if ! grep -q "Host github.com" "$HOME/.ssh/config"; then
  cat >> "$HOME/.ssh/config" <<EOF

Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
EOF
fi

ssh-add --apple-use-keychain "$KEY"

if ! command -v gh >/dev/null 2>&1; then
  echo "❌ GitHub CLI is not installed. Install it with: brew install gh"
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  gh auth login --hostname github.com --git-protocol ssh --web
fi

gh ssh-key add "$KEY.pub" --title "$(scutil --get ComputerName) - $(date +%Y-%m-%d)" --type authentication || true

ssh -T git@github.com || true

echo "✅ GitHub SSH key setup complete"
