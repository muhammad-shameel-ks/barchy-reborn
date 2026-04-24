#!/bin/bash

# Audio setup
barchyreborn-pkg-add pipewire pipewire-pulse pipewire-alsa wireplumber

sudo systemctl enable pipewire pipewire-pulse wireplumber 2>/dev/null || true