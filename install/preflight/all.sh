#!/bin/bash

source $BARCHYREBORN_INSTALL/preflight/guard.sh
source $BARCHYREBORN_INSTALL/preflight/begin.sh
run_logged $BARCHYREBORN_INSTALL/preflight/show-env.sh
run_logged $BARCHYREBORN_INSTALL/preflight/pacman.sh
run_logged $BARCHYREBORN_INSTALL/preflight/migrations.sh
run_logged $BARCHYREBORN_INSTALL/preflight/first-run-mode.sh
run_logged $BARCHYREBORN_INSTALL/preflight/disable-mkinitcpio.sh