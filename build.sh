#!/usr/bin/env bash
set -euo pipefail

APP_NAME="CalendarWeek"
BUILD_DIR="build"
APP_BUNDLE="${BUILD_DIR}/${APP_NAME}.app"
MACOS_DIR="${APP_BUNDLE}/Contents/MacOS"

echo "Building ${APP_NAME}..."

# Clean previous build
rm -rf "${BUILD_DIR}"
mkdir -p "${MACOS_DIR}"

# Compile (targets current machine architecture)
swiftc Sources/main.swift \
    -o "${MACOS_DIR}/${APP_NAME}" \
    -Onone \
    2>&1

# Copy Info.plist
cp Info.plist "${APP_BUNDLE}/Contents/"

echo ""
echo "Built: ${APP_BUNDLE}"
echo ""
echo "Run now:    open '${APP_BUNDLE}'"
echo "Install:    cp -r '${APP_BUNDLE}' ~/Applications/ && open ~/Applications/${APP_NAME}.app"
