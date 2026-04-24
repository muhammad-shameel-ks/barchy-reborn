#!/bin/bash

# NVIDIA hardware setup
barchyreborn-pkg-add nvidia-dkms nvidia-utils

sudo cp -f "$BARCHYREBORN_PATH/default/udev/nvidia.rules" /etc/udev/rules.d/nvidia.rules 2>/dev/null || true