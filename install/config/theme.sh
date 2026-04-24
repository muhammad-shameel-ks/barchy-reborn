#!/bin/bash

# Theme setup - sets initial theme

# Set links for Nautilus action icons
if [[ -d /usr/share/icons/Yaru ]]; then
  sudo ln -snf /usr/share/icons/Adwaita/symbolic/actions/go-previous-symbolic.svg /usr/share/icons/Yaru/scalable/actions/go-previous-symbolic.svg 2>/dev/null || true
  sudo ln -snf /usr/share/icons/Adwaita/symbolic/actions/go-next-symbolic.svg /usr/share/icons/Yaru/scalable/actions/go-next-symbolic.svg 2>/dev/null || true
fi

# Setup user theme folder
mkdir -p ~/.config/barchyreborn/themes

# Set initial theme (blue-land by default)
barchyreborn-theme-set "blue-land"

# Set btop theme link
mkdir -p ~/.config/btop/themes
ln -snf ~/.config/barchyreborn/current/theme/btop.theme ~/.config/btop/themes/current.theme 2>/dev/null || true

# Set mako config link
mkdir -p ~/.config/mako
ln -snf ~/.config/barchyreborn/current/theme/mako.ini ~/.config/mako/config 2>/dev/null || true