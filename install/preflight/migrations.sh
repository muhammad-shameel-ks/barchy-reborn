#!/bin/bash

# Run migrations for config updates between versions

MIGRATIONS_DIR="$BARCHYREBORN_PATH/migrations"

if [[ -d $MIGRATIONS_DIR ]]; then
  for migration in "$MIGRATIONS_DIR"/*.sh; do
    [[ -f $migration ]] || continue
    bash "$migration"
  done
fi