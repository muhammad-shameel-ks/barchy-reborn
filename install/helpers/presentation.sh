#!/bin/bash

# Barchyreborn presentation utilities

# Fallback for gum if not yet installed
if ! command -v gum &>/dev/null; then
  gum() {
    case "$1" in
      style)
        shift
        while [[ "$1" == --* ]]; do
          [[ "$1" == "--padding" || "$1" == "--foreground" || "$1" == "--border" ]] && shift
          shift
        done
        echo -e "$*"
        ;;
      confirm)
        shift
        echo -n "$* [y/N] "
        read -r response
        [[ "$response" =~ ^[Yy]$ ]]
        ;;
      choose)
        shift
        # Return first option as default if gum is missing
        local header=""
        while [[ "$1" == --* ]]; do
          if [[ "$1" == "--header" ]]; then header="$2"; shift; fi
          shift
        done
        echo "$header (gum missing, picking first option: $1)" >&2
        echo "$1"
        ;;
    esac
  }
fi

LOGO_WIDTH=78
LOGO_HEIGHT=10
PADDING_LEFT=42
PADDING_LEFT_SPACES=$(printf '%*s' $PADDING_LEFT '')

clear_logo() {
  printf "\033[${LOGO_HEIGHT}A"
  for ((i = 0; i < LOGO_HEIGHT; i++)); do
    printf "\033[2K\033[A"
  done
  printf "\033[${LOGO_HEIGHT}A"
}

show_cursor() {
  printf "\033[?25h"
}