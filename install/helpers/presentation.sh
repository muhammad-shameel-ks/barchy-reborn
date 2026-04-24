#!/bin/bash

# Barchyreborn presentation utilities

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