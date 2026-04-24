#!/bin/bash

# Disable mkinitcpio hooks if present (for faster boot)

if [[ -f /etc/mkinitcpio.conf ]]; then
  sudo sed -i 's/^HOOKS=.*/HOOKS="base udev autodetect keyboard keymap modconf block filesystems fsck"/' /etc/mkinitcpio.conf 2>/dev/null || true
fi