#!/bin/bash

stop_install_log

clear
echo

# Show logo art
if [[ -f ~/.local/share/barchyreborn/logo.txt ]]; then
  cat ~/.local/share/barchyreborn/logo.txt
fi

echo

# Display installation time if available
if [[ -f $BARCHYREBORN_INSTALL_LOG_FILE ]] && grep -q "Total:" "$BARCHYREBORN_INSTALL_LOG_FILE" 2>/dev/null; then
  TOTAL_TIME=$(tail -n 20 "$BARCHYREBORN_INSTALL_LOG_FILE" | grep "^Total:" | sed 's/^Total:[[:space:]]*//')
  if [[ -n $TOTAL_TIME ]]; then
    gum style --foreground 2 "Installed in $TOTAL_TIME"
  fi
else
  gum style --foreground 2 "Installation complete"
fi

echo
gum style "Barchyreborn has been installed successfully!"
echo

# Mark first-run complete
mkdir -p ~/.config/barchyreborn
touch ~/.config/barchyreborn/.first-run-complete

# Exit gracefully if user chooses not to reboot
if gum confirm --padding "0 0 0 $((PADDING_LEFT + 20))" --show-help=false --default --affirmative "Reboot Now" --negative "" ""; then
  clear

  if [[ -n ${BARCHYREBORN_CHROOT_INSTALL:-} ]]; then
    touch /var/tmp/barchyreborn-install-completed
    exit 0
  else
    sudo reboot 2>/dev/null
  fi
fi