#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Define Barchyreborn locations
export BARCHYREBORN_PATH="$HOME/.local/share/barchyreborn"
export BARCHYREBORN_INSTALL="$BARCHYREBORN_PATH/install"
export BARCHYREBORN_INSTALL_LOG_FILE="/var/log/barchyreborn-install.log"
export PATH="$BARCHYREBORN_PATH/bin:$PATH"

# Install
source "$BARCHYREBORN_INSTALL/helpers/all.sh"
source "$BARCHYREBORN_INSTALL/preflight/all.sh"
source "$BARCHYREBORN_INSTALL/packaging/all.sh"
source "$BARCHYREBORN_INSTALL/config/all.sh"
source "$BARCHYREBORN_INSTALL/login/all.sh"
source "$BARCHYREBORN_INSTALL/post-install/all.sh"