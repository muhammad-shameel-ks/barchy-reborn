#!/bin/bash

# Neovim setup - installs lazyvim config
if command -v nvim &>/dev/null; then
  # Install lazyvim if not present
  if [[ ! -d "$HOME/.config/nvim" ]]; then
    git clone https://github.com/LazyVim/starter ~/.config/nvim
  fi
fi