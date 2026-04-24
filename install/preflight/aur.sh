#!/bin/bash

# Setup paru for AUR support

if ! command -v paru &>/dev/null; then
  echo "Installing paru (AUR helper)..."
  
  # Ensure base-devel and git are present
  sudo pacman -S --noconfirm --needed base-devel git

  # Keep sudo alive in the background
  ( while true; do sudo -v; sleep 60; done ) &
  SUDO_PID=$!
  trap "kill $SUDO_PID 2>/dev/null || true" EXIT

  # Build paru from source in a temporary directory
  TEMP_DIR=$(mktemp -d)
  git clone https://aur.archlinux.org/paru-bin.git "$TEMP_DIR"
  
  (
    cd "$TEMP_DIR"
    # Set MAKEFLAGS to use all available cores for faster building
    export MAKEFLAGS="-j$(nproc)"
    # makepkg -si uses sudo pacman -U internally. 
    # We use --noconfirm for makepkg, but we should ensure pacman doesn't block.
    # Also, we use -p to specify the packager to avoid potential interactive prompts.
    # Force ignore architectural mismatches if any
    makepkg -si --noconfirm --needed --nocheck
  )
  
  rm -rf "$TEMP_DIR"
fi
