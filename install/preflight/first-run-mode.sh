#!/bin/bash

# First-run mode detection

FIRST_RUN_MARKER="$HOME/.config/barchyreborn/.first-run-complete"

if [[ ! -f $FIRST_RUN_MARKER ]]; then
  export BARCHYREBORN_FIRST_RUN=true
else
  export BARCHYREBORN_FIRST_RUN=false
fi