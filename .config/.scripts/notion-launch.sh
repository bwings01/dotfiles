#!/usr/bin/env bash

# --- Launch Notion ---
hyprctl dispatch workspace 2
if ! pgrep -fa "chromium.*notion" >/dev/null; then 
  nohup env GDK_BACKEND=x11 chromium \
    --user-data-dir=/home/braeden/.config/chromium-endeavour \
    --app="https://www.notion.so" \
    --class=notion --name=notion --new-window \
    >/dev/null 2>&1 &
else
  hyprctl dispatch focuswindow "chromium.*notion"
fi
