#!/bin/bash

# Copy default configs to ~/.config

DEFAULT_CONFIGS=(
  "hypr"
  "waybar"
  "mako"
  "systemd"
  "sddm"
  "plymouth"
  "udev"
  "walker"
  "elephant"
  "pacman"
)

for cfg in "${DEFAULT_CONFIGS[@]}"; do
  if [[ -d "$BARCHYREBORN_PATH/default/$cfg" ]]; then
    mkdir -p "$HOME/.config/$cfg"
    cp -r "$BARCHYREBORN_PATH/default/$cfg/"* "$HOME/.config/$cfg/" 2>/dev/null || true
  fi
done

# Setup barchyreborn theme dir
mkdir -p ~/.config/barchyreborn/themes
mkdir -p ~/.config/barchyreborn/backgrounds
mkdir -p ~/.config/barchyreborn/hooks
mkdir -p ~/.config/barchyreborn/current

# Setup bashrc
if [[ -f "$BARCHYREBORN_PATH/default/bashrc" ]]; then
  cp "$BARCHYREBORN_PATH/default/bashrc" "$HOME/.bashrc"
fi