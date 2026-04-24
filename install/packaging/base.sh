#!/bin/bash

# Install all base packages from package list
mapfile -t packages < <(grep -v '^#' "$BARCHYREBORN_PATH/packages/base.packages" | grep -v '^$')

# Bootstrap gum and paru first if they are in the list
for bootstrap in gum paru; do
  if grep -qx "$bootstrap" "$BARCHYREBORN_PATH/packages/base.packages"; then
    sudo pacman -S --noconfirm --needed "$bootstrap" 2>/dev/null || true
  fi
done

barchyreborn-pkg-add "${packages[@]}"