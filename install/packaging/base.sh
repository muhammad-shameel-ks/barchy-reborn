#!/bin/bash

# Install all base packages from package list
mapfile -t packages < <(grep -v '^#' "$BARCHYREBORN_PATH/packages/base.packages" | grep -v '^$')
barchyreborn-pkg-add "${packages[@]}"