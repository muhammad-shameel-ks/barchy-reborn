#!/bin/bash

# Install all base packages from package list
mapfile -t packages < <(grep -v '^#' "$BARCHYREBORN_PATH/packages/base.packages" | grep -v '^$')

# Bootstrap gum first if in the list (needed for UI)
if grep -qx "gum" "$BARCHYREBORN_PATH/packages/base.packages"; then
  sudo pacman -S --noconfirm --needed gum 2>/dev/null || true
fi

barchyreborn-pkg-add "${packages[@]}"