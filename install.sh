#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Define Barchyreborn locations
export BARCHYREBORN_PATH="$HOME/.local/share/barchyreborn"
export BARCHYREBORN_INSTALL="$BARCHYREBORN_PATH/install"
export BARCHYREBORN_INSTALL_LOG_FILE="/var/log/barchyreborn-install.log"
export PATH="$BARCHYREBORN_PATH/bin:$PATH"

# Ensure all scripts are executable
chmod +x "$BARCHYREBORN_PATH/bin"/* 2>/dev/null || true
find "$BARCHYREBORN_INSTALL" -type f -name "*.sh" -exec chmod +x {} + 2>/dev/null || true

# Install
source "$BARCHYREBORN_INSTALL/helpers/all.sh"
start_install_log

run_logged "$BARCHYREBORN_INSTALL/preflight/all.sh"
run_logged "$BARCHYREBORN_INSTALL/packaging/all.sh"
run_logged "$BARCHYREBORN_INSTALL/config/all.sh"
run_logged "$BARCHYREBORN_INSTALL/login/all.sh"
run_logged "$BARCHYREBORN_INSTALL/post-install/all.sh"