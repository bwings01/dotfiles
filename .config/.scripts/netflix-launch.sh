#!/usr/bin/env bash

# --- Launch Netflix ---
hyprctl dispatch workspace 8
if ! pgrep -fa "chromium.*netflix" >/dev/null; then 
  nohup env GDK_BACKEND=x11 chromium \
    --user-data-dir=/home/braeden/.config/chromium-endeavour \
    --app="https://www.netflix.com" \
    --class=netflix --name=netflix --new-window \
    >/dev/null 2>&1 &
else
  hyprctl dispatch focuswindow "chromium.*netflix"
fi
