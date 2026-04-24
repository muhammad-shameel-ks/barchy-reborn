#!/bin/bash

# Network setup - iwd + NetworkManager
barchyreborn-pkg-add iwd NetworkManager

sudo systemctl enable iwd
sudo systemctl enable NetworkManager