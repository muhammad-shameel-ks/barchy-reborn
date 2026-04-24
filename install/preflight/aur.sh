#!/bin/bash

# Setup paru for AUR support

if ! command -v paru &>/dev/null; then
  echo "Installing paru (AUR helper)..."
  
  # Ensure base-devel and git are present
  sudo pacman -S --noconfirm --needed base-devel git

  # Build paru from source in a temporary directory
  TEMP_DIR=$(mktemp -d)
  git clone https://aur.archlinux.org/paru-bin.git "$TEMP_DIR"
  
  (
    cd "$TEMP_DIR"
    # Set MAKEFLAGS to use all available cores for faster building
    export MAKEFLAGS="-j$(nproc)"
    makepkg -si --noconfirm
  )
  
  rm -rf "$TEMP_DIR"
fi
