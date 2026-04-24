#!/bin/bash

# Post-install pacman hooks
sudo mkdir -p /etc/pacman.d/hooks
sudo cp -f "$BARCHYREBORN_PATH/default/systemd/ldconfig.hook" /etc/pacman.d/hooks/ 2>/dev/null || true