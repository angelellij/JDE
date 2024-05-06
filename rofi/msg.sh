#!/bin/bash

# Get the current date and time
current_date=$(date +"%d/%m/%Y")
current_time=$(date +"%H:%M")

#Baterry
bat=$(upower -i $(upower -e | grep 'BAT') | grep -E "percentage" | awk '{ print $2 }')

#Bluetooth
blue="OFF"
if systemctl is-active bluetooth >/dev/null 2>&1; then
    blue="ON"
fi

#Internet
net=$(nmcli -t -f NAME connection show --active | head -n 1)

# #RAM
# ram=$(free -h | awk 'NR==2 {print $3}')

# #CPU
# cpu_temp=$(sensors | grep -i 'Package id 0' | awk '{print $4}'
# )

echo -en "\0message\x1fBattery: "$bat" - Date: "$current_date" - Time: "$current_time"\n"