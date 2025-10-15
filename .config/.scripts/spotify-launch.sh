#!/bin/bash
# Switch to workspace 7
hyprctl dispatch workspace 7
sleep 0.2  # give time to switch workspace

# Spotify executable path
SPOTIFY_PATH="/usr/bin/spotify"

# Check if Spotify is already running
if pgrep -x "spotify" >/dev/null; then
    # Get the window address of Spotify (case-insensitive search)
    WINADDR=$(hyprctl clients -j | jq -r '.[] | select(.class | test("spotify"; "i")) | .address' | head -n 1)
    if [ -n "$WINADDR" ]; then
        # Focus the existing Spotify window
        hyprctl dispatch focuswindow address:"$WINADDR"
        exit 0
    fi
fi

# If not running or no window found, start Spotify
nohup env GDK_BACKEND=x11 "$SPOTIFY_PATH" >/dev/null 2>&1 &
