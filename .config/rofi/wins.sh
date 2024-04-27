#!/bin/bash

# Get active window IDs and their workspaces
active_window_info=$(wmctrl -l -p | grep -v "Desktop" | awk '{print $1, $3}')

# Sort the active window info by workspace
sorted_active_window_info=$(echo "$active_window_info" | sort -k2)

# Get window titles for active windows
active_window_titles=()
active_window_ids=()
while read -r id workspace; do
    title=$(wmctrl -l -p | grep "$id" | awk '{$1=""; $3=""; $4=""; print $0}')
    active_window_titles+=("$title")
    active_window_ids+=("$id")
done <<< "$sorted_active_window_info"

# Activate selected window
if [ -n "$1" ]; then
    index=$(echo -e "${active_window_titles[@]}" | grep -Fnx "$1" | cut -d: -f1)
    wmctrl -ia "${active_window_ids[index]}"
fi

for win in "${active_window_titles[@]}"; do
    echo "$win"
done

./.config/rofi/msg.sh