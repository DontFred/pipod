#!/bin/bash
set -eu

username='<<Username>>'

loginctl enable-linger $username

# configure bluetooth
bluetoothaudioconfig='[General]
Class = 0x20041C
Enable = Source,Sink,Media,Socket'
echo "$bluetoothaudioconfig" > /etc/bluetooth/audio.conf

# setup a udev rule to automatically connect the bluetooth A2DP source to the Pulseaudio sink
cp udev/81-input-a2dp-autoconnect.rules /etc/udev/rules.d/
cp udev/99-bluetooth-service-restart.rules /etc/udev/rules.d/