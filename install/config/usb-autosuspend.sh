#!/bin/bash

# USB autosuspend for power saving
sudo mkdir -p /etc/modprobe.d
echo "options usb-autosuspend usbautosuspend=1" | sudo tee /etc/modprobe.d/usb-autosuspend.conf >/dev/null