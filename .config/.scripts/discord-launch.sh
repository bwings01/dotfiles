#!/bin/bash
# Switch to workspace 6
hyprctl dispatch workspace 6

# Launch Discord if it's not running, or focus it if it is
if ! pgrep -x "discord" > /dev/null; then
    nohup env GDK_BACKEND=x11 /usr/bin/discord --no-sandbox --disable-gpu > /dev/null 2>&1 &
else
    # Optional: focus existing Discord window
    hyprctl dispatch focuswindow "discord"
fi

