# PiPod

A bunch of scripts and configs that allows streaming audio via bluetooth to a [fake ipod device](https://github.com/dangerzau/ipod-gadget).

Useful if your car only supports Apple devices for some reason (why Fiat and Alfa, why).

Tested on:
*  Raspberry Pi Zero W (Raspbian Stretch Lite 2018-11-13)

## Assumptions
*  You have a device (e.g. a car) that supports playing music from an iPhone/iPod etc. over USB. You want to play music from something else (e.g. an Android phone) over bluetooth.
*  OS: Raspbian Stretch Lite

## Build and Install
1.  Install Golang, Git, raspberrypi-kernel-headers. 
2.  Then clone the repository `git clone --recurse-submodules https://github.com/DontFred/pipod.git`.
3.  Change username in script a2dp-autoconnect.
4.  Compile the Go package with `GO111MODULE=on GOOS=linux GOARCH=arm GOARM=6 go build github.com/amitojsingh366/ipod/cmd/ipod` and put it into install_files.
5.  add `dtoverlay=dwc2` to the end of /boot/firmware/config.txt to enable USB gadget mode
6.  compile the kernel modules (ipod-gadget directory) and put the .ko files in install_files
7.  copy the pipod directory to the Pi
8.  run `sudo ./install.sh`
9.  [enable auto login](https://gist.github.com/oleq/24e09112b07464acbda1#autologin) so that Pulseaudio can start automatically
10.  edit the file `autoconnect_phone.sh`.
Replace the `TARGET_DEVICE` variable with your bluetooth device's MAC address
11.  edit the file `a2dp-autoconnect`.
Replace the `NAME` variable with your bluetooth device's MAC address.
Also make sure that if you run `pactl list sources short`, the value of `$PA_SINK` shows up in the output.
12.  [Pair and trust](https://gist.github.com/oleq/24e09112b07464acbda1#setup-bluetooth) your bluetooth device
13.  Reboot, connect everything (USB to car; manually connect phone via bluetooth) and test!


## TODO:
*  Figure out how to get the Pi to automatically connect to the bluetooth device (currently you have to manually connect from the device)
*  Use DKMS to auto-build and install kernel modules
*  Investigate Pulseaudio 11 which can maybe bypass resampling
