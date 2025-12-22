# Plasma Layout Manager - Flatpak Build Instructions

This document explains how to build and install the Plasma Layout Manager as a Flatpak application.

## Prerequisites

### Required Tools
- `flatpak` - Package management for Linux
- `flatpak-builder` - Tool for building Flatpak packages
- KDE Plasma runtime (6.8)

### Installing Dependencies

On Ubuntu/Debian:
```bash
sudo apt update
sudo apt install flatpak flatpak-builder
```

On Fedora:
```bash
sudo dnf install flatpak flatpak-builder
```

On Arch:
```bash
sudo pacman -S flatpak flatpak-builder
```

### Setting up Flathub and KDE Runtime
```bash
# Add Flathub repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install KDE Platform and SDK
flatpak install flathub org.kde.Platform//6.8
flatpak install flathub org.kde.Sdk//6.8
```

## Building the Flatpak

### Quick Build (Recommended)
Use the provided build script:
```bash
./build-flatpak.sh
```

### Manual Build
If you prefer to build manually:

1. **Create build directory:**
   ```bash
   mkdir build-flatpak
   ```

2. **Build the Flatpak:**
   ```bash
   flatpak-builder --force-clean --install --user \
       --repo=repo \
       build-flatpak \
       org.kde.plasmalayouts.json
   ```

3. **Update appstream:**
   ```bash
   flatpak --user update appstream org.kde.Platform//6.8
   ```

## Running the Application

After installation:
```bash
flatpak run org.kde.plasmalayouts
```

Or find it in your application menu as "Plasma Layout Manager".

## Creating Distributable Package

To create a `.flatpak` file for distribution:
```bash
flatpak build-bundle repo org.kde.plasmalayouts.flatpak org.kde.plasmalayouts
```

## File Permissions

The application requires special permissions to access Plasma configuration files:

- `--filesystem=~/.config/plasma-org.kde.plasma.desktop-appletsrc:rw` - Read/write access to Plasma config
- `--filesystem=~/.config/plasma-org.kde.plasma.desktop-appletsrc.backup:rw` - Backup file access
- `--filesystem=home:ro` - Read-only access to home directory

These permissions are defined in `org.kde.plasmalayouts.json`.

## Security Considerations

The application needs elevated permissions to modify Plasma configuration files. Only install from trusted sources.

## Testing

To test changes without installation:
```bash
flatpak-builder --run build-flatpak org.kde.plasmalayouts.json appplasma_layouts
```

## Troubleshooting

### Common Issues

1. **KDE Runtime Not Found**
   - Ensure you have the correct KDE runtime installed
   - Check with `flatpak list --runtime`

2. **Build Fails**
   - Verify all dependencies are installed
   - Check build logs for specific errors

3. **Permission Issues**
   - The app needs write access to Plasma config files
   - These permissions are included in the manifest

4. **Icon Not Showing**
   - Ensure icon files are properly installed
   - Run `update-desktop-database`

### Getting Help

For issues with the Flatpak build process:
- Check Flatpak documentation: https://docs.flatpak.org/
- File an issue in the project repository

## Distribution

To distribute your Flatpak:

1. Upload the `.flatpak` file to a hosting service
2. Include installation instructions
3. Consider submitting to Flathub for wider distribution

## Flatpak Manifest Details

The `org.kde.plasmalayouts.json` manifest includes:
- Qt6 and KDE Platform runtime
- Filesystem permissions for Plasma configuration
- Icon installation in standard sizes
- Desktop file and appdata installation
- CMake build system integration