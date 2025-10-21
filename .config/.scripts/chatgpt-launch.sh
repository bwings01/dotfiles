#!/usr/bin/env bash

# --- Launch ChatGPT ---
hyprctl dispatch workspace 5
if ! pgrep -fa "chromium.*chat.openai.com" >/dev/null; then
  nohup env GDK_BACKEND=x11 chromium \
    --user-data-dir=/home/braeden/.config/chromium-endeavour \
    --app="https://chat.openai.com" \
    --class=ChatGPT --name=ChatGPT --new-window \
    >/dev/null 2>&1 &
else
  hyprctl dispatch focuswindow "chromium.*chatgpt"
fi
