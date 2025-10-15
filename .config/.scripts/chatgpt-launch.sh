#!/usr/bin/env bash

# --- Launch ChatGPT ---
hyprctl dispatch workspace 5
if ! pgrep -fa "chromium" | grep -qi "https://chat.openai.com"; then
    nohup env GDK_BACKEND=x11 chromium --app="https://chat.openai.com" \
        --class=chatgpt --name=chatgpt --new-window > /dev/null 2>&1 &
fi