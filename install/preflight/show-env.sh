#!/bin/bash

# Show environment info at start of installation

gum style --foreground 4 --padding "1 0 1 $PADDING_LEFT" "Barchyreborn Installer"
gum style --padding "1 0 1 $PADDING_LEFT" "Environment: $(uname -m) • Arch Linux • $(date '+%Y-%m-%d')"
echo