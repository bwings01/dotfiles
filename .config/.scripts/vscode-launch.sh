#!/usr/bin/env bash

# Switch to workspace 3 first
hyprctl dispatch workspace 3

# Wait briefly to ensure switch
sleep 0.5

# Launch VS Code specifically on workspace 3
if ! pgrep -x "code-oss" > /dev/null; then
    hyprctl dispatch exec "[workspace 3] code"
else
    hyprctl dispatch focuswindow "code"
fi
