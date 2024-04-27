#!/bin/bash

options=("Sound settings" "Bluetooth" "Wifi")

case $1 in
    "Sound settings")
        coproc eval "pavucontrol > /dev/null 2>&1"
        exit 0
        ;;
    "Bluetooth")
        coproc eval "blueman-manager > /dev/null 2>&1"
        exit 0
        ;;
    "Wifi")
        coproc eval .config/rofi/wifi.sh
        exit 0
        ;;
    *)
        ;;
esac

for option in "${options[@]}"; do
    echo "$option"
done

./.config/rofi/msg.sh