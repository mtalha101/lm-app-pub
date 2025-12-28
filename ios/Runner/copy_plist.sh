#!/bin/sh

# Get the build configuration
CONFIGURATION=$CONFIGURATION

# Set the source and destination paths
if [ "$CONFIGURATION" = "Debug-development" ] || [ "$CONFIGURATION" = "Release-development" ]; then
    SOURCE_PATH="${SRCROOT}/config/development/GoogleService-Info.plist"
elif [ "$CONFIGURATION" = "Debug-production" ] || [ "$CONFIGURATION" = "Release-production" ]; then
    SOURCE_PATH="${SRCROOT}/config/production/GoogleService-Info.plist"
else
    echo "Error: Invalid configuration: $CONFIGURATION"
    exit 1
fi

DESTINATION_PATH="${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"

# Copy the file
cp "$SOURCE_PATH" "$DESTINATION_PATH" 