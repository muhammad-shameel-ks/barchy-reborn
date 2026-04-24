#!/bin/bash

# Setup AUR support — bootstrap with yay-bin (precompiled, fast)
# paru will be installed later via yay once the system is ready

_install_aur_bin() {
  local name="$1"
  local url="$2"

  echo "Installing $name..."
  local TEMP_DIR
  TEMP_DIR=$(mktemp -d)

  git clone "$url" "$TEMP_DIR"

  (
    cd "$TEMP_DIR"
    export MAKEFLAGS="-j$(nproc)"
    # Build only (no -i), then install via pacman --noconfirm to avoid sudo password prompt
    makepkg --noconfirm --needed --nocheck 2>&1
    sudo pacman -U --noconfirm ./*.pkg.tar.zst
  )

  rm -rf "$TEMP_DIR"
}

if ! command -v yay &>/dev/null && ! command -v paru &>/dev/null; then
  echo "No AUR helper found. Bootstrapping yay-bin..."

  # Ensure base-devel and git are present
  sudo pacman -S --noconfirm --needed base-devel git

  # Keep sudo alive in the background so it doesn't time out
  sudo -v
  ( while true; do sudo -v; sleep 50; done ) &
  SUDO_PID=$!
  trap "kill $SUDO_PID 2>/dev/null || true" EXIT

  _install_aur_bin "yay-bin" "https://aur.archlinux.org/yay-bin.git"
fi

# At this point yay or paru must be available
if ! command -v yay &>/dev/null && ! command -v paru &>/dev/null; then
  echo "ERROR: Failed to install an AUR helper. Cannot continue."
  exit 1
fi
