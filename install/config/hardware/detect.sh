#!/bin/bash

# Hardware detection and config

# Detect GPU and setup accordingly
GPU=$(lspci | grep -E 'VGA|3D' | head -1)

if echo "$GPU" | grep -qi nvidia; then
  source $BARCHYREBORN_INSTALL/config/hardware/nvidia.sh
fi

if echo "$GPU" | grep -qi intel; then
  source $BARCHYREBORN_INSTALL/config/hardware/intel.sh
fi

if echo "$GPU" | grep -qi amd; then
  source $BARCHYREBORN_INSTALL/config/hardware/amd.sh
fi