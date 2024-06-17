#!/bin/bash

# Create a temporary user data directory
USER_DATA_DIR=$(mktemp -d -t chrome-XXXXXX)

# Define a function to clean up the temporary directory upon exit
cleanup() {
    echo "Deleting temporary directory: $USER_DATA_DIR"
    rm -rf "$USER_DATA_DIR"
}
trap cleanup EXIT

# Get the current version of Chrome
CHROME_VERSION=$(google-chrome --version | awk '{print $3}')
IFS='.' read -r -a VERSION_PARTS <<< "$CHROME_VERSION"

# Randomly change one of the version numbers (except the first one)
RANDOM_PART=$((RANDOM % 3 + 1))
VERSION_PARTS[$RANDOM_PART]=$((VERSION_PARTS[$RANDOM_PART] + RANDOM % 10))

# Reconstruct the modified version
MODIFIED_VERSION="${VERSION_PARTS[0]}.${VERSION_PARTS[1]}.${VERSION_PARTS[2]}.${VERSION_PARTS[3]}"

# Base User-Agent string
BASE_USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome"

# Construct the modified User-Agent
RANDOM_USER_AGENT="$BASE_USER_AGENT/$MODIFIED_VERSION Safari/537.36"

# Launch Google Chrome with the temporary user data directory and other options to minimize fingerprinting
google-chrome --user-data-dir="$USER_DATA_DIR" \
              --no-first-run \
              --no-default-browser-check \
              --incognito \
              --start-maximized \
              --disable-plugins \
              --disable-popup-blocking \
              --disable-background-networking \
              --disable-default-apps \
              --disable-sync \
              --metrics-recording-only \
              --safebrowsing-disable-auto-update \
              --disable-background-timer-throttling \
              --disable-backgrounding-occluded-windows \
              --disable-renderer-backgrounding \
              --disable-device-discovery-notifications \
              --no-pings \
              --disable-hang-monitor \
              --disable-translate \
              --disable-features=WebRtcHideLocalIpsWithMdns,BatteryStatus,KeyboardLockAPI,EnumerateDevices,WebBluetooth,WebUSB,WebXR,WebRTC,TranslateUI,NotificationPresenter,TranslateUI \
              --user-agent="$RANDOM_USER_AGENT" \
              --lang=en-US \
              --flag-switches-begin \
              --disable-features=UserAgentClientHint \
              --flag-switches-end \
              --disable-webrtc-hw-encoding \
              --disable-webrtc-hw-decoding \
              --disable-webrtc-multiple-routes \
              --disable-webrtc-stun-origin \
              --disable-webrtc-event-logging \
              "$@"

# Wait for Chrome to close (the trap will execute after this)
wait $!
