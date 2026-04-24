#!/bin/bash

# Setup pacman mirrors and keyring

if [[ -n ${BARCHYREBORN_ONLINE_INSTALL:-} ]]; then
  # Install build tools
  barchyreborn-pkg-add base-devel

  # Refresh all repos
  sudo pacman -Syyuu --noconfirm
fi