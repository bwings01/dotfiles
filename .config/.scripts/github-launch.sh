#!/usr/bin/env bash

# --- Launch GitHub ---
hyprctl dispatch workspace 4
if ! pgrep -f "chromium.*github" >/dev/null; then
    nohup env GDK_BACKEND=x11 chromium --app="https://github.com" \
        --class=github --name=github --new-window > /dev/null 2>&1 &
fi