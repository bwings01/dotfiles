#!/usr/bin/env bash

# Count pending updates (official + AUR)
pac_updates=$(checkupdates 2>/dev/null | wc -l)
aur_updates=$(yay -Qu 2>/dev/null | wc -l)
updates=$(( pac_updates + aur_updates ))

# Only output JSON if there are updates
if [ "$updates" -gt 0 ]; then
    echo "{\"text\": \"$updates\", \"tooltip\": \"$updates updates available\", \"class\": \"updates\"}"
fi
