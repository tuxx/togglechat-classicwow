#!/bin/bash

# ToggleChat CurseForge Package Script
# This script creates a zip file ready for CurseForge upload

# Extract version from TOC file
VERSION=$(grep "^## Version:" ToggleChat.toc | cut -d' ' -f3)
ADDON_NAME="ToggleChatVisibility"
PACKAGE_NAME="${ADDON_NAME}-${VERSION}.zip"

echo "Creating CurseForge package for ${ADDON_NAME} v${VERSION}..."

# Create a temporary directory for packaging
TEMP_DIR=$(mktemp -d)
CURRENT_DIR=$(pwd)
PACKAGE_DIR="${TEMP_DIR}/${ADDON_NAME}"

# Create the addon directory structure
mkdir -p "${PACKAGE_DIR}"

# Copy addon files
cp ToggleChat.toc "${PACKAGE_DIR}/"
cp ToggleChat.lua "${PACKAGE_DIR}/"
cp Bindings.xml "${PACKAGE_DIR}/"

# Create the zip file
cd "${TEMP_DIR}"
zip -r "${PACKAGE_NAME}" "${ADDON_NAME}/"

# Move the zip file to the current directory
mv "${PACKAGE_NAME}" "${CURRENT_DIR}"

# Clean up
rm -rf "${TEMP_DIR}"

echo "Package created: ${PACKAGE_NAME}"
echo "Ready for CurseForge upload!" 
