#!/bin/bash
set -eu

depmod -a
modprobe -r g_ipod_gadget
modprobe -r g_ipod_hid
modprobe -r g_ipod_audio
modprobe libcomposite
modprobe g_ipod_audio
modprobe g_ipod_hid
modprobe g_ipod_gadget

mkdir -p /var/log/ipod
touch /tmp/shairport-sync-metadata

exec ipod -d serve -w /var/log/ipod/$(date -Iseconds).trace /dev/iap0