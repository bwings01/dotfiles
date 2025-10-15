#!/usr/bin/env bash

# --- Launch GitHub ---
hyprctl dispatch workspace 4
if ! pgrep -f "chromium.*github" >/dev/null; then
  nohup env GDK_BACKEND=x11 chromium \
    --user-data-dir=/home/braeden/.config/chromium-endeavour \
    --app="https//github.com" \
    --class=github --name=github --new-window \
    >/dev/null 2>&1 &
else
  hyprctl dispatch focuswindow "chromium.*github"
fi
