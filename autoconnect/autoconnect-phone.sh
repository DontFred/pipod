#!/bin/bash

# Define the specific MAC address of the device you want to connect to
# Leave empty if you want to try connecting to all previously paired devices
TARGET_DEVICE="<<BLUETOOTH MAC ADDRESS>>"  # Replace with the MAC address of your target device

# Check the connection status of all devices
DEVICE_STATUS=$(bluetoothctl devices | cut -f2 -d' ' | while read uuid; do bluetoothctl info $uuid; done)

if echo "$DEVICE_STATUS" | grep -q 'Connected: yes'; then
    echo "A device is already connected."
    systemctl stop autoconnect-phone
else
    echo "No device is connected. Attempting to connect."

    if [[ -z "$TARGET_DEVICE" ]]; then
        # Attempt to connect to all previously paired devices
        bluetoothctl devices | cut -f2 -d' ' | while read uuid; do
            echo "Attempting to connect to device with UUID $uuid"
            bluetoothctl connect $uuid
        done
    else
        # Attempt to connect to the specific target device
        echo "Attempting to connect to target device with UUID $TARGET_DEVICE"
        bluetoothctl connect $TARGET_DEVICE
    fi
fi
