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

1. Add Flathub repository if you haven't already:
   ```bash
   flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
   ```

2. Install the KDE Platform runtime (required):
   ```bash
   flatpak install flathub org.kde.Platform//6.8 org.kde.Sdk//6.8
   ```

3. Build and install from source:
   ```bash
   flatpak run org.flatpak.Builder --force-clean --repo=repo build-flatpak org.zachvlat.plasmalayouts.json
   flatpak install --user org.zachvlat.plasmalayouts
   ```

### Building from Source

1. Install dependencies:
   ```bash
   # Ubuntu/Debian
   sudo apt install qt6-base-dev qt6-declarative-dev cmake extra-cmake-modules
   
   # Fedora
   sudo dnf install qt6-qtbase-devel qt6-qtdeclarative-devel cmake extra-cmake-modules
   ```

2. Clone and build:
   ```bash
   git clone https://github.com/zachvlat/plasma-layouts.git
   cd plasma-layouts
   mkdir build && cd build
   cmake ..
   make
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

## Development

### Project Structure

```
.
├── main.cpp              # Application entry point
├── layouthandler.{cpp,h}  # Layout management logic
├── Main.qml              # Main application interface
├── LayoutCard.qml        # Layout card component
├── assets/               # Pre-configured layouts
│   ├── Cosmic/
│   ├── Ubuntu/
│   ├── Windows/
│   └── WM/
└── org.zachvlat.plasmalayouts.json  # Flatpak manifest
```

### Building Flatpak Bundle

To create a distributable .flatpak file:

```bash
flatpak run org.flatpak.Builder --force-clean --repo=repo build-flatpak org.zachvlat.plasmalayouts.json
flatpak build-bundle repo org.zachvlat.plasmalayouts.flatpak org.zachvlat.plasmalayouts
```

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

## Troubleshooting

### Common Issues

**Layout not applying correctly:**
- Ensure Plasma is running
- Try restarting Plasma with `plasmashell --replace`
- Check file permissions in `~/.config/`

**Flatpak not working:**
- Verify all dependencies are installed
- Check if the KDE runtime is installed
- Ensure proper permissions for home directory access

**Application crashes:**
- Check system logs with `journalctl -f`
- Verify Qt and Plasma versions are compatible
- Report issues on GitHub with detailed logs

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

---

**Plasma Layout Manager** - Transform your desktop with ease 🎨✨