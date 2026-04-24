# Barchyreborn Agents Guide

This document is the context file for any AI agent working on barchyreborn. It defines coding standards, naming conventions, command structure, and current project status.

**Reference Source:**
The original version of this project is in `/mnt/newvolume/Dev/barchyreborn/omarchy/`. ALWAYS check that directory for reference implementations, logic, or missing files when adding new features or troubleshooting. Barchyreborn aims to maintain architectural compatibility with Omarchy while being leaner.

---

# Style

- Two spaces for indentation, no tabs
- Use bash 5 conditionals: use `[[ ]]` for string/file tests and `(( ))` for numeric tests
- In `[[ ]]`, don't quote variables, but do quote string literals when comparing values (e.g., `[[ $branch == "dev" ]]`)
- Prefer `(( ))` over numeric operators inside `[[ ]]` (e.g., `(( count < 50 ))`, not `[[ $count -lt 50 ]]`)
- For strings/paths with spaces, quote them instead of escaping spaces with `\ ` (e.g., `"$APP_DIR/Disk Usage.desktop"`, not `$APP_DIR/Disk\ Usage.desktop`)
- Shebangs must use `#!/bin/bash` consistently (never `#!/usr/bin/env bash`)

# Command Naming

All commands start with `barchyreborn-`. Prefixes indicate purpose:

- `cmd-` - check if commands exist, misc utility commands
- `pkg-` - package management helpers (handles pacman + paru for AUR)
- `state-` - manage state files in `~/.local/state/barchyreborn/`
- `restart-` - restart a component
- `launch-` - open applications
- `install-` - install optional software
- `setup-` - interactive setup wizards
- `toggle-` - toggle features on/off
- `theme-` - theme management (omarchy-compatible)
- `theme-bg-` - background image cycling within themes
- `update-` - update system components
- `system-` - system operations (reboot, etc.)
- `hook` - run named hooks from `~/.config/barchyreborn/hooks/`
- `migrate` - run config migrations between versions

# Helper Commands

Use these instead of raw shell commands:

- `barchyreborn-cmd-missing` / `barchyreborn-cmd-present` - check for commands
- `barchyreborn-pkg-missing` / `barchyreborn-pkg-present` - check for packages
- `barchyreborn-pkg-add` - install packages (pacman for official, paru for AUR)
- `barchyreborn-pkg-aur-accessible` - check if AUR is reachable

# Config Structure

- `install/` - installation pipeline scripts (5 phases: helpers → preflight → packaging → config → login → post-install)
- `default/` - default configs copied to `~/.config/` on install
- `default/themed/*.tpl` - templates with `{{ variable }}` placeholders for theme colors
- `themes/` - symlinked to omarchy's themes for compatibility (any omarchy theme works)
- `packages/base.packages` - curated package list (~50 packages)

# Refresh Pattern

To copy a default config to user config with automatic backup:

```bash
# Copy from barchyreborn's defaults to ~/.config/
cp -r "$BARCHYREBORN_PATH/default/hypr/"* "$HOME/.config/hypr/"
```

# Migrations

Migration files in `migrations/*.sh` run after updates. Naming convention: unix timestamp of when the migration was created.

Migration format:
- No shebang line
- Start with an `echo` describing what the migration does
- Use `$BARCHYREBORN_PATH` to reference the barchyreborn directory

Example:
```bash
echo "Disable fingerprint in hyprlock if fingerprint auth is not configured"

if barchyreborn-cmd-missing fprintd-list || ! fprintd-list "$USER" 2>/dev/null | grep -q "finger"; then
  sed -i 's/fingerprint:enabled = .*/fingerprint:enabled = false/' ~/.config/hypr/hyprlock.conf
fi
```

# Installation Pipeline

The install system runs in 6 phases (sourced in order from `install.sh`):

1. **helpers/** - Core utilities always loaded first: logging, errors, presentation, chroot detection
2. **preflight/** - Environment checks: guard, begin, show-env, pacman, migrations, first-run-mode, disable-mkinitcpio
3. **packaging/** - Package installation: base (reads `packages/base.packages`), fonts, icons, nvim
4. **config/** - Config files + hardware detection: theme, git, bluetooth, network, audio, wifi-power, usb-autosuspend, hardware/detect
5. **login/** - Display manager: sddm, plymouth
6. **post-install/** - Final touches: hibernation, pacman hooks, allow-reboot, finished screen

Each script is wrapped by `run_logged` which pipes output to `/var/log/barchyreborn-install.log` with timestamps.

# Omarchy Compatibility

Barchyreborn is designed to be omarchy-compatible in key areas:

**Themes:**
- All 19 omarchy themes (tokyo-night, catppuccin, nord, gruvbox, etc.) work via symlinks in `themes/`
- `barchyreborn-theme-install https://github.com/...` auto-strips `omarchy-` and `-theme` from repo names
- Theme system uses identical `colors.toml` format and `{{ variable }}` template syntax
- Neovim, waybar, mako, btop configs all generated from templates

**Bin scripts:**
- `barchyreborn-theme-set` checks `~/.config/omarchy/themes/` as a fallback theme source
- `barchyreborn-theme-list` scans both `barchyreborn/` and `omarchy/` theme directories

# Update System

The update system is git-tag-based:

- `barchyreborn-update-available` checks `git ls-remote --tags` against local tag
- Waybar shows update indicator when a new tag is detected
- `barchyreborn-update` creates btrfs snapshot, git pull, pacman update, paru update, migrations, restart
- All update scripts use PTY logging via `script` command

Update flow:
```
barchyreborn-update
  → confirm dialog
  → barchyreborn-snapshot create
  → barchyreborn-update-git
  → barchyreborn-update-perform
      → barchyreborn-update-system-pkgs (pacman -Syyu)
      → barchyreborn-update-aur-pkgs (paru -Sua)
      → barchyreborn-migrate
      → barchyreborn-hook post-update
      → barchyreborn-update-restart (kernel/hyprland reboot detection)
```

# Current Project Status

## Active Development

Barchyreborn is a minimal omarchy fork — a lightweight Arch Linux Hyprland setup. The core install pipeline and update system are complete. The project is ready for testing and iterative refinement.

## Recently Completed

- ✅ Core install pipeline (6-phase system)
- ✅ Theme system with omarchy compatibility (19 themes via symlinks)
- ✅ 34 bin helper scripts (pkg, cmd, theme, restart, update, hook, state)
- ✅ Minimal curated package list (~50 packages)
- ✅ Default configs: hyprland, waybar, mako, sddm, plymouth
- ✅ Full update system with btrfs snapshots, git tags, waybar indicator
- ✅ Git commit history (2 commits)

## Known Gaps / TODO

- [x] Replace all `YOUR_GITHUB_USERNAME` placeholders with actual username
- [ ] Hyprlock config not yet written (lockscreen)
- [ ] Hypridle config not yet written (idle management)
- [ ] Waybar style.css uses placeholder `{{ variables }}` but needs full theme variable coverage
- [ ] Ghostty terminal config not yet written (alternative to alacritty)
- [ ] Nix/pacman mirror config not yet written (needs `default/pacman/mirrorlist-*` files)
- [ ] `barchyreborn-snapshot restore` not implemented
- [ ] First-run wizard scripts not yet written (wifi.sh, firewall.sh, welcome.sh)
- [ ] No migration scripts created yet (migrations/ is empty)
- [ ] No post-update hook template (`~/.config/barchyreborn/hooks/post-update`)
- [ ] `barchyreborn-refresh-config` command not created (omarchy's refresh pattern)
- [ ] `barchyreborn-dev-add-migration` helper not created
- [ ] Package list may need trimming — mpv + vlc overlap, nautilus-python may not be needed
- [ ] `default/systemd/ldconfig.hook` references wrong path — should be a pacman hook, not systemd
- [ ] No `barchyreborn-env` file for user environment variables
- [ ] `barchyreborn-pkg-add` needs sudo check — currently doesn't verify EUID

## Philosophy

- **Minimal by default** — only packages that are actually used
- **Omarchy-compatible** — themes, migrations, and commands work with omarchy ecosystem
- **Two-way compat** — barchyreborn users can use omarchy themes; future omarchy users could use barchyreborn themes
- **Paru over yay** — AUR helper is paru, not yay
- **Btrfs + snapper** — snapshot-before-update for safety
- **Git-tag versioning** — release tags trigger waybar update indicator