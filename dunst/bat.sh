#!/bin/bash

# Get battery percentage
battery_percentage=$(upower -i $(upower -e | grep 'BAT') | grep -E "percentage" | awk '{ print $2 }')

# Send notification using Dunst
notify-send "Battery Percentage" "$battery_percentage"
