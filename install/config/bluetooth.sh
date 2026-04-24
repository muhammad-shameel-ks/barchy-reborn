#!/bin/bash

# Bluetooth setup - install and enable bluetui
barchyreborn-pkg-add bluetui bluez bluez-utils

sudo systemctl enable bluetooth
sudo systemctl start bluetooth