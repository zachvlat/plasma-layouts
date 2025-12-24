# Plasma Layout Manager

A simple yet powerful tool that allows you to easily manage and switch between different KDE Plasma desktop layouts. With just a few clicks, you can completely transform the look and feel of your desktop.

## Features

- **Pre-configured Layouts**: Comes with several carefully crafted layouts:
  - **Cosmic** - Modern space-themed desktop with cosmic aesthetics
  - **Ubuntu** - Classic Ubuntu-style dock and panel layout  
  - **Windows** - Windows 11 inspired taskbar and start menu
  - **WM** - Window manager focused minimal layout

- **Safe Operation**: Automatically creates backups of your current configuration before applying any changes
- **Responsive UI**: Clean and intuitive interface built with Qt/QML
- **Multi-language Support**: Available in multiple languages
- **Flatpak Support**: Install and run as a sandboxed application

## Installation

### Flatpak (Recommended)

   ```bash
   flatpak run org.flatpak.Builder --force-clean --repo=repo build-flatpak org.zachvlat.plasmalayouts.json
   flatpak build-bundle repo org.zachvlat.plasmalayouts.flatpak org.zachvlat.plasmalayouts

   ```

## Usage

### Running the Application

Via Flatpak:
```bash
flatpak run org.zachvlat.plasmalayouts
```

Via system installation:
```bash
./plasma_layouts
```

### Applying Layouts

1. Launch the application
2. Browse the available layouts in the main interface
3. Click on any layout to preview it
4. Click "Apply" to set the layout
5. Your current configuration will be automatically backed up

### Creating Custom Layouts

1. Configure your Plasma desktop exactly as you want it
2. Export the configuration using the "Save Current Layout" feature
3. Give your layout a name and description
4. Your custom layout will appear in the main interface

## Configuration

Layouts are stored as Plasma configuration files in:
- `~/.config/plasma-org.kde.plasma.desktop-appletsrc` (main configuration)
- Backup files are stored with timestamp in `~/.config/plasma-layouts/backups/`

### Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Requirements

- **Qt 6.8+**: Core UI framework
- **KDE Plasma 6.8+**: Desktop environment
- **CMake 3.16+**: Build system
- **Linux**: Supported operating system

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

## Support

- **Issues**: Report bugs and feature requests on [GitHub Issues](https://github.com/zachvlat/plasma-layouts/issues)
- **Documentation**: Check the [Wiki](https://github.com/zachvlat/plasma-layouts/wiki) for detailed guides
- **Community**: Join our discussions on GitHub

## Acknowledgments

- KDE Plasma team for the excellent desktop environment
- Qt team for the powerful UI framework
- All contributors and users who help improve this project