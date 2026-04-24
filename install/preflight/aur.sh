#!/bin/bash

# Setup AUR support (Bootstrap with yay-bin, then install paru)

_install_aur_bin() {
  local name="$1"
  local url="$2"

  echo "Installing $name..."
  local TEMP_DIR
  TEMP_DIR=$(mktemp -d)

  git clone "$url" "$TEMP_DIR"

  # Build only (no install), then install via pacman --noconfirm to avoid sudo password prompt
  (
    cd "$TEMP_DIR"
    export MAKEFLAGS="-j$(nproc)"
    # Build the package without installing
    makepkg --noconfirm --needed --nocheck 2>&1
    # Install the resulting .pkg.tar.zst without interactive sudo
    sudo pacman -U --noconfirm ./*.pkg.tar.zst
  )

  rm -rf "$TEMP_DIR"
}

if ! command -v paru &>/dev/null; then
  echo "AUR helper (paru) not found. Bootstrapping..."

  # Ensure base-devel and git are present
  sudo pacman -S --noconfirm --needed base-devel git

  # Keep sudo alive in the background so it doesn't time out
  sudo -v
  ( while true; do sudo -v; sleep 50; done ) &
  SUDO_PID=$!
  trap "kill $SUDO_PID 2>/dev/null || true" EXIT

  # 1. Install yay-bin as a fast bootstrap AUR helper
  if ! command -v yay &>/dev/null; then
    _install_aur_bin "yay-bin" "https://aur.archlinux.org/yay-bin.git"
  fi

  # 2. Use yay to install paru (our preferred helper)
  if command -v yay &>/dev/null; then
    echo "Using yay to install paru-bin..."
    yay -S --noconfirm --needed --sudoflags "--nopasswd" paru-bin 2>/dev/null || \
      _install_aur_bin "paru-bin" "https://aur.archlinux.org/paru-bin.git"
  else
    # yay failed too, try paru-bin directly
    _install_aur_bin "paru-bin" "https://aur.archlinux.org/paru-bin.git"
  fi
fi
