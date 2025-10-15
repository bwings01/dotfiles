
#!/usr/bin/env bash
# --- Launch GitHub ---
hyprctl dispatch workspace 4

# If GitHub app not open, launch it
if ! pgrep -fa "chromium.*https://github.com" >/dev/null; then
    nohup env GDK_BACKEND=x11 chromium \
        --user-data-dir=/home/braeden/.config/chromium-main \
        --app="https://github.com" \
        --class=github --name=github --new-window \
        >/dev/null 2>&1 &
else
    # Focus GitHub window if it already exists
    hyprctl dispatch focuswindow "github"
fi

