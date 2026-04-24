#!/bin/bash

# SDDM setup
barchyreborn-pkg-add sddm

sudo systemctl enable sddm
sudo cp -f "$BARCHYREBORN_PATH/default/sddm/sddm.conf" /etc/sddm.conf 2>/dev/null || true