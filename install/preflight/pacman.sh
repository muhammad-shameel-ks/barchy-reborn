#!/bin/bash

# Setup pacman mirrors and keyring

if [[ -n ${BARCHYREBORN_ONLINE_INSTALL:-} ]]; then
  # Install build tools
  barchyreborn-pkg-add base-devel

  # Configure pacman
  sudo cp -f "$BARCHYREBORN_PATH/default/pacman/pacman-${BARCHYREBORN_MIRROR:-stable}.conf" /etc/pacman.conf
  sudo cp -f "$BARCHYREBORN_PATH/default/pacman/mirrorlist-${BARCHYREBORN_MIRROR:-stable}" /etc/pacman.d/mirrorlist

  # Add your custom keyring if you have one
  # sudo pacman-key --recv-keys YOUR_KEY_ID --keyserver keys.openpgp.org
  # sudo pacman-key --lsign-key YOUR_KEY_ID

  sudo pacman -Sy

  # Add barchyreborn-specific keyring if you publish packages
  # barchyreborn-pkg-add barchyreborn-keyring

  # Refresh all repos
  sudo pacman -Syyuu --noconfirm
fi