#!/bin/bash

# Font setup - ensure consistent font rendering
barchyreborn-pkg-add fontconfig
sudo cp -f "$BARCHYREBORN_PATH/default/pacman/fonts.conf" /etc/fonts/local.conf 2>/dev/null || true
sudo fc-cache -f