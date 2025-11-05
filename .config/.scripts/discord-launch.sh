#!/bin/bash
# Switch to workspace 6
hyprctl dispatch workspace 6

# Launch Vesktop (custom Discord client) if it's not running, or focus it if it is
if ! pgrep -x "vesktop" > /dev/null; then
    nohup env GDK_BACKEND=x11 vesktop --no-sandbox --disable-gpu > /dev/null 2>&1 &
else
    # Optional: focus existing Vesktop window
    hyprctl dispatch focuswindow "vesktop"
fi