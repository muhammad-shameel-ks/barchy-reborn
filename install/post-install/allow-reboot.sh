#!/bin/bash

# Allow reboot without password
if sudo test -f /etc/sudoers.d/99-barchyreborn-installer; then
  sudo rm -f /etc/sudoers.d/99-barchyreborn-installer &>/dev/null
fi