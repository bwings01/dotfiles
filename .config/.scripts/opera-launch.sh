#!/bin/bash
# Switch to workspace 2 (example)
hyprctl dispatch workspace 1

if ! pgrep -x "opera" > /dev/null; then
    nohup env GDK_BACKEND=x11 /usr/bin/opera > /dev/null 2>&1 &
else
    hyprctl dispatch focuswindow "opera"
fi
