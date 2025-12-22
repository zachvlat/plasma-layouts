#!/bin/bash

# Plasma Layout Manager Flatpak Build Script
# This script helps build and install the Plasma Layout Manager as a Flatpak

set -e

# Configuration
APP_ID="org.zachvlat.plasmalayouts"
MANIFEST_FILE="org.zachvlat.plasmalayouts.json"
BUILD_DIR="build-flatpak"

echo "🚀 Building Plasma Layout Manager Flatpak..."

# Check dependencies
if ! command -v flatpak &> /dev/null; then
    echo "❌ Error: flatpak is not installed"
    exit 1
fi

if ! command -v flatpak-builder &> /dev/null; then
    echo "❌ Error: flatpak-builder is not installed"
    echo "Install it with: sudo apt install flatpak-builder"
    exit 1
fi

# Check if KDE runtime is available
echo "📦 Checking KDE runtime..."
if ! flatpak list --runtime | grep -q "org.kde.Platform.*6.8"; then
    echo "⚠️  KDE Platform 6.8 runtime not found"
    echo "Install it with:"
    echo "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo"
    echo "flatpak install flathub org.kde.Platform//6.8 org.kde.Sdk//6.8"
    echo ""
    read -p "Do you want to install the KDE runtime now? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        flatpak install flathub org.kde.Platform//6.8 org.kde.Sdk//6.8
    else
        echo "❌ Cannot continue without KDE runtime"
        exit 1
    fi
fi

# Clean previous build
if [ -d "$BUILD_DIR" ]; then
    echo "🧹 Cleaning previous build..."
    rm -rf "$BUILD_DIR"
fi

# Create build directory
mkdir -p "$BUILD_DIR"

# Build the Flatpak
echo "🔨 Building Flatpak package..."
flatpak-builder --force-clean --install --user \
    --repo=repo \
    "$BUILD_DIR" \
    "$MANIFEST_FILE"

# Update appstream
echo "📱 Updating appstream information..."
flatpak --user update appstream org.kde.Platform//6.8

echo "✅ Build completed successfully!"
echo ""
echo "📱 To run the application:"
echo "flatpak run $APP_ID"
echo ""
echo "🔧 To uninstall:"
echo "flatpak --user uninstall $APP_ID"
echo ""
echo "📦 To create a distributable .flatpak file:"
echo "flatpak build-bundle repo ${APP_ID}.flatpak $APP_ID"