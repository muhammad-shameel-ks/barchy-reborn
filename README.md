# Barchyreborn

Barchyreborn is a lightweight, "no-bloat" Arch Linux Hyprland configuration framework based on the Omarchy philosophy. It provides a modular, themeable, and highly efficient desktop experience.

## Features

- **Minimal & Fast**: Only ~50 core packages for a lean footprint.
- **Hyprland Native**: Fully configured tiling window manager with modular settings.
- **Atomic Theming**: Dynamic theme switching with live previews via Walker.
- **Safety First**: Automatic Btrfs snapshots before system updates via Snapper.
- **Modern UI**: Waybar, Mako notifications, and the Walker application runner.

## Installation

To install Barchyreborn on a fresh Arch Linux installation, run the following command:

```bash
curl -sL https://raw.githubusercontent.com/muhammad-shameel-ks/barchy-reborn/master/boot.sh | bash
```

**Requirements:**
- A base Arch Linux installation.
- Btrfs filesystem (highly recommended for snapshots).
- An active internet connection.

## Post-Installation

On your first login, a **Welcome Wizard** will guide you through:
- WiFi setup.
- Pacman mirror optimization.
- Firewall configuration.
- Initial Btrfs snapshot creation.

## Credits

Barchyreborn is a fork and spiritual successor to [Omarchy](https://github.com/omarchy/omarchy), maintaining architectural compatibility while focusing on a leaner core.
