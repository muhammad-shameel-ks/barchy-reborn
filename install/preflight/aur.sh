#!/bin/bash

# Setup AUR support (Bootstrap with yay-bin, then install paru)

if ! command -v paru &>/dev/null; then
  echo "AUR helper (paru) not found. Bootstrapping..."

  # Ensure base-devel and git are present
  sudo pacman -S --noconfirm --needed base-devel git

  # Keep sudo alive in the background
  ( while true; do sudo -v; sleep 60; done ) &
  SUDO_PID=$!
  trap "kill $SUDO_PID 2>/dev/null || true" EXIT

  # 1. Quickly install yay-bin to have an AUR helper immediately
  if ! command -v yay &>/dev/null; then
    echo "Installing yay-bin for fast bootstrap..."
    TEMP_YAY=$(mktemp -d)
    git clone https://aur.archlinux.org/yay-bin.git "$TEMP_YAY"
    (
      cd "$TEMP_YAY"
      makepkg -si --noconfirm --needed --nocheck
    )
    rm -rf "$TEMP_YAY"
  fi

  # 2. Use yay to install paru (our preferred helper)
  if command -v yay &>/dev/null; then
    echo "Using yay to install paru..."
    yay -S --noconfirm --needed paru-bin
  fi
fi
