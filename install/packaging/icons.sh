#!/bin/bash

# Install icon theme
archyreborn-pkg-add adwaita-icon-theme
sudo update-icon-caches /usr/share/icons/Adwaita 2>/dev/null || true