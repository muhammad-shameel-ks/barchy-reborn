#!/bin/bash

# Plymouth setup
barchyreborn-pkg-add plymouth

sudo cp -f "$BARCHYREBORN_PATH/default/plymouth/plymouthd.conf" /etc/plymouth/plymouthd.conf 2>/dev/null || true
sudo mkdir -p /etc/dracut.conf.d
echo 'add_drivers+="amdgpu"' | sudo tee /etc/dracut.conf.d/plymouth.conf >/dev/null