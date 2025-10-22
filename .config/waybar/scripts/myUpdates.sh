#!/usr/bin/env bash

# Count pending updates (official + AUR)
pac_updates=$(checkupdates 2>/dev/null | wc -l || echo 0)
aur_updates=$(yay -Qu 2>/dev/null | wc -l || echo 0)
updates=$(( pac_updates + aur_updates ))

# Output JSON
if [ "$updates" -gt 0 ]; then
    echo "{\"text\": \"$updates\", \"tooltip\": \"$updates updates available\", \"class\": \"updates\"}"
else
    echo "{\"text\": \"\"}"
fi
