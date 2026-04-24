#!/bin/bash

# Hibernation setup
if [[ -f /swapfile ]] || [[ -f /swap ]]; then
  sudo kernel-install add "$(uname -r)" /lib/modules/$(uname -r)/vmlinuz 2>/dev/null || true
fi