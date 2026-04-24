#!/bin/bash

# WiFi power save rules
sudo mkdir -p /etc/modprobe.d
echo "options iwlwifi power_save=0" | sudo tee /etc/modprobe.d/iwlwifi.conf >/dev/null