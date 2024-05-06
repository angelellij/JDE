#!/bin/bash

# Connect to i3 IPC
i3-msg -t subscribe -m '[{"change":"workspace"}]' | while read -r line ; do
    # Parse the output to get the current workspace
    workspace=$(echo $line | jq -r '.current.name')

    notify-send -t 750 "Workspace: $workspace"
done
