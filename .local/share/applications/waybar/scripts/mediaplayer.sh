#!/usr/bin/env bash

# Get artist and title using playerctl
artist=$(playerctl -p spotify metadata artist 2>/dev/null)
title=$(playerctl -p spotify metadata title 2>/dev/null)

# If Spotify isn’t playing anything, display nothing or a placeholder
if [ -z "$artist" ] && [ -z "$title" ]; then
    echo '{"text": "No music playing"}'
    exit 0
fi

# Combine artist and title
song="$artist - $title"

# Truncate if it's too long (optional)
max_length=50
if [ ${#song} -gt $max_length ]; then
    song="${song:0:$max_length}..."
fi

# Output as JSON for Waybar
echo "{\"text\": \"$song\"}"
