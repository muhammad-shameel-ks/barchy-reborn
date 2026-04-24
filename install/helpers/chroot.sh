#!/bin/bash

# Chroot detection for Barchyreborn

is_chroot() {
  [[ -f /proc/1/mountinfo ]] && awk '{print $1}' /proc/1/mountinfo | head -1 | grep -qE '^(1$|9[0-9]{0,2}$)' 2>/dev/null
}