#!/bin/bash

# Set install mode to online since boot.sh is used for curl installations
export BARCHYREBORN_ONLINE_INSTALL=true

ansi_art='
▀█████████▄     ▄████████    ▄████████  ▄████████    ▄█    █▄    ▄██   ▄   
  ███    ███   ███    ███   ███    ███ ███    ███   ███    ███   ███   ██▄ 
  ███    ███   ███    ███   ███    ███ ███    █▀    ███    ███   ███▄▄▄███ 
 ▄███▄▄▄██▀    ███    ███  ▄███▄▄▄▄██▀ ███         ▄███▄▄▄▄███▄▄ ▀▀▀▀▀▀███ 
▀▀███▀▀▀██▄  ▀███████████ ▀▀███▀▀▀▀▀   ███        ▀▀███▀▀▀▀███▀  ▄██   ███ 
  ███    ██▄   ███    ███ ▀███████████ ███    █▄    ███    ███   ███   ███ 
  ███    ███   ███    ███   ███    ███ ███    ███   ███    ███   ███   ███ 
▄█████████▀    ███    █▀    ███    ███ ████████▀    ███    █▀     ▀█████▀  
                            ███    ███                                     
'

clear
echo -e "\n$ansi_art\n"

# Use custom branch if instructed, otherwise default to master
BARCHYREBORN_REF="${BARCHYREBORN_REF:-master}"

# Update system before starting
sudo pacman -Syu --noconfirm --needed git

# Use custom repo if specified
BARCHYREBORN_REPO="${BARCHYREBORN_REPO:-YOUR_GITHUB_USERNAME/barchyreborn}"

echo -e "\nCloning Barchyreborn from: https://github.com/${BARCHYREBORN_REPO}.git"
rm -rf ~/.local/share/barchyreborn/
git clone "https://github.com/${BARCHYREBORN_REPO}.git" ~/.local/share/barchyreborn >/dev/null

echo -e "\e[32mUsing branch: $BARCHYREBORN_REF\e[0m"
cd ~/.local/share/barchyreborn
git fetch origin "${BARCHYREBORN_REF}" && git checkout "${BARCHYREBORN_REF}"
cd -

echo -e "\nInstallation starting..."
source ~/.local/share/barchyreborn/install.sh