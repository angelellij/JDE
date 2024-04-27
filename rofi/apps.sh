#!/bin/bash

display_names=()
exec_commands=()

while IFS= read -r file; do
    # Check if 'rofi' is set to false or 'NoDisplay' is set to true
    if ! grep -qE '^\s*(Rofi\s*=\s*(false|true)|NoDisplay\s*=\s*true)\s*$' "$file"; then
        app_name=$(grep -e '^Name=' "$file" | sed 's/^Name=//')
        exec_command=$(grep -e '^Exec=' "$file" | sed -n '1p' | sed 's/^Exec=//') # Take only the first Exec line
        if [ -n "$app_name" ] && [ -n "$exec_command" ]; then
            display_names+=("$app_name")
            exec_commands+=("$exec_command")
        fi
    fi
done < <(find /usr/share/applications -name '*.desktop')

if [[ -n "$1" ]]; then
    for ((i = 0; i < ${#display_names[@]}; i++)); do
        if [[ "${display_names[i]}" == *"$1"* ]]; then
            exec_command="${exec_commands[i]}"
            eval "$exec_command" > /dev/null 2>&1 &
            exit 0
        fi
    done
fi

for name in "${display_names[@]}"; do
    echo "$name"
done

./.config/rofi/msg.sh
