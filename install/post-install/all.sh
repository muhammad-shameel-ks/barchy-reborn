#!/bin/bash

run_logged $BARCHYREBORN_INSTALL/post-install/hibernation.sh
run_logged $BARCHYREBORN_INSTALL/post-install/pacman.sh
source $BARCHYREBORN_INSTALL/post-install/allow-reboot.sh
source $BARCHYREBORN_INSTALL/post-install/finished.sh