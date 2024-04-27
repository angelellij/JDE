#!/bin/bash

# Get the current date and time
current_date=$(date +"%d/%m/%Y")
current_time=$(date +"%H:%M")

# Send the notification to Dunst
notify-send "Date and Time" "$current_date"$'\n'"$current_time"
