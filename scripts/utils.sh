#!/usr/bin/env bash

ensure_xcode() {
  if ! xcode-select -p &> /dev/null; then
    echo "Installing Xcode CLI..."
    xcode-select --install
    echo "Re-run after install finishes."
    exit 1
  fi
}

ensure_homebrew() {
  if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  eval "$(/opt/homebrew/bin/brew shellenv)"
}

install_oh_my_zsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    RUNZSH=no CHSH=no sh -c \
      "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    echo "Oh My Zsh already installed."
  fi
}

setup_dotfiles() {
  if [ ! -d "$HOME/dotfiles" ]; then
    git clone https://github.com/YOUR_USERNAME/dotfiles.git "$HOME/dotfiles"
  fi

  cd "$HOME/dotfiles"
  stow .
}
